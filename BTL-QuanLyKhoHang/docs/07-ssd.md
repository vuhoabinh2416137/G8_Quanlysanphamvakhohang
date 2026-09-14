# 07 - Sơ đồ Tuần tự Mức Hệ thống (System Sequence Diagrams - SSD)

## Khái niệm và Vai trò

Theo giáo trình **IT3120 - Mô hình hóa Hành vi (Behavioral Modeling)**:
- **System Sequence Diagram (SSD)** mô tả tương tác giữa các tác nhân bên ngoài (Actors) và hệ thống trong phạm vi một ca sử dụng (Use Case).
- Hệ thống được coi như một **hộp đen (Black Box)** đại diện bởi đối tượng `:Hệ thống` (`:System`).
- SSD định nghĩa rõ các **sự kiện hệ thống (System Events)** và thông điệp phản hồi (Return Messages / Data Displays).
- Là đầu vào quan trọng để thiết kế giao diện (UI Form/Field) và thiết kế thông điệp chi tiết ở mức thiết kế lớp (Design Sequence Diagrams & Controllers).

---

## 1. SSD cho UC06: Tạo Phiếu Nhập Kho
- **Tác nhân**: Nhân viên kho.
- **Sự kiện chính**:
  1. `yeuCauTaoPhieuNhap()`: Khởi tạo phiên làm việc nhập kho.
  2. `chonDonMuaHang(maDonMua, maKho)`: Liên kết phiếu nhập với Đơn mua hàng gốc.
  3. `nhapMucHang(maSP, soLuongThucNhan, viTriKe)`: Vòng lặp nhập chi tiết từng mặt hàng và định vị kệ lưu kho.
  4. `xacNhanHoanTatPhieuNhap(ghiChu)`: Chốt phiếu và thực thi ghi sổ tồn kho.

---

## 2. SSD cho UC07: Tạo Phiếu Xuất Kho
- **Tác nhân**: Nhân viên kho.
- **Sự kiện chính**:
  1. `yeuCauTaoPhieuXuat()`: Lấy danh sách đơn bán hàng hoặc lệnh điều chuyển chờ xuất.
  2. `chonDonBanHang(maDonBan)`: Tải danh mục mặt hàng cần nhặt (Pick-list).
  3. `xacNhanQuetMaVach(maSP, maVach, soLuongXuat)`: Xác thực đúng sản phẩm vật lý trước khi xuất.
  4. `xacNhanXuatKho()`: Ghi nhận giảm tồn kho, tự động kích hoạt cảnh báo tồn kho thấp nếu chạm ngưỡng an toàn.

---

## 3. SSD cho UC17: Tạo Đơn Bán Hàng
- **Tác nhân**: Nhân viên bán hàng, Hệ thống thanh toán bên ngoài (Payment Gateway).
- **Sự kiện chính**:
  1. `moGiaoDienBanHang()`: Mở màn hình POS / bán hàng.
  2. `timKiemKhachHang(sdt_hoac_maKH)`: Nạp thông tin khách hàng và hạn mức công nợ.
  3. `themSanPham(maSP, soLuong, maKho)`: Kiểm tra tồn khả dụng theo thời gian thực và áp giá.
  4. `chonPhuongThucThanhToan(phuongThuc, soTien)`: Xử lý giao dịch thanh toán qua cổng điện tử hoặc tiền mặt.
  5. `xacNhanDonHang()`: Chốt đơn và in hóa đơn.

---

## 4. SSD cho UC13: Tạo Đơn Mua Hàng
- **Tác nhân**: Nhân viên mua hàng.
- **Sự kiện chính**:
  1. `moFormTaoDonMua()` & `chonNCCVaKhoNhan()`: Chỉ định nhà cung cấp và điểm tập kết hàng.
  2. `themMatHangMua(maSP, soLuong, donGiaDeXuat)`: Lập danh sách mặt hàng và số lượng đề xuất.
  3. `guiDonMuaHang(ghiChu)`: Chuyển đơn sang trạng thái `CHO_DUYET` gửi Quản lý kho.

---

## 5. SSD cho UC09: Kiểm Kê Kho
- **Tác nhân**: Quản lý kho, Nhân viên kho.
- **Sự kiện chính**:
  1. `taoPhienKiemKe(maKho, danhMuc)`: Chốt số liệu sổ sách và khóa giao dịch liên quan.
  2. `nhapSoLuongKiemDem(maPhien, maSP, soLuongThucTe)`: Nhân viên kho cập nhật số đếm thực địa.
  3. `yeuCauBaoCaoChenhLech(maPhien)`: Hệ thống tổng hợp báo cáo sai số.
  4. `xacNhanDieuChinhKho(maPhien, lyDo)`: Cân bằng tồn kho và tự sinh các phiếu điều chỉnh.

---

## File nguồn PlantUML
File PlantUML hoàn chỉnh: [ssd.puml](../plantuml/ssd.puml).
Render đồ họa:
```bash
java -jar plantuml.jar plantuml/ssd.puml -o ../diagrams/
```
