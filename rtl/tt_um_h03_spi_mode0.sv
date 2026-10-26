`timescale 1ns/1ps

// Tiny Tapeout port adapter. Pin map reused from H03_SPI_Mode0_Improved.
// The two low UIO pins stay inputs; RX is split over the remaining outputs.
module tt_um_h03_spi_mode0 #(
    parameter int HALF_CYCLES = 4,
    parameter bit MSB_FIRST = 1'b1
) (
    input  wire [7:0] ui_in,
    output wire [7:0] uo_out,
    input  wire [7:0] uio_in,
    output wire [7:0] uio_out,
    output wire [7:0] uio_oe,
    input  wire       ena,
    input  wire       clk,
    input  wire       rst_n
);
    wire mosi, sclk, cs_n, busy, done;
    wire [7:0] rx_data;

    // ENA controls admission. A frame already accepted finishes unless reset.
    h03_spi_master #(.HALF_CYCLES(HALF_CYCLES), .MSB_FIRST(MSB_FIRST)) core (
        .clk(clk), .rst_n(rst_n), .start(ena && uio_in[0]),
        .tx_data(ui_in), .miso(uio_in[1]), .mosi(mosi),
        .sclk(sclk), .cs_n(cs_n), .rx_data(rx_data), .busy(busy), .done(done)
    );

    assign uo_out = {rx_data[4:0], cs_n, mosi, sclk};
    assign uio_out = {1'b0, done, busy, rx_data[7:5], 2'b00};
    assign uio_oe = 8'b01111100;

    wire _unused = &{1'b0, uio_in[7:2]};
endmodule
