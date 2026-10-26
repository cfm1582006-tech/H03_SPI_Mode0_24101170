# Chạy lại mô phỏng trên Windows

Script dành cho testbench hiện tại: năm ca dữ liệu, `HALF_CYCLES=4`,
`MSB_FIRST=1`, clock mô phỏng 100 MHz. Script không sửa RTL hoặc testbench.

## Công cụ và cách chạy

Cần Git, Icarus Verilog (`iverilog`, `vvp`) trong PATH.
GTKWave chỉ cần khi chọn `-OpenWave`.
Chạy các lệnh sau từ thư mục gốc repository:

```powershell
Get-Command git,iverilog,vvp | Select-Object Name,Source
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\run_sim.ps1 -RunName sim_004_auto
$LASTEXITCODE
```

`-ExecutionPolicy Bypass` chỉ áp dụng cho tiến trình PowerShell này;
lệnh không thay đổi thiết lập ExecutionPolicy lưu trên máy.
Nếu máy có chính sách quản trị chặn script, giữ nguyên thông báo lỗi để xử lý.

Có thể bỏ `-RunName` để script tự tạo tên theo thời gian, hoặc thêm
`-OpenWave` để mở VCD bằng GTKWave sau khi kiểm tra thành công:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\run_sim.ps1 -OpenWave
```

Script xác định gốc dự án theo vị trí của nó, nên không phụ thuộc thư mục
đang đứng khi gọi bằng đường dẫn đầy đủ.

## Script thực hiện những gì

1. Kiểm tra công cụ, mã nguồn và tên run. Nếu thư mục run đã tồn tại thì dừng,
   giữ nguyên evidence cũ.
2. Ghi Git HEAD, trạng thái working tree, phiên bản công cụ và SHA-256 của
   hai file nguồn cùng script runner.
3. Biên dịch bằng `iverilog -g2012 -Wall -s h03_spi_master_tb`.
   Nếu compiler trả lỗi thì dừng trước mô phỏng.
4. Chạy `vvp`, lưu VCD và log.
5. Kiểm simulator trả 0, có đúng năm dòng `CASE PASS`, đúng một dòng tổng kết
   `SIMULATION PASS cases=5 HC=4 ORDER=1`, và có VCD không rỗng.

Đây là kiểm tra kết quả testbench đang có. Nếu mở rộng số ca hoặc cấu hình
testbench, cần sửa điều kiện tổng kết trong runner và workflow CI tương ứng.

## Đọc evidence

Ví dụ với tên `sim_004_auto`, các file nằm tại
`evidence/runs/sim_004_auto/`:

| File | Ý nghĩa |
|---|---|
| `compile.log`, `compile_exit.txt` | Thông báo và mã thoát compiler. Log rỗng có thể là bình thường khi biên dịch thành công. |
| `simulation.log`, `simulation_exit.txt` | Kết quả từng ca và mã thoát simulator. |
| `sample_mode0.vcd` | Dữ liệu waveform để mở trong GTKWave. |
| `validation.txt` | Kết quả kiểm tra của runner, gồm số dòng PASS. |
| `commit.txt`, `git_status.txt` | HEAD tại lúc chạy và các thay đổi cục bộ. HEAD không tự đại diện cho file đang sửa chưa commit. |
| `sources.sha256`, `runner.sha256` | Hash byte thực tế của RTL, testbench và runner đã dùng. |
| `tool_versions.txt`, `*_version.txt` | Phiên bản công cụ cùng mã thoát lệnh lấy phiên bản. |
| `run_info.txt` | Tên run, thời gian UTC, phiên bản PowerShell và cấu hình mong đợi. |
| `simulation.vvp` | Chương trình mô phỏng đã biên dịch, có thể tạo lại từ nguồn. |

Khi thành công, console kết thúc bằng `RUNNER PASS: ...`,
`validation.txt` có `RESULT=PASS`, và `$LASTEXITCODE` bằng 0.
Khi thất bại sau khi tạo run, script giữ log, ghi `RESULT=FAIL` và trả 1.
Lỗi preflight (thiếu tool, tên run trùng...) dừng trước khi tạo run mới.

Hash phân biệt cả thay đổi LF/CRLF. Nếu hash khác, hãy xem nội dung và
line ending trước khi kết luận logic nguồn khác nhau.

## Lưu mốc lên GitHub

`evidence/runs/` đã nằm trong `.gitignore`.
Mốc công khai hiện có là [sim_003](../evidence/sim_003) và
[CI #2](../evidence/ci_002); không cần tải xuống và commit mọi lần CI mới.

Script và tài liệu vẫn được commit bình thường. Luôn stage đường dẫn cụ thể
để tránh đưa ảnh thử hoặc file sinh tự động chưa kiểm tra vào repository.
