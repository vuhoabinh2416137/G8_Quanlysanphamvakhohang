# 15 - Thiết kế Giao diện Người dùng (User Interface Design - UI/UX)

## Cơ sở Lý thuyết và Nguyên tắc Thiết kế (UI Standards)

Theo giáo trình **IT3120 - Thiết kế Giao diện (ThietKeGiaoDien)**:
Thiết kế giao diện trong quy trình OOSAD chuyển tiếp trực tiếp từ:
1. **Ca sử dụng (Use Cases) & Đặc tả chi tiết (Use Case Specs)**: Xác định các trường thông tin cần nhập và các tác vụ người dùng.
2. **Sơ đồ tuần tự mức hệ thống (SSD)**: Xác định chuỗi màn hình tương tác và phản hồi của hệ thống.
3. **Mô hình hóa cấu trúc (Domain Classes)**: Xác định các thực thể và thuộc tính hiển thị trên các biểu mẫu (Forms / Data Grids).

### Các nguyên tắc vàng được áp dụng:
- **Tính nhất quán (Consistency)**: Thanh điều hướng bên trái (Sidebar) cố định, thanh trạng thái trên cùng (Top header) hiển thị thông tin phiên đăng nhập và chuông cảnh báo tồn kho thấp.
- **Phản hồi trạng thái (Feedback & Status)**: Sử dụng các huy hiệu (Badges) trạng thái màu sắc chuẩn hóa (Xanh lá: Thành công / Đã duyệt; Vàng: Chờ duyệt; Đỏ: Hủy / Cảnh báo tồn thấp).
- **Phòng ngừa lỗi (Error Prevention)**: Kiểm tra tính hợp lệ dữ liệu ngay tại Client (Validation: số lượng > 0, mã sản phẩm duy nhất) và hộp thoại xác nhận (Modal Confirmation) đối với các hành động phá hủy hoặc quan trọng (Xóa, Hủy đơn, Chốt kiểm kê).

---

## Sơ đồ Điều hướng Màn hình (Window Navigation Diagram - WND)

```
                       ┌──────────────────────┐
                       │  Màn hình Đăng nhập  │
                       └──────────┬───────────┘
                                  │ (Xác thực thành công)
                                  ▼
                       ┌──────────────────────┐
                       │ Dashboard Tổng quan  │
                       └──────────┬───────────┘
         ┌────────────────────────┼────────────────────────┬────────────────────────┐
         ▼                        ▼                        ▼                        ▼
┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐    ┌──────────────────┐
│ Quản lý Sản phẩm │    │ Quản trị Kho     │    │ Quản lý Đơn hàng │    │ Báo cáo Thống kê │
├──────────────────┤    ├──────────────────┤    ├──────────────────┤    ├──────────────────┤
│• Danh mục SP     │    │• Phiếu Nhập Kho  │    │• Đơn Mua Hàng    │    │• Báo cáo Tồn kho │
│• Danh sách SP    │    │• Phiếu Xuất Kho  │    │• Duyệt Đơn Mua   │    │• Báo cáo Doanh thu│
│• Chi tiết / CRUD │    │• Tra cứu Tồn kho │    │• Đơn Bán Hàng    │    │• Lịch sử Nhập/Xuất│
│• Cảnh báo tồn    │    │• Phiên Kiểm kê   │    │• Khách hàng/NCC  │    │• Báo cáo Công nợ │
└──────────────────┘    └──────────────────┘    └──────────────────┘    └──────────────────┘
```

---

## Bản vẽ Wireframe / Mockup Màn hình Trọng yếu

### 1. Màn hình Dashboard Tổng quan (Trang chủ sau khi đăng nhập)

```
+-----------------------------------------------------------------------------------------------+
| LOGO  HỆ THỐNG QUẢN LÝ SẢN PHẨM & KHO HÀNG        [Chuông: 3 Cảnh báo]  [Avatar: Trần Khánh Linh]  |
+-----------------------------------------------------------------------------------------------+
| [MENU]                 | DASHBOARD TỔNG QUAN                             Thứ Hai, 14/09/2026   |
|                        +----------------------------------------------------------------------+
| > Dashboard            | [ THỐNG KÊ TỔNG HỢP ]                                                |
|   Sản phẩm             | +------------------+ +------------------+ +------------------+       |
|   Kho hàng             | | TỔNG SẢN PHẨM    | | TỔNG TỒN KHO     | | CẢNH BÁO TỒN THẤP|       |
|     - Nhập kho         | | 1,240 mặt hàng   | | 48,500 chiếc     | | 8 sản phẩm (ĐỎ)  |       |
|     - Xuất kho         | +------------------+ +------------------+ +------------------+       |
|     - Tồn kho          | +------------------+ +------------------+ +------------------+       |
|     - Kiểm kê          | | ĐƠN MUA CHỜ DUYỆT| | ĐƠN BÁN TRONG NGÀY| | GIÁ TRỊ KHO HÀNG |       |
|   Mua hàng (PO)        | | 4 đơn mới        | | 28 đơn hoàn tất  | | 14.8 Tỷ VNĐ      |       |
|   Bán hàng (SO)        | +------------------+ +------------------+ +------------------+       |
|   Đối tác (NCC/KH)     |                                                                      |
|   Báo cáo & Phân tích  | [ CẢNH BÁO TỒN KHO DƯỚI NGƯỠNG AN TOÀN ]                             |
|   Cài đặt hệ thống     | +------------+----------------------+----------+----------+---------+|
|                        | | Mã SP      | Tên sản phẩm         | Tồn hiện | Ngưỡng   | Thao tác||
|                        | +------------+----------------------+----------+----------+---------+|
|                        | | SP-SAM-S24 | Samsung S24 Ultra    | 2 chiếc  | 10 chiếc | [Tạo PO]||
|                        | | SP-LOGI-M3 | Chuột Logitech M331  | 4 chiếc  | 20 chiếc | [Tạo PO]||
|                        | | SP-DELL-P2 | Màn hình Dell P2419H | 1 chiếc  | 5 chiếc  | [Tạo PO]||
|                        | +------------+----------------------+----------+----------+---------+|
+-----------------------------------------------------------------------------------------------+
```

---

### 2. Màn hình Lập Phiếu Nhập Kho (UC06)

```
+-----------------------------------------------------------------------------------------------+
| TẠO PHIẾU NHẬP KHO                                            [Hủy bỏ]   [Lưu & Xác nhận Nhập]|
+-----------------------------------------------------------------------------------------------+
| THÔNG TIN PHIẾU NHẬP                                                                          |
| Mã phiếu: [ PNK-2026-101   ] (Tự sinh)           Ngày nhập: [ 14/09/2026 14:30 ]              |
| Kho nhập: [ Kho Tổng Hà Nội           ▼ ]        Thủ kho:   [ NV002 - Trần Khánh Linh        ]|
| Lý do:    (*) Từ Nhà cung cấp  ( ) Chuyển kho    ( ) Điều chỉnh kiểm kê                       |
| Đơn mua:  [ PO-2026-001 - Samsung Electronics VN                                            ▼]|
+-----------------------------------------------------------------------------------------------+
| DANH SÁCH MẶT HÀNG NHẬP KHO                                   [+ Thêm dòng]  [Quét mã vạch]   |
+----+-------------+-------------------------+-------+----------+------------+------------+-----+
| STT| Mã SP       | Tên sản phẩm            | ĐVT   | SL Nhận  | Đơn giá    | Thành tiền | Xóa |
+----+-------------+-------------------------+-------+----------+------------+------------+-----+
| 1  | SP-SAM-S24U | Samsung S24 Ultra 512GB | Chiếc | [ 20   ] | 25,000,000 | 500,000,000| [x] |
| 2  | SP-SAM-BUDS3| Galaxy Buds 3 Pro       | Bộ    | [ 50   ] |  5,000,000 | 250,000,000| [x] |
+----+-------------+-------------------------+-------+----------+------------+------------+-----+
| Ghi chú: [ Hàng nguyên đai nguyên kiện theo PO-2026-001                                      ]|
|                                                                                               |
|                                                     TỔNG GIÁ TRỊ NHẬP KHO: 750,000,000 VNĐ    |
+-----------------------------------------------------------------------------------------------+
```

---

### 3. Màn hình Bán Hàng & Tạo Đơn Bán (UC17)

```
+-----------------------------------------------------------------------------------------------+
| BÁN HÀNG TẠI QUẦY & ĐƠN HÀNG (POS)                                    Thu ngân: Nguyễn Văn Bình|
+------------------------------------------------------------------+----------------------------+
| TÌM KIẾM SẢN PHẨM: [ Nhập mã hoặc quét barcode sản phẩm...    ]  | THÔNG TIN KHÁCH HÀNG       |
+----+-------------+----------------------+-----+-----+------------+ [Tìm KH qua SĐT: 0912...  ]|
| STT| Mã SP       | Tên sản phẩm         | ĐVT | SL  | Đơn giá    | KH: Tập đoàn Viettel       |
+----+-------------+----------------------+-----+-----+------------+ Loại: DOANH NGHIỆP (VIP)   |
| 1  | SP-SAM-S24U | Samsung S24 Ultra    | Chiếc| 6  | 31,990,000 | Kho xuất: Kho Tổng Hà Nội  |
|    |             | (Tồn kho khả dụng: 35)                         |----------------------------|
+----+-------------+----------------------+-----+-----+------------+ TỔNG TIỀN HÀNG: 191,940,000|
|                                                                  | Thuế VAT (10%):  19,194,000|
|                                                                  | Chiết khấu DN:   -5,000,000|
|                                                                  |----------------------------|
|                                                                  | TỔNG CỘNG:      206,134,000|
|                                                                  |----------------------------|
|                                                                  | Phương thức thanh toán:    |
|                                                                  | (*) Chuyển khoản [Quét QR] |
|                                                                  | ( ) Tiền mặt               |
|                                                                  | ( ) Công nợ 30 ngày        |
|                                                                  |                            |
|                                                                  | [ IN HÓA ĐƠN & HOÀN TẤT ]  |
+------------------------------------------------------------------+----------------------------+
```

---

## Tiêu chí Đánh giá Trải nghiệm Người dùng (Usability Criteria)
- **Hiệu quả (Efficiency)**: Thời gian thao tác lập 1 phiếu nhập/xuất kho trung bình dưới 2 phút đối với người dùng đã được đào tạo.
- **Tốc độ phản hồi (Speed)**: Tìm kiếm sản phẩm theo mã/tên trong kho dữ liệu 100,000 bản ghi dưới 0.5 giây.
- **Hỗ trợ đa phương tiện**: Hỗ trợ phím tắt (`F2`: Tìm kiếm, `F4`: Thêm dòng, `F9`: Thanh toán, `Esc`: Đóng popup).
