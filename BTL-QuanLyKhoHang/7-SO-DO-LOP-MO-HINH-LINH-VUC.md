# BỘ 07 BIỂU ĐỒ LỚP MÔ HÌNH LĨNH VỰC (DOMAIN CLASS DIAGRAMS)
## Phiên bản đầu tiên theo 07 Ca sử dụng phân công cho 07 Thành viên

> **Học phần**: IT3120 - Phân tích và Thiết kế Hệ thống Thông tin  
> **Viện Công nghệ Thông tin và Truyền thông - Đại học Bách Khoa Hà Nội (HUST)**  
> **Đề tài**: Hệ thống Quản lý Vật tư và Kho hàng Nội bộ Tổ chức (Nhóm 8 - G8)  
> **Quy chuẩn OOSAD**: Ở giai đoạn phân tích ban đầu, mỗi thành viên xây dựng **01 Sơ đồ lớp lĩnh vực cục bộ (Local Domain Class Diagram)** tập trung vào các thực thể nghiệp vụ, thuộc tính và mối quan hệ trực tiếp trong phạm vi Ca sử dụng (Use Case) mà mình được phân công làm Chủ trì (Owner).

---

## 1. THÀNH VIÊN 1: VŨ HÒA BÌNH
### Sơ đồ lớp lĩnh vực: `UC01: Quản trị Người dùng & Phân quyền RBAC`

#### a. Giới thiệu phạm vi nghiệp vụ
Ca sử dụng `UC01` quản lý cấu trúc tổ chức phòng ban, hồ sơ nhân sự, tài khoản hệ thống và ma trận phân quyền dựa trên vai trò (Role-Based Access Control - RBAC). Sơ đồ lớp mô hình hóa mối quan hệ giữa Nhân viên, Phòng ban, Tài khoản, Vai trò, Quyền hạn và Nhật ký kiểm toán an toàn.

#### b. Biểu đồ lớp (Mermaid Class Diagram)

```mermaid
classDiagram
    direction TB
    
    class PhongBan {
        - maPhongBan: String
        - tenPhongBan: String
        - dienThoai: String
        - diaDiem: String
        - trangThai: String
        + layDanhSachNhanVien(): List
    }

    class NhanVien {
        - maNV: String
        - hoTen: String
        - cccd: String
        - email: String
        - dienThoai: String
        - chucVu: String
        - trangThaiLamViec: String
        + layThongTin(): NhanVien
        + capNhatHoSo(): void
    }

    class TaiKhoan {
        - tenDangNhap: String
        - matKhauHash: String
        - trangThai: TrangThaiTaiKhoan
        - ngayTao: Date
        - lanDangNhapCuoi: Date
        + kiemTraMatKhau(mk: String): Boolean
        + doiMatKhau(mkMoi: String): void
        + khoaTaiKhoan(): void
    }

    class VaiTro {
        - maVaiTro: String
        - tenVaiTro: String
        - moTa: String
    }

    class Quyen {
        - maQuyen: String
        - tenQuyen: String
        - moTa: String
        - phanHe: String
    }

    class NhatKyKiemToan {
        - maLog: String
        - thoiDiem: DateTime
        - hanhDong: String
        - chiTietThayDoi: String
        - ipAddress: String
    }

    class TrangThaiTaiKhoan {
        <<enumeration>>
        HOAT_DONG
        TAM_KHOA
        CHO_KICH_HOAT
    }

    %% Relationships
    PhongBan "1" -- "0..*" NhanVien : thuộc về
    NhanVien "1" -- "0..1" TaiKhoan : sở hữu
    TaiKhoan "*" -- "*" VaiTro : gán vai trò
    VaiTro "*" -- "*" Quyen : chứa quyền
    TaiKhoan "1" -- "0..*" NhatKyKiemToan : ghi vết thao tác
```

#### c. Giải thích các lớp & Quan hệ cốt lõi
- `NhanVien 1 -- 0..1 TaiKhoan`: Một nhân viên có tối đa một tài khoản đăng nhập (có nhân sự chưa được cấp tài khoản).
- `TaiKhoan * -- * VaiTro`: Ánh xạ nhiều - nhiều (mô hình RBAC). Một tài khoản có thể đảm nhận nhiều vai trò (ví dụ: vừa là `Quản lý kho`, vừa có vai trò `Admin`).
- `VaiTro * -- * Quyen`: Mỗi vai trò bao gồm tập hợp các quyền chức năng cụ thể (`XEM_KHO`, `DUYET_CAP_PHAT`, `NHAP_KHO`...).
- `NhatKyKiemToan`: Ghi vết mọi thao tác cấp/khóa tài khoản, đổi quyền để phục vụ hậu kiểm bảo mật.

---

## 2. THÀNH VIÊN 2: LÝ CÔNG HIẾU
### Sơ đồ lớp lĩnh vực: `UC03: Lập & Theo dõi Yêu cầu Cấp phát Vật tư`

#### a. Giới thiệu phạm vi nghiệp vụ
Ca sử dụng `UC03` mô hình hóa quy trình Đại diện phòng ban tạo lập phiếu đề nghị cấp phát vật tư/thiết bị theo nhu cầu công tác, đối chiếu định mức sử dụng kỳ của phòng ban và theo dõi tiến độ xử lý của phiếu.

#### b. Biểu đồ lớp (Mermaid Class Diagram)

```mermaid
classDiagram
    direction TB

    class PhongBan {
        - maPhongBan: String
        - tenPhongBan: String
        - dinhMucKyHienTai: Double
        - chiPhiDaDung: Double
        + kiemTraHanMuc(soLuong: Integer): Boolean
    }

    class NhanVien {
        - maNV: String
        - hoTen: String
        - chucVu: String
        - email: String
    }

    class YeuCauCapPhat {
        - maYeuCau: String
        - ngayYeuCau: Date
        - mucDichSuDung: String
        - ngayMongMuonNhan: Date
        - ghiChu: String
        - trangThai: TrangThaiYeuCau
        + tinhTongSoLuong(): Integer
        + guiYeuCau(): void
        + huyYeuCau(): void
    }

    class ChiTietYeuCau {
        - maChiTiet: String
        - soLuongYeuCau: Integer
        - ghiChu: String
        + kiemTraHopLe(): Boolean
    }

    class VatTu {
        - maVT: String
        - tenVT: String
        - donViTinh: String
        - quyCach: String
        - trangThai: String
    }

    class TrangThaiYeuCau {
        <<enumeration>>
        MOI_TAO
        CHO_DUYET
        DA_DUYET
        TU_CHOI
        DANG_XUAT_KHO
        HOAN_THANH
        DA_HUY
    }

    %% Relationships
    PhongBan "1" -- "0..*" YeuCauCapPhat : lập đề nghị
    NhanVien "1" -- "0..*" YeuCauCapPhat : cán bộ tạo phiếu
    YeuCauCapPhat "1" *-- "1..*" ChiTietYeuCau : gồm các dòng
    ChiTietYeuCau "*" -- "1" VatTu : yêu cầu mặt hàng
```

#### c. Giải thích các lớp & Quan hệ cốt lõi
- `YeuCauCapPhat 1 *-- 1..* ChiTietYeuCau` (Composition - Hợp thành mạnh): Phiếu yêu cầu bắt buộc phải có ít nhất 1 dòng mặt hàng. Nếu phiếu yêu cầu bị xóa, các dòng chi tiết sẽ bị xóa theo.
- `PhongBan 1 -- 0..* YeuCauCapPhat`: Phiếu yêu cầu luôn gắn liền với một phòng ban để kiểm soát hạn mức chi tiêu/cấp phát trong kỳ.
- `ChiTietYeuCau * -- 1 VatTu`: Mỗi dòng chi tiết tham chiếu đến một loại vật tư lưu hành trong danh mục.

---

## 3. THÀNH VIÊN 3: PHẠM DUY HIẾU
### Sơ đồ lớp lĩnh vực: `UC04: Thẩm định & Phê duyệt Yêu cầu Cấp phát`

#### a. Giới thiệu phạm vi nghiệp vụ
Ca sử dụng `UC04` mô hình hóa tiến trình Quản lý kho tiếp nhận hàng đợi phiếu chờ duyệt, đối soát tồn kho khả dụng và hạn mức phòng ban, ra quyết định Duyệt toàn bộ, Duyệt một phần hoặc Từ chối, lưu vết lịch sử duyệt và kích hoạt thông báo tự động.

#### b. Biểu đồ lớp (Mermaid Class Diagram)

```mermaid
classDiagram
    direction TB

    class YeuCauCapPhat {
        - maYeuCau: String
        - ngayYeuCau: Date
        - ngayDuyet: Date
        - trangThai: TrangThaiYeuCau
        - lyDoTuChoi: String
        + chuyenTrangThai(tt: TrangThaiYeuCau): void
        + phatLenhXuatKho(): void
    }

    class ChiTietYeuCau {
        - soLuongYeuCau: Integer
        - soLuongDuyet: Integer
        - lyDoDieuChinh: String
        + capNhatSoLuongDuyet(sl: Integer): void
    }

    class NhanVien {
        - maNV: String
        - hoTen: String
        - chucVu: String
    }

    class TonKho {
        - soLuongThucTe: Integer
        - soLuongDaGiuCho: Integer
        + layTonKhaDung(): Integer
    }

    class VatTu {
        - maVT: String
        - tenVT: String
        - donViTinh: String
    }

    class LichSuPheDuyet {
        - maLichSu: String
        - thoiDiemDuyet: DateTime
        - quyetDinh: LoaiQuyetDinh
        - yKienPheDuyet: String
    }

    class LoaiQuyetDinh {
        <<enumeration>>
        DUYET_TOAN_BO
        DUYET_MOT_PHAN
        TU_CHOI
    }

    %% Relationships
    YeuCauCapPhat "1" *-- "1..*" ChiTietYeuCau : thẩm định từng dòng
    ChiTietYeuCau "*" -- "1" VatTu : đối chiếu mặt hàng
    VatTu "1" -- "0..*" TonKho : kiểm tra tồn kho
    NhanVien "1" -- "0..*" YeuCauCapPhat : người phê duyệt
    YeuCauCapPhat "1" -- "1..*" LichSuPheDuyet : lưu vết thẩm định
    NhanVien "1" -- "0..*" LichSuPheDuyet : người ra quyết định
```

#### c. Giải thích các lớp & Quan hệ cốt lõi
- `TonKho` với phương thức `layTonKhaDung()`: Phản ánh nghiệp vụ cốt lõi của việc **Thẩm định**: $\text{Tồn khả dụng} = \text{Số lượng thực tế} - \text{Số lượng đã giữ chỗ}$.
- `ChiTietYeuCau.soLuongDuyet`: Cho phép Quản lý kho duyệt số lượng nhỏ hơn hoặc bằng số lượng yêu cầu (`soLuongDuyet <= soLuongYeuCau`) phục vụ nghiệp vụ **Duyệt một phần**.
- `LichSuPheDuyet`: Lưu vết vĩnh viễn ai là người duyệt, thời điểm nào, duyệt bao nhiêu để làm căn cứ minh bạch trong kiểm toán tài sản.

---

## 4. THÀNH VIÊN 4: NGUYỄN TRUNG NGÂN
### Sơ đồ lớp lĩnh vực: `UC02: Quản lý Danh mục & Hồ sơ Vật tư, Thiết bị`

#### a. Giới thiệu phạm vi nghiệp vụ
Ca sử dụng `UC02` chịu trách nhiệm mô hình hóa cấu trúc phân loại hình cây của danh mục vật tư, hồ sơ thông số kỹ thuật, quy cách đóng gói, đơn vị tính và định mức tồn an toàn tối thiểu/tối đa tại từng kho.

#### b. Biểu đồ lớp (Mermaid Class Diagram)

```mermaid
classDiagram
    direction TB

    class DanhMuc {
        - maDanhMuc: String
        - tenDanhMuc: String
        - moTa: String
        - capDo: Integer
        + layDanhMucCon(): List
        + kiemTraVongLap(): Boolean
    }

    class VatTu {
        - maVT: String
        - tenVT: String
        - donViTinh: String
        - quyCachKychThuat: String
        - xuatXu: String
        - hinhAnhURL: String
        - trangThai: TrangThaiVT
        + kiemTraLuuHanh(): Boolean
    }

    class Kho {
        - maKho: String
        - tenKho: String
        - diaChi: String
        - loaiKho: String
    }

    class ViTriKho {
        - maViTri: String
        - dayKe: String
        - tangKe: String
        - oKe: String
    }

    class DinhMucTonKho {
        - nguongToiThieu: Integer
        - nguongToiDa: Integer
        - ngayThietLap: Date
        + kiemTraCanhBao(sl: Integer): String
    }

    class TrangThaiVT {
        <<enumeration>>
        DANG_SU_DUNG
        TAM_NGUNG
        NGUNG_SU_DUNG
    }

    %% Relationships
    DanhMuc "0..1" -- "0..*" DanhMuc : danh mục cha - con
    DanhMuc "1" -- "0..*" VatTu : phân loại
    Kho "1" *-- "1..*" ViTriKho : chứa các vị trí
    VatTu "1" -- "0..*" DinhMucTonKho : thiết lập định mức
    Kho "1" -- "0..*" DinhMucTonKho : áp dụng tại kho
    ViTriKho "0..1" -- "0..*" VatTu : vị trí mặc định
```

#### c. Giải thích các lớp & Quan hệ cốt lõi
- `DanhMuc 0..1 -- 0..* DanhMuc` (Reflexive Association - Tự quy chiếu): Thể hiện cây danh mục nhiều cấp (ví dụ: *Vật tư văn phòng $\rightarrow$ Giấy in $\rightarrow$ Giấy A4*).
- `DinhMucTonKho` (Lớp liên kết giữa `VatTu` và `Kho`): Mỗi vật tư tại mỗi kho khác nhau có thể có ngưỡng an toàn khác nhau (ví dụ: Kho trung tâm cần dự trữ tối thiểu 50 ram giấy, nhưng kho chi nhánh chỉ cần 5 ram).
- `Kho 1 *-- 1..* ViTriKho`: Quản lý kho chi tiết đến từng Dãy Kệ - Tầng - Ô để phục vụ công tác định vị khi nhập và lấy hàng.

---

## 5. THÀNH VIÊN 5: HOÀNG TRỌNG ĐỨC ANH
### Sơ đồ lớp lĩnh vực: `UC05: Quản lý Nhập kho & Điều chuyển Vật tư`

#### a. Giới thiệu phạm vi nghiệp vụ
Ca sử dụng `UC05` mô hình hóa nghiệp vụ tiếp nhận nguồn vật tư phân bổ từ cấp trên, thu hồi hoàn nhập từ phòng ban và điều chuyển giữa các kho nội bộ; thực hiện kiểm đếm thực nhận, tăng tồn kho nguyên tử và ghi nhận lịch sử Thẻ kho (Stock Card).

#### b. Biểu đồ lớp (Mermaid Class Diagram)

```mermaid
classDiagram
    direction TB

    class PhieuNhapKho {
        - maPhieuNhap: String
        - ngayNhap: DateTime
        - lyDoNhap: LyDoNhap
        - nguonGiao: String
        - soChungTuGoc: String
        - trangThai: TrangThaiPhieu
        - ghiChu: String
        + xacNhanNhap(): void
        + huyPhieu(): void
    }

    class MucNhapKho {
        - maMucNhap: String
        - soLuongGiao: Integer
        - soLuongThucNhan: Integer
        - viTriLuuKho: String
        - tinhTrangVatTu: String
        + tinhSaiLech(): Integer
    }

    class VatTu {
        - maVT: String
        - tenVT: String
        - donViTinh: String
    }

    class Kho {
        - maKho: String
        - tenKho: String
    }

    class TonKho {
        - soLuong: Integer
        - ngayCapNhat: DateTime
        + tangTon(sl: Integer): void
    }

    class TheKho {
        - maGiaoDich: String
        - ngayGhiSo: DateTime
        - loaiPhatSinh: String
        - soLuongPhatSinh: Integer
        - tonSauGiaoDich: Integer
        - maChungTu: String
    }

    class NhanVien {
        - maNV: String
        - hoTen: String
    }

    class LyDoNhap {
        <<enumeration>>
        PHAN_BO_CAP_TREN
        HOAN_NHAP_PHONG_BAN
        CHUYEN_KHO_DEN
        CAN_DOI_KIEM_KE
    }

    %% Relationships
    PhieuNhapKho "1" *-- "1..*" MucNhapKho : chứa các mục
    MucNhapKho "*" -- "1" VatTu : nhập mặt hàng
    Kho "1" -- "0..*" PhieuNhapKho : kho tiếp nhận
    Kho "0..1" -- "0..*" PhieuNhapKho : kho nguồn (khi điều chuyển)
    NhanVien "1" -- "0..*" PhieuNhapKho : thủ kho tiếp nhận
    VatTu "1" -- "0..*" TonKho : theo dõi tồn
    Kho "1" -- "0..*" TonKho : vị trí lưu trữ
    PhieuNhapKho "1" ..> "1..*" TheKho : sinh giao dịch
    TonKho "1" ..> "0..*" TheKho : liên kết dòng tiền hàng
```

#### c. Giải thích các lớp & Quan hệ cốt lõi
- `PhieuNhapKho 1 *-- 1..* MucNhapKho`: Quan hệ hợp thành, ghi nhận từng dòng thực nhận kèm vị trí kệ cất hàng và tình trạng vật tư.
- `Kho (Kho nhận) & Kho (Kho nguồn)`: Khi là nhập điều chuyển kho, phiếu nhập liên kết cả 2 kho để đối soát khớp số lượng xuất đi và nhập đến.
- `TheKho (Stock Card)`: Thực thể kế toán ghi nhận sự kiện tăng tồn kho nguyên tử (`soLuongPhatSinh = +soLuongThucNhan`), đảm bảo tính toàn vẹn số liệu và khả năng truy vết lịch sử giao dịch.

---

## 6. THÀNH VIÊN 6: ĐỖ DUY ĐỨC
### Sơ đồ lớp lĩnh vực: `UC06: Quản lý Xuất kho & Bàn giao Cấp phát`

#### a. Giới thiệu phạm vi nghiệp vụ
Ca sử dụng `UC06` mô hình hóa quy trình Thủ kho lập phiếu xuất căn cứ theo phiếu yêu cầu đã duyệt, kiểm tra chống xuất âm và khóa kiểm kê, in phiếu xuất, bàn giao hiện vật cho cán bộ phòng ban, ký nhận biên bản, trừ tồn kho và kích hoạt cảnh báo tồn an toàn.

#### b. Biểu đồ lớp (Mermaid Class Diagram)

```mermaid
classDiagram
    direction TB

    class YeuCauCapPhat {
        - maYeuCau: String
        - trangThai: String
    }

    class PhieuXuatKho {
        - maPhieuXuat: String
        - ngayXuat: DateTime
        - lyDoXuat: LyDoXuat
        - maYeuCauCanCu: String
        - nguoiNhanHang: String
        - trangThai: TrangThaiPhieu
        + kiemTraChongXuatAm(): Boolean
        + xacNhanXuatVaBanGiao(): void
    }

    class MucXuatKho {
        - maMucXuat: String
        - soLuongYeuCau: Integer
        - soLuongThucXuat: Integer
        - viTriLayHang: String
    }

    class VatTu {
        - maVT: String
        - tenVT: String
        - donViTinh: String
        - nguongTonKho: Integer
    }

    class Kho {
        - maKho: String
        - tenKho: String
    }

    class TonKho {
        - soLuong: Integer
        - dangKhoaKiemKe: Boolean
        + giamTon(sl: Integer): void
    }

    class BienBanBanGiao {
        - maBienBan: String
        - ngayKy: DateTime
        - chuKyBenGiao: String
        - chuKyBenNhan: String
        - tinhTrangBanGiao: String
    }

    class CanhBaoTonKho {
        - maCanhBao: String
        - ngayPhat: DateTime
        - tonHienTai: Integer
        - nguongMin: Integer
        - mucDo: String
    }

    class LyDoXuat {
        <<enumeration>>
        CAP_PHAT_PHONG_BAN
        DIEU_CHUYEN_KHO
        THANH_LY_HUY
        CAN_DOI_KIEM_KE
    }

    %% Relationships
    YeuCauCapPhat "1" -- "0..1" PhieuXuatKho : căn cứ xuất hàng
    PhieuXuatKho "1" *-- "1..*" MucXuatKho : chứa chi tiết
    MucXuatKho "*" -- "1" VatTu : xuất mặt hàng
    Kho "1" -- "0..*" PhieuXuatKho : xuất từ kho
    VatTu "1" -- "0..*" TonKho : biến động số lượng
    Kho "1" -- "0..*" TonKho : quản lý tồn
    PhieuXuatKho "1" -- "1" BienBanBanGiao : lập biên bản 2 bên
    TonKho "1" ..> "0..1" CanhBaoTonKho : kích hoạt khi Tồn <= Min
```

#### c. Giải thích các lớp & Quan hệ cốt lõi
- `YeuCauCapPhat 1 -- 0..1 PhieuXuatKho`: Ràng buộc nghiệp vụ bắt buộc: một phiếu xuất cấp phát chỉ được tạo khi có phiếu yêu cầu đã duyệt (`DA_DUYET`).
- `TonKho.dangKhoaKiemKe`: Thuộc tính bảo vệ ngăn chặn xuất kho nếu mặt hàng đang nằm trong đợt kiểm kê chưa chốt sổ.
- `BienBanBanGiao`: Minh chứng pháp lý giao nhận giữa Thủ kho và Đại diện phòng ban.
- `CanhBaoTonKho`: Tự động sinh ra khi việc trừ tồn kho khiến `TonKho.soLuong <= VatTu.nguongTonKho`.

---

## 7. THÀNH VIÊN 7: [ĐIỀN HỌ VÀ TÊN]
### Sơ đồ lớp lĩnh vực: `UC07: Kiểm kê Kho hàng & Báo cáo Thống kê`

#### a. Giới thiệu phạm vi nghiệp vụ
Ca sử dụng `UC07` mô hình hóa quy trình tổ chức phiên kiểm kê hiện vật định kỳ/đột xuất, chốt số dư sổ sách tại thời điểm kiểm kê (Stock Snapshot), ghi nhận số kiểm đếm thực tế, tính toán chênh lệch thừa/thiếu, tự sinh phiếu cân bằng kho và kết xuất báo cáo thống kê Xuất - Nhập - Tồn (XNT).

#### b. Biểu đồ lớp (Mermaid Class Diagram)

```mermaid
classDiagram
    direction TB

    class Kho {
        - maKho: String
        - tenKho: String
    }

    class PhienKiemKe {
        - maPhien: String
        - ngayBatDau: DateTime
        - ngayKetThuc: DateTime
        - phamViKiemKe: String
        - trangThai: TrangThaiKiemKe
        + chotSoDuSoSach(): void
        + pheDuyetKetQua(): void
        + taoPhieuCanBang(): void
    }

    class BanKiemKe {
        - maBan: String
        - truongBan: String
        - thuKhoThamGia: String
        - canBoGiamSat: String
    }

    class MucKiemKe {
        - maMuc: String
        - soLuongSoSach: Integer
        - soLuongThucTe: Integer
        - chenhLech: Integer
        - loaiChenhLech: LoaiChenhLech
        - lyDoChenhLech: String
        + tinhChenhLech(): void
    }

    class VatTu {
        - maVT: String
        - tenVT: String
        - donViTinh: String
    }

    class TonKho {
        - soLuong: Integer
        + capNhatCanBang(chenhLech: Integer): void
    }

    class PhieuCanBangKho {
        - maPhieuDieuChinh: String
        - loaiDieuChinh: String
        - ngayTao: Date
        - lyDo: String
    }

    class BaoCaoXNT {
        - maBaoCao: String
        - kyBaoCao: String
        - tongTonDau: Integer
        - tongNhap: Integer
        - tongXuat: Integer
        - tongTonCuoi: Integer
        + xuatExcel(): File
        + xuatPDF(): File
    }

    class TrangThaiKiemKe {
        <<enumeration>>
        DANG_KIEM_DEM
        CHO_GIAI_TRINH
        DA_PHE_DUYET
        DA_HUY
    }

    class LoaiChenhLech {
        <<enumeration>>
        KHOP
        THUA
        THIEU
    }

    %% Relationships
    Kho "1" -- "0..*" PhienKiemKe : địa điểm kiểm kê
    PhienKiemKe "1" -- "1" BanKiemKe : thành phần hội đồng
    PhienKiemKe "1" *-- "1..*" MucKiemKe : gồm các dòng kiểm đếm
    MucKiemKe "*" -- "1" VatTu : đối soát mặt hàng
    VatTu "1" -- "0..*" TonKho : liên kết tồn
    PhienKiemKe "1" -- "0..*" PhieuCanBangKho : tự sinh khi duyệt
    PhieuCanBangKho "1" ..> "1..*" TonKho : cân bằng số lượng
    Kho "1" -- "0..*" BaoCaoXNT : lập báo cáo định kỳ
```

#### c. Giải thích các lớp & Quan hệ cốt lõi
- `PhienKiemKe 1 *-- 1..* MucKiemKe`: Lưu lại ảnh chụp chốt tồn sổ sách (`soLuongSoSach`) và đối chiếu với số thực tế nhân viên kiểm đếm tại kệ (`soLuongThucTe`).
- `MucKiemKe.chenhLech`: $\text{chenhLech} = \text{soLuongThucTe} - \text{soLuongSoSach}$. Tự động phân loại: `KHOP`, `THUA`, `THIEU`.
- `PhieuCanBangKho`: Khi kiểm kê được duyệt, lớp này phát sinh giao dịch nhập cân đối (nếu thừa) hoặc xuất cân đối (nếu thiếu) để đưa `TonKho.soLuong` về đúng với thực tế.
- `BaoCaoXNT`: Thực thể tổng hợp báo cáo kỳ theo công thức cân đối kế toán: $\text{Tồn cuối} = \text{Tồn đầu} + \text{Tổng nhập} - \text{Tổng xuất}$.

---

## BẢNG TỔNG KẾT PHÂN CÔNG 07 SƠ ĐỒ LỚP CHO 07 THÀNH VIÊN

| STT | Thành viên | Ca sử dụng chủ trì (Owner) | Các lớp chính trong sơ đồ lớp cục bộ | Mẫu phân tích áp dụng |
|:---:|:---|:---|:---|:---|
| **01** | **Vũ Hòa Bình** | **UC01**: Quản trị Người dùng & Phân quyền RBAC | `PhongBan`, `NhanVien`, `TaiKhoan`, `VaiTro`, `Quyen`, `NhatKyKiemToan` | RBAC Matrix & Party Pattern |
| **02** | **Lý Công Hiếu** | **UC03**: Lập & Theo dõi Yêu cầu Cấp phát | `PhongBan`, `NhanVien`, `YeuCauCapPhat`, `ChiTietYeuCau`, `VatTu` | Header - Line Item Pattern |
| **03** | **Phạm Duy Hiếu** | **UC04**: Thẩm định & Phê duyệt Yêu cầu | `YeuCauCapPhat`, `ChiTietYeuCau`, `TonKho`, `VatTu`, `LichSuPheDuyet` | Approval Workflow Pattern |
| **04** | **Nguyễn Trung Ngân**| **UC02**: Quản lý Danh mục & Hồ sơ Vật tư | `DanhMuc`, `VatTu`, `Kho`, `ViTriKho`, `DinhMucTonKho` | Catalog - Item & Tree Pattern |
| **05** | **Hoàng Trọng Đức Anh**| **UC05**: Quản lý Nhập kho & Điều chuyển | `PhieuNhapKho`, `MucNhapKho`, `Kho`, `TonKho`, `TheKho`, `VatTu` | Transaction & Stock Movement |
| **06** | **Đỗ Duy Đức** | **UC06**: Quản lý Xuất kho & Bàn giao | `YeuCauCapPhat`, `PhieuXuatKho`, `MucXuatKho`, `TonKho`, `BienBanBanGiao`, `CanhBaoTonKho` | Transaction & Handover Pattern |
| **07** | **Thành viên 7** | **UC07**: Kiểm kê Kho hàng & Báo cáo | `PhienKiemKe`, `BanKiemKe`, `MucKiemKe`, `TonKho`, `PhieuCanBangKho`, `BaoCaoXNT` | Stock Audit & Balance Pattern |

---
*Tài liệu này là phiên bản đầu tiên của Mô hình Lĩnh vực (Domain Model) phục vụ việc phân công đồng đều 1 thành viên = 1 sơ đồ lớp ca sử dụng cho Nhóm 8 (IT3120 - HUST).*
