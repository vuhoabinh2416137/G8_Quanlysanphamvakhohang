# 12 - Biểu đồ Lớp Thiết kế Chi tiết (Design Class Diagram)

## Tổng quan và Yêu cầu Thiết kế

Theo giáo trình **IT3120 - Ch05 Thiết kế Lớp & Ch06 Mẫu Thiết kế**:
Biểu đồ lớp thiết kế (Design Class Diagram - DCD) là bước hoàn thiện từ biểu đồ lớp phân tích miền sang mô hình phần mềm có thể sinh mã nguồn trực tiếp (Java / C#).

DCD đáp ứng đầy đủ:
1. **Kiểu dữ liệu kỹ thuật và phạm vi truy cập**: `+` (public), `-` (private), `#` (protected), danh sách kiểu trả về, tham số phương thức (`Optional<T>`, `List<T>`, `Double`, `ResponseEntity`).
2. **Nguyên lý thiết kế hướng đối tượng SOLID**:
   - **S (Single Responsibility)**: Tách riêng Controller (tiếp nhận HTTP Request), Service (xử lý nghiệp vụ), DAO (truy vấn CSDL), Entity (lưu giữ trạng thái nghiệp vụ).
   - **O (Open/Closed)**: Mở rộng các chiến lược giá bán (`PricingStrategy`) mà không phải sửa mã nguồn lớp `BanHangService`.
   - **L (Liskov Substitution)**: Lớp trừu tượng `PhieuKho` được kế thừa bởi `PhieuNhapKho` và `PhieuXuatKho`, mọi phương thức thao tác trên `PhieuKho` đều hoạt động đúng khi truyền thể hiện con.
   - **I (Interface Segregation)**: Chia nhỏ các giao diện DAO (`PhieuNhapDAO`, `TonKhoDAO`, `DonBanDAO`) thay vì một DAO khổng lồ.
   - **D (Dependency Inversion)**: `NhapKhoServiceImpl` phụ thuộc vào Interface `PhieuNhapDAO` và Interface `TonKhoService`, giúp dễ dàng Unit Test với Mockito.
3. **Các mẫu thiết kế (GoF Design Patterns)**:
   - **Factory Pattern**: `PhieuKhoFactory` đóng gói logic khởi tạo các loại phiếu kho khác nhau.
   - **Observer Pattern**: `TonKhoSubject` tự động phát thông báo cho các `TonKhoObserver` (`LowStockAlertObserver`, `AuditLogObserver`) mỗi khi lượng tồn kho biến động.
   - **Strategy Pattern**: `PricingStrategy` cho phép thay đổi thuật toán định giá bán linh hoạt giữa bán lẻ chuẩn (`StandardRetailPricingStrategy`) và bán buôn theo hợp đồng doanh nghiệp (`WholesalePricingStrategy`).

---

## Hợp đồng Thông điệp Cốt lõi (Message Contracts)

### 1. Hợp đồng `NhapKhoService.taoPhieuNhapKho(dto: PhieuNhapRequestDTO)`
- **Mục đích**: Lập phiếu nhập kho và cập nhật tăng số lượng hàng trong kho.
- **Tiền điều kiện (Pre-conditions)**:
  - Nhân viên lập phiếu có quyền `NHAP_KHO`.
  - Kho nhận hàng (`dto.maKho`) và các mã sản phẩm (`dto.danhSachMucHang[].maSP`) phải tồn tại trong CSDL.
  - Số lượng thực nhận của từng mặt hàng phải `> 0`.
- **Hậu điều kiện (Post-conditions)**:
  - Bản ghi `PhieuNhapKho` mới được lưu vào CSDL với trạng thái `DA_XAC_NHAN`.
  - Thuộc tính `soLuong` của `TonKho` tương ứng tăng lên đúng bằng số lượng thực nhận.
  - Nếu có liên kết với `DonMuaHang`, trạng thái đơn mua chuyển thành `DA_NHAN_HANG`.
  - Trả về đối tượng `PhieuNhapResponseDTO` chứa mã phiếu tự sinh và tổng giá trị.

### 2. Hợp đồng `TonKhoService.truTonKho(maKho, maSP, soLuong)`
- **Mục đích**: Giảm số lượng tồn vật lý sau khi xuất hàng.
- **Tiền điều kiện**:
  - `soLuong > 0`.
  - Số lượng tồn khả dụng hiện tại `>= soLuong`.
- **Hậu điều kiện**:
  - `TonKho.soLuong = TonKho.soLuong - soLuong`.
  - Nếu `TonKho.soLuong <= SanPham.nguongTonKho`, kích hoạt `notifyObservers(...)` gửi cảnh báo tồn kho thấp.

---

## File nguồn PlantUML
Sơ đồ PlantUML hoàn chỉnh: [design-class-diagram.puml](../plantuml/design-class-diagram.puml).
Render đồ họa:
```bash
java -jar plantuml.jar plantuml/design-class-diagram.puml -o ../diagrams/
```
