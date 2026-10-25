# Bài 01 — Mô phỏng từ RTL và testbench

Dự án: H03_SPI_Mode0_24101170.

## Nguồn mã và phạm vi

- rtl/h03_spi_master.sv: tái sử dụng lõi từ bản H03_SPI_Mode0_Improved của dự án trước; thêm chỉ thị timescale 1ns/1ps, giữ nguyên logic.
- tb/h03_spi_master_tb.sv: testbench học tập được chuẩn bị cho bài này.
- Cấu hình: HALF_CYCLES=4, MSB_FIRST=1, chu kỳ clk=10 ns.
- Ba ca: TX=00/RX=3C; TX=FF/RX=96; TX=A5/RX=C3.
- Byte RX do mô hình slave tạo độc lập với byte TX.

## Chuỗi công cụ

RTL + testbench -> iverilog -> simulation.vvp -> vvp -> simulation.log + sample_mode0.vcd.
GTKWave đọc VCD để hiển thị dạng sóng.

## Kết quả cần lưu

Mỗi lần chạy dùng một thư mục mới trong evidence/runs/, ví dụ sim_001.
Lưu compile.log, compile_exit.txt, simulation.log, simulation_exit.txt, simulation.vvp và sample_mode0.vcd.
Các kết quả do tool sinh được giữ trong thư mục đã bỏ qua bởi .gitignore.
Nguồn RTL, testbench và tài liệu bài học được đưa vào Git.

## Ý nghĩa kết quả

SIMULATION PASS cases=3 HC=4 ORDER=1 chỉ xác nhận ba ca và các checker có trong testbench này.
Bài này chưa kiểm thử toàn bộ không gian dữ liệu, reset giữa frame, START khi bận, wrapper hoặc flow thiết kế vật lý.
Chỉ ghi nhận kết quả của dự án mới sau khi người học tự chạy tool và lưu log tại đúng thư mục dự án.
Ba mẫu TX của bài đầu chưa phân biệt lỗi đảo riêng thứ tự TX; bài sau sẽ bổ sung mẫu không đối xứng. Checker hiện kiểm MOSI tại cạnh lên, chưa kiểm mọi chuyển mức MOSI hoặc chứng minh đầy đủ cạnh lấy mẫu MISO.
