# 08 - Sơ đồ Tuần tự Mức Thiết kế (Design Sequence Diagrams)

## Mục đích và Nguyên tắc Thiết kế (GRASP)

Theo giáo trình **IT3120 - Ch04 Mô hình hóa Hành vi & Ch05 Thiết kế Lớp**:
Khác với SSD chỉ nhìn hệ thống ở mức hộp đen, **Sơ đồ tuần tự mức thiết kế (Design Sequence Diagram)** mở hộp đen của hệ thống và phân bổ trách nhiệm cụ thể cho từng thành phần phần mềm.

Các nguyên lý **GRASP (General Responsibility Assignment Software Patterns)** được áp dụng chặt chẽ:
1. **Controller (Bộ điều khiển)**: Lớp điều khiển (`NhapKhoController`, `BanHangController`, `KiemKeController`) nhận các sự kiện hệ thống từ tầng giao diện (Boundary/UI), không chứa logic nghiệp vụ phức tạp mà ủy quyền (delegate) cho tầng Dịch vụ (`Service`).
2. **Creator (Bộ tạo đối tượng)**: Đối tượng container tạo các đối tượng con mà nó quản lý/hợp thành (`PhieuNhapKho` tạo `MucNhap`, `DonBanHang` tạo `MucBan`).
3. **Information Expert (Chuyên gia thông tin)**: Đối tượng nào nắm giữ dữ liệu cần thiết thì chịu trách nhiệm tính toán logic đó (`MucNhap` tự tính `thanhTien`, `PhieuNhapKho` tính `tongGiaTri`, `MucKiemKe` tính `chenhLech = thucTe - soHeThong`).
4. **Low Coupling & High Cohesion (Kết nối lỏng & Gắn kết cao)**: Tách biệt rõ ràng giữa logic nghiệp vụ (`Service`), thực thể dữ liệu (`Entity`) và tầng truy xuất cơ sở dữ liệu (`DAO / Repository`).

---

## 1. Sơ đồ Tuần tự: Tạo Phiếu Nhập Kho (UC06)
- **Luồng điều khiển**:
  1. `NhapKhoUI` gửi DTO (Data Transfer Object) tới `NhapKhoController`.
  2. `NhapKhoController` gọi `NhapKhoService.taoPhieuNhapKho(dto)`.
  3. `NhapKhoService` khởi tạo thực thể `PhieuNhapKho`, lặp qua từng mục hàng để tạo `MucNhap` và tính thành tiền.
  4. Lưu thông tin phiếu thông qua `PhieuNhapDAO.save(pnk)`.
  5. Gọi `TonKhoService.congTonKho(...)` để cập nhật số lượng tồn tại từng kho tương ứng.
  6. Nếu đơn nhập xuất phát từ Đơn mua hàng (`DonMuaHang`), cập nhật trạng thái đơn mua sang `DA_NHAN_HANG`.

---

## 2. Sơ đồ Tuần tự: Xử lý Đơn Bán Hàng & Xuất Kho (UC17 + UC07)
- **Luồng điều khiển**:
  1. `BanHangUI` nhận tương tác chốt đơn và gửi `OrderDTO` tới `BanHangController`.
  2. `BanHangService` phối hợp với `TonKhoService` để xác thực tồn khả dụng trước khi ghi nhận đơn.
  3. Khởi tạo `DonBanHang` và các `MucBan`.
  4. Nếu khách hàng chọn thanh toán trực tuyến, gọi cổng `PaymentService.thanhToan(...)`.
  5. Lưu đơn bán qua `DonBanDAO`.
  6. Giảm tồn kho thông qua `TonKhoService`. Trong quá trình giảm tồn, nếu phát hiện tồn kho < ngưỡng an toàn, `TonKhoService` gọi `NotificationService` kích hoạt cảnh báo tới Quản lý kho.

---

## 3. Sơ đồ Tuần tự: Phê duyệt Kết quả Kiểm kê (UC09)
- **Luồng điều khiển**:
  1. `Quản lý kho` gửi danh sách giải trình và lệnh phê duyệt qua `KiemKeUI` tới `KiemKeController`.
  2. `KiemKeService` tải phiên kiểm kê từ `KiemKeDAO`.
  3. Duyệt từng mục kiểm kê:
     - Nếu `chenhLech > 0` (thừa hàng): Tự động gọi `PhieuNhapDAO.taoPhieuNhapDieuChinh(...)` và tăng tồn kho.
     - Nếu `chenhLech < 0` (thiếu hàng): Tự động gọi `PhieuXuatDAO.taoPhieuXuatDieuChinh(...)` và giảm tồn kho.
  4. Đóng phiên kiểm kê và ghi nhận kết quả.

---

## File nguồn PlantUML
Sơ đồ PlantUML hoàn chỉnh: [sequence-diagrams.puml](../plantuml/sequence-diagrams.puml).
Render thành hình ảnh:
```bash
java -jar plantuml.jar plantuml/sequence-diagrams.puml -o ../diagrams/
```
