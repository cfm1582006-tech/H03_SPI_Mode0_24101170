# Đối chiếu yêu cầu và bằng chứng

Bảng này đối chiếu requirements với evidence CI #2 của commit
`64f0cc54454bb8cba2594f943957b6847b17d430`: năm ca kiểm thử,
`HALF_CYCLES=4`, `MSB_FIRST=1`, chu kỳ `clk=10 ns`.
“Đạt” chỉ áp dụng trong phạm vi ghi ở từng dòng.

| ID | Yêu cầu / cách kiểm tra | Bằng chứng | Trạng thái và giới hạn |
|---|---|---|---|
| R01 | SPI Mode 0, truyền/nhận 8 bit; đối chiếu MOSI và byte RX | [Testbench](../tb/h03_spi_master_tb.sv), [VCD CI](../evidence/ci_002/sample_mode0.vcd) | **Một phần**: năm frame đúng dữ liệu và timing được checker kiểm tra. Chưa có checker riêng bao quát mọi thời điểm đổi MOSI hoặc phân biệt đầy đủ cạnh lấy mẫu MISO. |
| R02 | Giao dien va wrapper khong xung dot chan | [Wrapper](wrapper.md), [pipeline](../evidence/physical_001/pipeline.json) | Dat trong 13 tinh huong H4/MSB-first; chua tich hop tile/harness. |
| R03 | TX=00, FF, A5; RX=3C, 96, C3 | [Log CI](../evidence/ci_002/simulation.log) | **Đạt** trong cấu hình đã chạy. |
| R04 | CS thấp bao trọn tám chu kỳ SCLK | Checker kiểm CS/BUSY tại các cạnh SCLK, đếm tám cạnh lên và tám cạnh xuống; [log](../evidence/ci_002/simulation.log) | **Đạt** với năm frame hoàn chỉnh. |
| R05 | Hai ca bổ sung, gồm ca biên và giải thích lỗi cần phát hiện | TX=96/RX=69, TX=01/RX=80 trong [log](../evidence/ci_002/simulation.log); giải thích bên dưới | **Đạt** với biên vị trí bit đầu/cuối. Các tình huống START/ENA/reset được kiểm thêm ở wrapper; xem physical_results.md. |
| R06 | Giải thích cạnh phát, cạnh lấy mẫu và setup danh định | [Ảnh A5/C3](figures/sim001_a5_c3.png), [mô tả waveform](../README.md#chi-tiết-frame-a5c3) | **Một phần**: đã có sóng và diễn giải cạnh; chưa có ảnh chú thích riêng khoảng setup. Khoảng danh định 40 ns không thay thế kết quả timing vật lý. |
| R07 | Giải thích FSM, divider, thanh ghi dịch | [Architecture](architecture.md), [RTL](../rtl/h03_spi_master.sv) | **Đạt về tài liệu**: đã mô tả ba trạng thái, bộ chia xung và đường TX/RX. |
| R08 | RTL den GDSII, synthesis/STA/power/DRC/LVS/layout | [Ket qua](physical_results.md), [reports](../evidence/physical_001/summary.md) | Dat flow macro duoi rang buoc da cong bo; power la uoc luong. |
| R09 | GitHub, lịch sử commit và CI thực tế | [Repository](https://github.com/cfm1582006-tech/H03_SPI_Mode0_24101170), [CI #2](https://github.com/cfm1582006-tech/H03_SPI_Mode0_24101170/actions/runs/40199246063), [metadata](../evidence/ci_002) | **Đạt** cho mốc mô phỏng hiện tại. |
| R10 | Báo cáo và slide dẫn đúng kết quả | Người học tự thực hiện | Chưa hoàn thành. |

## Mục đích năm ca dữ liệu

| TX | RX từ mô hình slave | Mục đích |
|---|---|---|
| 00 | 3C | Gửi toàn 0; đường nhận vẫn có cả 0 và 1 để so sánh độc lập. |
| FF | 96 | Gửi toàn 1; nhận mẫu khác TX, tránh chỉ kiểm loopback. |
| A5 | C3 | Kiểm mẫu TX có nhiều lần chuyển mức và đối chiếu waveform chi tiết. |
| 96 | 69 | `96` đảo thứ tự bit thành `69`, nên ca này giúp phát hiện TX bị đảo thứ tự. Các TX `00`, `FF`, `A5` đều đối xứng khi đảo bit. |
| 01 | 80 | Với MSB-first, bit 1 ở cuối TX và đầu RX; kiểm hai biên vị trí bit. |

Trong cả năm ca, testbench còn đổi `tx_data` sau khi lệnh đã được nhận để
kiểm việc chốt TX; giữ kết quả RX cũ đến DONE; kiểm DONE dài một chu kỳ;
kiểm nửa chu kỳ SCLK 40 ns và độ trễ hoàn tất 65 chu kỳ clk.
Reset ban đầu cũng được kiểm tra.

## Các hành vi chưa được kiểm thử riêng

- `MSB_FIRST=0` hoặc `HALF_CYCLES` khác 4.
- Glitch giữa các thời điểm checker quan sát; timing điện và trễ sau layout.

## Truy nguồn evidence

- [sim_001](../evidence/sim_001): ba ca đầu, dùng cho hai ảnh waveform đã đưa vào README.
- [sim_003](../evidence/sim_003): năm ca chạy trên Windows.
- [ci_002](../evidence/ci_002): năm ca chạy trên Ubuntu trong GitHub Actions, có commit, phiên bản tool và hash nguồn.
- Các lần chạy mới bằng [runner](../scripts/run_sim.ps1) nằm trong `evidence/runs/`, được Git bỏ qua. Chỉ chọn mốc cần lưu lâu dài; không cần commit lại artifact sau mọi lần CI.

Ba ảnh `sim002_overview.png`, `sim003_overview.png`, `sim004_overview.png`
đang untracked không được dùng làm căn cứ trong bảng này.

## Cap nhat wrapper/physical

Xem [ket qua moi](physical_results.md): 13 tinh huong RTL wrapper va 13 tinh huong functional GLS; day la mốc bo sung cho bang evidence core/CI phia tren.
