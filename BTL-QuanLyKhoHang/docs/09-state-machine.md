# 09 - Sơ đồ Máy Trạng thái (State Machine Diagrams)

## Mục đích và Khái niệm

Theo giáo trình **IT3120 - Mô hình hóa Hành vi (Behavioral Modeling)**:
- **Biểu đồ máy trạng thái (State Machine Diagram)** mô hình hóa các trạng thái khác nhau mà một đối tượng có thể trải qua trong suốt vòng đời (Lifecycle) của nó để đáp ứng lại các sự kiện kích hoạt từ bên ngoài.
- Các phần tử chuẩn theo UML 2.5:
  - **Trạng thái (State)**: Chứa các hành động nội tại `entry / do / exit`.
  - **Chuyển tiếp (Transition)**: Định dạng cú pháp chuẩn: `Sự_kiện [Điều_kiện_bảo_vệ] / Hành_động_thực_thi`.
  - **Trạng thái tổng hợp (Composite State)**: Chứa các trạng thái con bên trong.

Hệ thống Quản lý Sản phẩm và Kho hàng có 3 đối tượng nghiệp vụ cốt lõi có trạng thái động phong phú nhất:
1. **Đơn Mua Hàng (`DonMuaHang`)**
2. **Đơn Bán Hàng (`DonBanHang`)**
3. **Sản phẩm trong Kho (`SanPham`)**

---

## 1. Máy Trạng thái Đơn Mua Hàng (DonMuaHang)

### Bảng phân tích trạng thái và sự kiện chuyển tiếp

| Trạng thái nguồn | Sự kiện kích hoạt (Trigger) | Điều kiện bảo vệ (Guard) | Hành động (Action) | Trạng thái đích |
|------------------|-----------------------------|---------------------------|---------------------|-----------------|
| `[*]` (Khởi tạo) | `taoDonMua()` | - | `khoiTaoDonMua()` | `MOI_TAO` |
| `MOI_TAO` | `guiYeuCauDuyet()` | Có ít nhất 1 mặt hàng | `guiThongBaoDuyetChoQLK()` | `CHO_DUYET` |
| `MOI_TAO` | `huyDon()` | - | - | `DA_HUY` |
| `CHO_DUYET` | `duyetDon()` | `[NganSachDu && KhoConCho]` | `guiPO_ChoNCC()` | `DA_DUYET` |
| `CHO_DUYET` | `tuChoi(lyDo)` | - | `thongBaoTuChoiChoNVMH()` | `TU_CHOI` |
| `TU_CHOI` | `suaVaGuiLai()` | - | - | `CHO_DUYET` |
| `DA_DUYET` | `nccXacNhanGiaoHang()` | - | `khoiTaoTheoDoi()` | `DANG_GIAO` |
| `DANG_GIAO` | `nhanHangThucTe()` | `[soLuongNhan < soLuongDat]` | `taoPhieuNhapKho()` | `NHAN_MOT_PHAN` |
| `DANG_GIAO` | `nhanDuHang()` | `[soLuongNhan == soLuongDat]` | `taoPhieuNhapKho()` | `DA_NHAN_HANG` |
| `NHAN_MOT_PHAN` | `nhanTiepDotSau()` | `[duSoLuong]` | `taoPhieuNhapKho()` | `DA_NHAN_HANG` |
| `DA_NHAN_HANG` | `doiSoatVaThanhToan()` | - | `capNhatSoCai()` | `HOAN_THANH` |

---

## 2. Máy Trạng thái Đơn Bán Hàng (DonBanHang)

### Chu trình xử lý đơn hàng
1. `MOI_TAO`: Khách hàng chọn sản phẩm, lập giỏ hàng.
2. `CHO_THANH_TOAN` / `DA_XAC_NHAN`: Xác thực thanh toán trực tuyến hoặc xác nhận công nợ. Tại thời điểm đơn được xác nhận, hệ thống thực hiện **tạm giữ tồn kho (Reserve stock)** để tránh bán vượt quá số lượng hàng có sẵn.
3. `DANG_XU_LY`: Bộ phận kho nhặt hàng theo danh sách Pick-list.
4. `DA_XUAT_KHO`: Đã lập phiếu xuất kho chính thức và trừ tồn kho vật lý.
5. `DANG_GIAO`: Bàn giao cho đơn vị chuyển phát / giao nhận.
6. `DA_GIAO` → `HOAN_THANH`: Khách ký nhận, hoàn tất giao dịch.
7. Trường hợp giao thất bại quá 3 lần: Chuyển sang `TRA_HANG` và tự động kích hoạt thủ tục hoàn tồn kho.

---

## 3. Máy Trạng thái Sản phẩm (SanPham)

Trạng thái nghiệp vụ của sản phẩm gắn liền với tính khả dụng bán hàng và ngưỡng an toàn trong kho:
- `DU_THAO`: Vừa khởi tạo danh mục, chưa phát hành ra thị trường.
- `DANG_KINH_DOANH`: Trạng thái tổng hợp bao gồm:
  - `SanHang`: Số lượng tồn khả dụng > ngưỡng cảnh báo an toàn.
  - `TonThap`: Khi xuất kho làm số lượng `<= nguongTonKho`, tự động phát sinh thông báo cảnh báo tái đặt hàng (UC11).
  - `HetHang`: Tồn kho = 0. Tạm ngưng cho phép đặt đơn bán.
- `TAM_NGUNG`: Tạm khóa bán do biến động giá hoặc lý do nhà phân phối.
- `NGUNG_KINH_DOANH`: Khai tử sản phẩm (chỉ cho phép khi số lượng tồn kho = 0).

---

## File nguồn PlantUML
Sơ đồ PlantUML hoàn chỉnh: [state-machine.puml](../plantuml/state-machine.puml).
Render đồ họa:
```bash
java -jar plantuml.jar plantuml/state-machine.puml -o ../diagrams/
```
