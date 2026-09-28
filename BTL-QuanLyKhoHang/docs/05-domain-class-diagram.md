# 05 - Biểu đồ Lớp Mô hình Lĩnh vực (Domain Model Class Diagram)

## Giới thiệu và Cơ sở Lý thuyết

Theo giáo trình **IT3120 - Mô hình hóa Cấu trúc (Structural Modeling)**, biểu đồ lớp lĩnh vực (Domain Model Class Diagram) nhằm mục đích mô hình hóa các khái niệm thực tế trong bài toán nghiệp vụ mà không phụ thuộc vào công nghệ triển khai (chưa bao gồm Controller, DAO/Repository hay giao diện).

Phương pháp trích xuất lớp áp dụng:
1. **Phân tích ngữ nghĩa văn bản (Textual Analysis / Noun Extraction)**: Danh từ chỉ thực thể/lớp, động từ chỉ thao tác/hành vi, tính từ chỉ trạng thái/thuộc tính.
2. **Các mẫu phân tích chuẩn (Analysis Patterns)**:
   - **Party - Place - Transaction pattern**: Bên tham gia (`PhongBan`, `NhanVien`) - Địa điểm (`Kho`, `ViTriKho`) - Giao dịch (`YeuCauCapPhat`, `PhieuNhapKho`, `PhieuXuatKho`, `PhienKiemKe`).
   - **Order Pattern (Header - Line Item)**: `YeuCauCapPhat` - `ChiTietYeuCau`, `PhieuNhapKho` - `MucNhap`, `PhieuXuatKho` - `MucXuat`.
   - **Catalog - Item Pattern**: `DanhMuc` - `VatTu`, `VatTu` - `TonKho`.

---

## Danh mục các Gói nghiệp vụ và Lớp đối tượng

### 1. Gói Quản lý Vật tư
- `VatTu`: Lưu thông tin thuộc tính cơ bản của vật tư, trang thiết bị (mã, tên, đơn vị tính, quy cách kỹ thuật, ngưỡng tồn kho định mức, trạng thái sử dụng). Hoàn toàn không lưu giá bán hay giá mua thương mại.
- `DanhMuc`: Phân loại cấu trúc vật tư dạng phân cấp (hỗ trợ quan hệ đệ quy `0..1 -- *` để tạo danh mục cha - con).
- `TrangThaiVT`: Enum quy định trạng thái `DANG_SU_DUNG`, `TAM_NGUNG`, `NGUNG_SU_DUNG`.

### 2. Gói Quản lý Kho hàng
- `Kho`: Đại diện cho thực thể kho vật lý (mã kho, tên kho, địa chỉ, số điện thoại, nhân viên quản lý kho).
- `ViTriKho`: Chi tiết vị trí lưu trữ trong kho (khu vực A/B/C, dãy kệ, tầng kệ).
- `TonKho`: Lớp liên kết giữa `Kho` và `VatTu`, quản lý số lượng tồn thực tế của một mặt hàng cụ thể tại một kho cụ thể.
- `PhieuNhapKho` & `MucNhap`: Chứng từ nhập vật tư vào kho và các dòng chi tiết tiếp nhận. Có quan hệ Hợp thành mạnh (Composition `1 *-- 1..*`).
- `PhieuXuatKho` & `MucXuat`: Chứng từ xuất kho cấp phát / chuyển kho và chi tiết từng dòng mặt hàng xuất.
- `PhienKiemKe` & `MucKiemKe`: Biên bản kiểm kê định kỳ/đột xuất, ghi nhận số lượng sổ sách, số lượng thực tế và chênh lệch.

### 3. Gói Quản lý Yêu cầu & Cấp phát Nội bộ
- `YeuCauCapPhat` & `ChiTietYeuCau`: Phiếu đề nghị cấp phát vật tư từ các phòng ban, đơn vị trực thuộc tổ chức.
- `PhongBan`: Đơn vị, phòng ban hoặc bộ phận trong cơ cấu tổ chức có nhu cầu lĩnh vật tư phục vụ công tác.

### 4. Gói Quản lý Nhân sự & Phân quyền (RBAC)
- `NhanVien`: Hồ sơ nhân sự (họ tên, ngày sinh, chức vụ, phòng ban trực thuộc, trạng thái làm việc).
- `TaiKhoan`: Thông tin đăng nhập hệ thống (tên đăng nhập, mật khẩu mã hóa hash, trạng thái khóa/hoạt động).
- `VaiTro` & `Quyen`: Mô hình phân quyền dựa trên vai trò (Role-Based Access Control - RBAC).

---

## Bảng Chi tiết Thuộc tính và Phương thức

| Tên lớp | Thuộc tính chính | Phương thức chính | Mẫu áp dụng |
|---------|------------------|-------------------|-------------|
| **VatTu** | `maVT`, `tenVT`, `donViTinh`, `quyCach`, `nguongTonKho`, `trangThai` | `layThongTin()`, `capNhat()`, `kiemTraTonKho()` | Entity / Item |
| **PhieuXuatKho** | `maPhieu`, `ngayXuat`, `lyDoXuat`, `ghiChu`, `trangThai` | `xacNhan()`, `huyPhieu()` | Transaction Header |
| **MucXuat** | `soLuongYeuCau`, `soLuongThucXuat`, `ghiChu` | — | Line Item |
| **TonKho** | `soLuong`, `ngayCapNhat` | `tang()`, `giam()`, `kiemTraNguong()` | Association Class |
| **PhieuNhapKho** | `maPhieu`, `ngayNhap`, `lyDoNhap`, `nguonNhap`, `trangThai` | `xacNhan()`, `huyPhieu()` | Transaction Header |
| **MucNhap** | `soLuong`, `viTriKe`, `ghiChu` | — | Line Item |
| **YeuCauCapPhat** | `maYeuCau`, `ngayYeuCau`, `ngayDuyet`, `mucDichSuDung`, `trangThai` | `guiYeuCau()`, `duyet()`, `tuChoi()` | Order Pattern |
| **ChiTietYeuCau** | `soLuongYeuCau`, `soLuongDuyet`, `ghiChu` | — | Line Item |
| **PhongBan** | `maPhongBan`, `tenPhongBan`, `dienThoai`, `diaDiem`, `trangThai` | `layDanhSachYeuCau()` | Entity / Party |
| **PhienKiemKe** | `maPhien`, `ngayKiemKe`, `phamVi`, `trangThai` | `taoPhieuDieuChinh()` | Transaction |
| **MucKiemKe** | `soLuongHeThong`, `soLuongThucTe`, `chenhLech`, `lyDo` | `tinhChenhLech()` | Line Item |

---

## Cơ số và Ý nghĩa các Quan hệ (Multiplicities & Relationships)

1. **Composition (Quan hệ Hợp thành `1 *-- 1..*`)**:
   - `YeuCauCapPhat` hợp thành `ChiTietYeuCau`: Một yêu cầu cấp phát phải có ít nhất 1 dòng mặt hàng.
   - `PhieuNhapKho` hợp thành `MucNhap`, `PhieuXuatKho` hợp thành `MucXuat`, `PhienKiemKe` hợp thành `MucKiemKe`.
2. **Aggregation / Association**:
   - `Kho` và `TonKho`: `Kho 1 -- * TonKho` và `VatTu 1 -- * TonKho`. Đây là ánh xạ nhiều-nhiều giữa Kho và Vật tư được cụ thể hóa bằng thuộc tính số lượng tồn.
   - `DanhMuc 0..1 -- * DanhMuc`: Quan hệ phân cấp danh mục tự quy chiếu (Reflexive association).
   - `PhongBan 1 -- * YeuCauCapPhat`: Phòng ban tạo các yêu cầu cấp phát.
   - `PhongBan 1 -- * NhanVien`: Nhân viên thuộc về một phòng ban.

---

## Biểu đồ Lớp Lĩnh vực Rendered

![Biểu đồ Lớp Mô hình Lĩnh vực](../diagrams/domain-class-diagram.png)

## File nguồn PlantUML
Sơ đồ nguồn hoàn chỉnh: [domain-class-diagram.puml](../plantuml/domain-class-diagram.puml).
Render thành hình ảnh bằng lệnh:
```bash
java -jar plantuml.jar plantuml/domain-class-diagram.puml -o ../diagrams/
```
