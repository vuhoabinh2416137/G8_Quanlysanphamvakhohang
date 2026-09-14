# 10 - Sơ đồ Gói và Kiến trúc Phân tầng (Package Diagram)

## Cơ sở Lý thuyết

Theo giáo trình **IT3120 - Kiến trúc Hệ thống (System Architecture)**:
- **Biểu đồ gói (Package Diagram)** mô tả cách tổ chức logic của các phần tử mô hình thành các nhóm có liên quan mật thiết (Cohesive packages).
- Hệ thống áp dụng mẫu kiến trúc phân tầng chuẩn 4 tầng (hoặc 5 tầng) theo mô hình chuẩn của OOSAD:
  1. **HCI Layer (Human-Computer Interaction)**: Chịu trách nhiệm tương tác người dùng, hiển thị dữ liệu và tiếp nhận dữ liệu đầu vào.
  2. **Problem Domain (PD) Layer**: Chứa toàn bộ các quy tắc nghiệp vụ cốt lõi (Business Logic), các thực thể mô hình miền (`domain entities`) và các dịch vụ điều phối nghiệp vụ (`services`).
  3. **Data Management (DM) Layer**: Trừu tượng hóa việc lưu trữ dữ liệu cố định (Persistent Storage) thông qua các lớp DAM (Data Access Management) hoặc DAO (Data Access Object), độc lập với hệ quản trị CSDL cụ thể.
  4. **Physical Architecture (PA) Layer**: Đảm nhiệm các kết nối hạ tầng vật lý, mạng, tích hợp dịch vụ bên ngoài (Email SMTP, Cổng thanh toán VNPay, Cơ chế mã hóa JWT).
  5. **Foundation Layer**: Tầng nền tảng chứa các tiện ích dùng chung (Utilities, Custom Exceptions, Formatting, Logging).

---

## Nguyên tắc Phụ thuộc giữa các Tầng (Layering Rules)
- Phụ thuộc một chiều từ trên xuống dưới (Strict Layering hoặc Relaxed Layering):
  - `HCI` phụ thuộc vào `PD` (HCI gọi Controller/Service).
  - `PD` phụ thuộc vào `DM` (để đọc/ghi dữ liệu nghiệp vụ) và `PA` (để gửi email, gọi API thanh toán).
  - Cả `HCI`, `PD`, `DM`, `PA` đều có thể phụ thuộc vào `Foundation`.
  - **Tuyệt đối không có phụ thuộc vòng (Circular Dependencies)** giữa các gói.

---

## Ma trận Trách nhiệm CRUDE theo Gói

| Gói nghiệp vụ (PD Package) | Thực thể quản lý | Phụ thuộc chính | Thao tác CRUDE |
|----------------------------|-------------------|-----------------|----------------|
| `domain.product` | `SanPham`, `DanhMuc` | `dam.SanPhamDAM` | Create, Read, Update, Delete |
| `domain.inventory` | `Kho`, `ViTriKho`, `TonKho`, `PhieuNhapKho`, `PhieuXuatKho`, `PhienKiemKe` | `dam.PhieuNhapKhoDAM`, `dam.TonKhoDAM`, `dam.PhienKiemKeDAM` | Create, Read, Update |
| `domain.purchase` | `DonMuaHang`, `MucMua`, `NhaCungCap` | `dam.DonMuaHangDAM`, `dam.NhaCungCapDAM` | Create, Read, Update |
| `domain.sales` | `DonBanHang`, `MucBan`, `KhachHang` | `dam.DonBanHangDAM`, `dam.KhachHangDAM`, `infrastructure.payment` | Create, Read, Update |
| `domain.identity` | `NhanVien`, `TaiKhoan`, `VaiTro`, `Quyen` | `dam.TaiKhoanDAM`, `infrastructure.security` | Create, Read, Update, Delete |

---

## File nguồn PlantUML
Sơ đồ PlantUML hoàn chỉnh: [package-diagram.puml](../plantuml/package-diagram.puml).
Render hình ảnh:
```bash
java -jar plantuml.jar plantuml/package-diagram.puml -o ../diagrams/
```
