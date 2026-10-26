# Ket qua wrapper va RTL den GDSII

Tag: `physical_001`. Xem [pipeline.json](../evidence/physical_001/pipeline.json) va
[bao cao physical](../evidence/physical_001/summary.md) de truy lenh, hash va tool.

- RTL core: 5 ca PASS, H=4, MSB-first.
- RTL wrapper: 13 tinh huong PASS, gom pinmap/OE, START/ENA va reset giua frame.
- Functional gate simulation: 13 tinh huong PASS, KHONG SDF.
- LibreLane Classic, SKY130A / sky130_fd_sc_hd, clock phan tich 10 ns.
- Setup worst slack: 3.618669 ns; hold worst slack: 0.111286 ns.
- Magic DRC=0, KLayout DRC=0, LVS error=0; 9 RC/PVT corners duoc kiem tra.
- Die area: 6527.41 um^2; final standard cells: 282.
- Power uoc luong: 0.530224 mW (hoat dong mac dinh cua tool).

Day la macro doc lap. Chua chung minh formal equivalence, timing SPI ngoai chip
hoac tich hop tile/harness Tiny Tapeout. Clock 10 ns khong phai ket luan Fmax.
Bao cao va slide do nguoi hoc tu thuc hien.
