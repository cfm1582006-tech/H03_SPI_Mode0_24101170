# Requirements — H03_SPI_Mode0_24101170

## Phạm vi

Thiết kế SPI Master Mode 0, truyền và nhận đồng thời một byte.
Thực hiện mô phỏng và flow RTL đến GDSII.
Kiểm chứng bằng công cụ phần mềm, không dùng board FPGA.

## Yêu cầu và bằng chứng dự kiến

| ID | Yêu cầu | Bằng chứng cần tạo |
|---|---|---|
| R01 | SPI Master Mode 0: CPOL=0, CPHA=0; truyền/nhận 8 bit | Testbench tự kiểm tra và waveform |
| R02 | Có bảng giao diện; ánh xạ wrapper Tiny Tapeout không xung đột chân | Đặc tả giao diện và kiểm thử wrapper |
| R03 | Truyền các byte 00, FF, A5; đồng thời nhận byte biết trước và so sánh đúng | Log kết quả từng ca kiểm thử |
| R04 | Với frame hoàn chỉnh, CS tích cực thấp bao trọn 8 chu kỳ SCLK | Checker đếm cạnh và waveform |
| R05 | Có ít nhất 2 ca kiểm thử bổ sung, gồm ca biên; giải thích lỗi cần phát hiện | Testplan và log kiểm thử |
| R06 | Giải thích cạnh phát, cạnh lấy mẫu và khoảng setup danh định | Waveform mô phỏng thật có chú thích |
| R07 | Giải thích FSM, bộ chia xung và thanh ghi dịch | Tài liệu kiến trúc và mã RTL |
| R08 | Thực hiện flow RTL đến GDSII; đọc synthesis, timing, power, DRC/LVS và layout | Log, báo cáo, cấu hình và artifacts; nếu lỗi thì lưu chẩn đoán |
| R09 | Có repository GitHub, lịch sử commit và lần chạy CI thực tế | URL repository, commit và CI run |
| R10 | Trình bày requirements, spec, architecture và evidence | Báo cáo và slide dẫn đúng kết quả thực chạy |

## Trạng thái

Đã có kết quả mô phỏng năm ca ở HALF_CYCLES=4, MSB_FIRST=1;
evidence được lưu tại sim_003 và CI #2.
Bảng trên giữ nguyên yêu cầu của đề tài; trạng thái từng yêu cầu và
giới hạn kiểm chứng xem [bảng đối chiếu](verification_matrix.md).
Wrapper và flow RTL đến GDSII chưa được thực hiện cho phiên bản này.

Các lựa chọn về thứ tự bit, bộ chia xung, START, reset,
BUSY và DONE được ghi trong tài liệu specification.
