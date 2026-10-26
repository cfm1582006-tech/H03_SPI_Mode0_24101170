# Flow RTL đến GDSII của H03

Chặng này harden macro `tt_um_h03_spi_mode0`, gồm wrapper và lõi SPI,
bằng LibreLane Classic với sky130A/sky130_fd_sc_hd. Clock phân tích 10 ns;
H=4 và MSB-first theo mã wrapper. Đây là macro độc lập; chưa tích hợp
harness/tile Tiny Tapeout và chưa phải signoff chế tạo.

## Môi trường hiện có

- Ubuntu WSL; AppImage `/home/duongluong/librelane-devshell-x86_64.AppImage`.
- PDK root `/home/duongluong/.ciel/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71`.
- PDK root phải chứa thư mục `sky130A`.
- Cấu hình ở `flow/config_wrapper.json`, SDC ở `flow/wrapper.sdc`.

AppImage cấp môi trường EDA cho câu lệnh phía sau. Dùng tag và thư mục
evidence mới cho mỗi lần chạy. Không chọn run cũ chỉ vì nó có GDS.

## Chạy gói đầy đủ từ PowerShell

```powershell
wsl -d Ubuntu -- bash /mnt/d/H03_SPI_Mode0/DL_24101170_H03/scripts/run_physical.sh physical_001
```

Runner kiểm năm ca core và 13 tình huống wrapper trước Classic, sau đó kiểm
13 tình huống trên netlist cuối với models SKY130 (`FUNCTIONAL`, không SDF).
Kết luận tổng thể nằm trong `evidence/physical_001/pipeline.json`.
Collector ghi riêng kết luận physical vào `summary.json`/`summary.md` cùng
các report/artifact trong cùng thư mục evidence. Chỉ sau khi toàn bộ PASS,
runner mới sinh `docs/physical_results.md` và cập nhật tiến độ.

Raw files ở `flow/runs/physical_001` và `evidence/runs/physical_001` được giữ
để chẩn đoán, không ghi đè. Những lần sau chọn tag khác.

## Các bước công cụ

1. Synthesis: RTL → netlist cell; đọc `yosys-synthesis/reports/stat.rpt`.
2. Floorplan, placement, CTS và routing: đặt cell, tạo cây clock, nối dây.
3. RC extraction và multi-corner STA: kiểm setup/hold, slew và capacitance.
4. Magic/KLayout streamout và DRC; Netgen LVS; so XOR hai bản streamout.
5. Thu thập netlist, DEF, GDS, SDC, SPEF/SDF và báo cáo có hash.

Cấu hình dùng uncertainty 0,25 ns; input/output delay min 0,2 ns, max 1 ns;
input transition 0,15 ns và tải đầu ra 0,033442 pF. Max transition 0,75 ns,
max fanout 8. Đây là giả định phân tích block; chưa là timing giao tiếp với
một chip slave hoặc bo mạch cụ thể.

Linter vẫn kiểm RTL và coi cảnh báo không được miễn là lỗi. Cấu hình miễn
`TIMESCALEMOD` cho blackbox do tool tạo từ thư viện PDK, bên cạnh các miễn
`UNDRIVEN`/`UNUSEDSIGNAL` mặc định của blackbox. Không miễn `TIMESCALEMOD`
cho toàn bộ RTL, không nới ràng buộc timing; giữ log lần lỗi đầu để đối chiếu.

## Lệnh trực tiếp trong shell Ubuntu

Đứng ở gốc bản sao dự án dành cho lần chạy mới, thay tag ví dụ nếu đã tồn tại:

```bash
H03_PDK=/home/duongluong/.ciel/ciel/sky130/versions/8afc8346a57fe1ab7934ba5a6056ea8b43078e71
H03_EDA=/home/duongluong/librelane-devshell-x86_64.AppImage
H03_TAG=physical_001_wrapper
test ! -e "flow/runs/$H03_TAG" || exit 1
"$H03_EDA" librelane --manual-pdk --pdk-root "$H03_PDK" \
  --jobs 4 --condensed --run-tag "$H03_TAG" flow/config_wrapper.json
H03_FLOW_EXIT=$?
python3 scripts/collect_physical.py --run-dir "flow/runs/$H03_TAG" \
  --out evidence/runs/physical_001 --flow-exit "$H03_FLOW_EXIT"
```

Nếu shell đang bật `set -e`, phải giữ mã lỗi bằng nhánh `|| H03_FLOW_EXIT=$?`
để vẫn có thể lưu chẩn đoán khi LibreLane thất bại. Runner tự động của gói
cần lưu riêng lệnh, exit, phiên bản tool và snapshot/hash đầu vào trước khi chạy.

## Đọc kết quả

`collect_physical.py` chỉ đọc raw run; không gọi tool, không sửa kết quả và
không ghi đè thư mục output cũ. `summary.json` và `summary.md` ghi kết luận
của các kiểm tra cụ thể, kèm đường dẫn nguồn và SHA-256 của các tệp đã chép.

Điều kiện PASS gồm: LibreLane exit 0; top/clock/PDK đúng; CTS, Magic/KLayout
DRC, LVS, XOR và MCSTA được bật; đủ chín corner RC/PVT; setup/hold/slew/cap
count bằng 0 ở từng corner; worst slack không âm; các violation tổng bằng 0;
có các final views và báo cáo synthesis, STA/power, DRC, LVS, XOR.

Chỉ có file GDS chưa đủ kết luận PASS. Khi FAIL, đọc danh sách failures và
report được giữ; không đổi giới hạn hoặc bỏ check chỉ để tạo dấu PASS.

Synthesis cell count khác final standard-cell count vì flow có thêm buffer
clock, sửa timing và các cell phục vụ triển khai. Die area khác tổng diện tích
standard cell. Power metric có đơn vị W và là ước lượng theo hoạt động của
công cụ, không phải công suất đo hoặc workload SPI đã chú thích switching.

Collector không chứng minh formal equivalence. `RUN_EQY=false` trong cấu hình
không được gọi là proof PASS. Mô phỏng chức năng RTL/wrapper/gate, nếu thực hiện,
được lưu riêng với nguồn và log của lần chạy tương ứng. Kiểm timing điện
ngoài chip, harness/tile và chế tạo nằm ngoài kết luận macro này.
