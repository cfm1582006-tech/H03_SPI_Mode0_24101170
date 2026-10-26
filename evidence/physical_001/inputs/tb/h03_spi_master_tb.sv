`timescale 1ns/1ps

module h03_spi_master_tb;
    localparam integer HC = 4;
    localparam integer HALF_PERIOD_NS = 10 * HC;
    localparam integer LATENCY_CYCLES = 16 * HC + 1;

    logic clk = 0;
    always #5 clk = ~clk;

    logic rst_n = 0, start = 0, miso = 0;
    logic [7:0] tx_data = 0;
    wire mosi, sclk, cs_n, busy, done;
    wire [7:0] rx_data;

    h03_spi_master #(.HALF_CYCLES(HC), .MSB_FIRST(1'b1)) dut (
        .clk(clk), .rst_n(rst_n), .start(start), .tx_data(tx_data),
        .miso(miso), .mosi(mosi), .sclk(sclk), .cs_n(cs_n),
        .rx_data(rx_data), .busy(busy), .done(done)
    );

    logic [7:0] expected_tx = 0, expected_rx = 0;
    logic [7:0] observed_tx = 0, previous_rx = 0;
    bit frame_active = 0;
    integer slave_bit = 7, rises = 0, falls = 0;
    time accepted_at, last_sclk_edge;
    string vcd_path;

    // Independent slave: preload bit 7, then update on falling SCLK edges.
    always @(negedge cs_n) begin
        if (rst_n === 1'b1) begin
            slave_bit = 7;
            miso = expected_rx[slave_bit];
        end
    end

    always @(negedge sclk) begin
        if (rst_n === 1'b1 && cs_n === 1'b0 && slave_bit > 0) begin
            slave_bit = slave_bit - 1;
            miso = expected_rx[slave_bit];
        end
    end

    // Observe the pins; do not inspect the DUT's internal shift registers.
    always @(posedge sclk or negedge sclk) begin
        if (rst_n === 1'b1) begin
            if (!frame_active || cs_n !== 1'b0 || busy !== 1'b1)
                $fatal(1, "SCLK changed outside an active selected frame");
            if (($time - last_sclk_edge) !== time'(HALF_PERIOD_NS))
                $fatal(1, "SCLK half-period or first-edge delay is not 40 ns");
            last_sclk_edge = $time;

            if (sclk === 1'b1) begin
                rises = rises + 1;
                if (rises > 8 || mosi !== expected_tx[8-rises])
                    $fatal(1, "MOSI mismatch at rising edge %0d", rises);
                observed_tx = {observed_tx[6:0], mosi};
            end else if (sclk === 1'b0) begin
                falls = falls + 1;
                if (falls > 8)
                    $fatal(1, "Too many falling SCLK edges");
            end else begin
                $fatal(1, "SCLK contains X/Z");
            end
        end
    end

    // Sample after nonblocking assignments have updated registered outputs.
    always @(posedge clk) begin
        #1;
        if (rst_n === 1'b1 &&
            (^{mosi, sclk, cs_n, rx_data, busy, done}) === 1'bx)
            $fatal(1, "An output contains X/Z after reset");
    end

    task automatic run_frame(input logic [7:0] tx_byte,
                             input logic [7:0] slave_byte);
        integer cycle;
        time sample_edge;
        begin
            // Host inputs change on falling clk edges, away from DUT sampling.
            @(negedge clk);
            expected_tx = tx_byte;
            expected_rx = slave_byte;
            observed_tx = 0;
            rises = 0;
            falls = 0;
            frame_active = 1;
            tx_data = tx_byte;
            start = 1;

            @(posedge clk);
            accepted_at = $time;
            last_sclk_edge = $time;
            #1;
            if (busy !== 1'b1 || cs_n !== 1'b0 || sclk !== 1'b0 ||
                done !== 1'b0 || mosi !== tx_byte[7])
                $fatal(1, "Incorrect outputs at START acceptance");

            for (cycle = 1; cycle <= LATENCY_CYCLES; cycle = cycle + 1) begin
                @(negedge clk);
                start = 0;
                tx_data = ~tx_byte; // The active frame must use the latched TX.
                @(posedge clk);
                sample_edge = $time;
                #1;
                if (cycle < LATENCY_CYCLES) begin
                    if (busy !== 1'b1 || cs_n !== 1'b0 || done !== 1'b0)
                        $fatal(1, "Frame completed early at cycle %0d", cycle);
                    if (rx_data !== previous_rx)
                        $fatal(1, "RX changed before DONE");
                end else begin
                    if ((sample_edge - accepted_at) !== time'(650) ||
                        done !== 1'b1 || busy !== 1'b0 ||
                        cs_n !== 1'b1 || sclk !== 1'b0)
                        $fatal(1, "Expected DONE and idle bus at 650 ns");
                    if (rises !== 8 || falls !== 8 || observed_tx !== tx_byte)
                        $fatal(1, "Incorrect SCLK count or transmitted byte");
                    if (rx_data !== slave_byte)
                        $fatal(1, "RX mismatch: got %02h expected %02h",
                               rx_data, slave_byte);
                end
            end

            frame_active = 0;
            previous_rx = slave_byte;
            @(negedge clk);
            if (done !== 1'b1)
                $fatal(1, "DONE did not remain high through its clock cycle");
            @(posedge clk); #1;
            if (done !== 1'b0 || busy !== 1'b0 || cs_n !== 1'b1 ||
                sclk !== 1'b0 || rx_data !== previous_rx)
                $fatal(1, "Incorrect idle bus, RX hold, or DONE pulse width");

            $display("CASE PASS TX=%02h RX=%02h rises=%0d falls=%0d latency=%0d",
                     tx_byte, slave_byte, rises, falls, LATENCY_CYCLES);
        end
    endtask

    initial begin
        if (!$value$plusargs("VCD=%s", vcd_path))
            vcd_path = "sample_mode0.vcd";
        $dumpfile(vcd_path);
        $dumpvars(0, clk, rst_n, start, tx_data, expected_tx, expected_rx,
                     mosi, miso, sclk, cs_n, rx_data, busy, done, observed_tx);

        repeat (3) @(posedge clk);
        #1;
        if (sclk !== 1'b0 || cs_n !== 1'b1 || mosi !== 1'b0 ||
            busy !== 1'b0 || done !== 1'b0 || rx_data !== 8'h00)
            $fatal(1, "Incorrect reset outputs");
        @(negedge clk); rst_n = 1;

        run_frame(8'h00, 8'h3C);
        run_frame(8'hFF, 8'h96);
        run_frame(8'hA5, 8'hC3);
        run_frame(8'h96, 8'h69);
        run_frame(8'h01, 8'h80);
        $display("SIMULATION PASS cases=5 HC=4 ORDER=1");
        $finish;
    end

    initial begin
        #10000;
        $fatal(1, "Simulation timeout");
    end
endmodule
