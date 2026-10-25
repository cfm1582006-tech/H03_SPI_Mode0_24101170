# Specification — H03_SPI_Mode0_24101170

## Phạm vi

Đặc tả lõi h03_spi_master.
Giao diện wrapper Tiny Tapeout sẽ được bổ sung ở bước tích hợp.

## Cấu hình mô phỏng đầu tiên

- Clock hệ thống clk: chu kỳ 10 ns, tương ứng 100 MHz.
- HALF_CYCLES = 4: mỗi nửa chu kỳ SCLK dài 4 chu kỳ clk.
- SCLK danh định: chu kỳ 80 ns, tương ứng 12,5 MHz.
- MSB_FIRST = 1: truyền và nhận bit 7 trước.
- Mỗi frame truyền và nhận đồng thời 8 bit.

## Giao diện lõi

| Tín hiệu | Chiều | Độ rộng | Ý nghĩa |
|---|---|---|---|
| clk | input | 1 | Clock hệ thống |
| rst_n | input | 1 | Reset đồng bộ, tích cực thấp |
| start | input | 1 | Yêu cầu bắt đầu frame |
| tx_data | input | 8 | Byte cần truyền |
| miso | input | 1 | Dữ liệu nối tiếp từ slave |
| sclk | output | 1 | Clock SPI do master tạo |
| mosi | output | 1 | Dữ liệu nối tiếp gửi tới slave |
| cs_n | output | 1 | Chọn slave, tích cực thấp |
| busy | output | 1 | Lõi đang xử lý frame |
| done | output | 1 | Xung báo hoàn tất frame |
| rx_data | output | 8 | Byte nhận được |

## Quy tắc hoạt động

1. Reset có hiệu lực tại cạnh lên clk khi rst_n=0.
   Reset hủy frame, đưa CS=1, SCLK=0, MOSI=0,
   BUSY=0, DONE=0 và RX_DATA=0.

2. Khi IDLE, start=1 tại cạnh lên clk sẽ bắt đầu frame.
   Lõi chốt tx_data, hạ CS, bật BUSY và xuất bit MOSI đầu tiên.

3. START khi đang bận không được xếp hàng.
   Nếu giữ START cao đến khi lõi trở lại IDLE, frame mới sẽ bắt đầu.

4. SCLK nghỉ ở mức 0.
   Lõi lấy mẫu MISO tại cạnh lên SCLK.
   MOSI chuyển sang bit tiếp theo tại bảy cạnh xuống đầu tiên.

5. Mỗi frame hoàn chỉnh có đúng 8 cạnh lên và 8 cạnh xuống SCLK.
   CS vẫn thấp tại cạnh xuống SCLK cuối cùng.

6. Một chu kỳ clk sau cạnh xuống SCLK cuối:
   CS lên 1, BUSY xuống 0, RX_DATA cập nhật và DONE lên 1.

7. DONE dài đúng một chu kỳ clk.
   RX_DATA giữ kết quả gần nhất đến lần hoàn tất sau hoặc reset.

8. Thay đổi tx_data sau khi nhận START không ảnh hưởng frame đang chạy.

## Timing dự kiến với HALF_CYCLES=4

Lấy cạnh lên clk nhận START làm mốc E(0).
Giá trị được xét sau khi thanh ghi cập nhật.

| Mốc | Hành vi |
|---|---|
| E(0) | Chốt TX, CS=0, BUSY=1, xuất bit MOSI đầu |
| E(4) | SCLK lên lần đầu, lấy mẫu bit MISO đầu |
| E(60) | SCLK lên lần thứ tám, lấy mẫu bit MISO cuối |
| E(64) | SCLK xuống lần thứ tám, CS vẫn thấp |
| E(65) | CS=1, BUSY=0, RX cập nhật, DONE=1 |

Thời gian từ nhận START đến DONE dự kiến: 65 chu kỳ clk = 650 ns.

## Trạng thái

Đây là hành vi cần kiểm chứng.
Chưa có kết quả mô phỏng cho phiên bản này.
