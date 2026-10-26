# Wrapper Tiny Tapeout — H03_SPI_Mode0_24101170

Top module: `tt_um_h03_spi_mode0`.
Wrapper tái sử dụng cách ánh xạ chân của H03_SPI_Mode0_Improved;
kết quả chạy mới phải được tạo từ mã nguồn phiên bản hiện tại.

## Vì sao phải chia RX

Ánh xạ trong đề gốc vừa dùng uio[0:1] cho START/MISO đầu vào,
vừa dùng toàn bộ uio[7:0] làm RX đầu ra. Các tín hiệu đó dùng chung
chân vật lý, vì vậy không thể đồng thời cấp hai chiều như vậy.
Wrapper giữ START và MISO là đầu vào, rồi chia byte RX qua các chân
đầu ra còn trống. Không ghép BUSY/DONE vào byte RX.

| Chân | Chiều | Chức năng |
|---|---|---|
| ui_in[7:0] | Input | TX_DATA[7:0] |
| uio[0] | Input | START |
| uio[1] | Input | MISO |
| uo_out[0] | Output | SCLK |
| uo_out[1] | Output | MOSI |
| uo_out[2] | Output | CS_N |
| uo_out[7:3] | Output | RX_DATA[4:0] |
| uio[4:2] | Output | RX_DATA[7:5] |
| uio[5] | Output | BUSY |
| uio[6] | Output | DONE |
| uio[7] | Input, không dùng | Không lái chân |

`uio_oe = 8'h7C`: bit 1 bật lái đầu ra, bit 0 giữ chân làm đầu vào.
Phần mềm/thiết bị ngoài ghép byte RX bằng `{uio[4:2], uo_out[7:3]}`.

ENA chỉ cho phép nhận START: `start_core = ena && uio_in[0]`.
Hạ ENA sau khi đã nhận lệnh không hủy frame; reset đồng bộ có thể hủy frame.
Giữ START cao có thể tạo frame mới khi lõi trở lại IDLE và ENA vẫn bằng 1.

## Kiểm tra wrapper

`h03_wrapper_tb` kiểm 13 tình huống ở cấu hình mặc định H=4, MSB-first:
reset/pinmap, START khi ENA=0, bật ENA với START đang cao, hai frame dữ liệu,
hạ ENA giữa frame, START lặp lúc BUSY, START giữ cao tạo hai frame riêng,
hạ ENA khi START giữ cao, chặn retrigger khi ENA=0, reset đồng bộ giữa frame,
và truyền sau reset.

Testbench mô hình hóa chân UIO bằng bus tri-state để kiểm hướng và tránh
tranh chấp START/MISO; quan sát MOSI/SCLK/CS và ghép lại RX qua đúng chân.
Mỗi frame hoàn tất kiểm tám cạnh lên/tám cạnh xuống, pha SCLK,
MOSI chỉ đổi ở cạnh phát, RX giữ đến DONE và độ trễ `16*H+1` chu kỳ clk.

Đây là kiểm thử logic adapter và giao thức theo các tình huống nêu trên;
không phải kiểm chứng điện pad hoặc chứng nhận tích hợp shuttle Tiny Tapeout.
