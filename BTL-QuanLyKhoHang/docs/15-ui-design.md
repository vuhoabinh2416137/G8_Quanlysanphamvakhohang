# 15 - Thiết kế Giao diện Người dùng (User Interface Design - UI/UX)

## Cơ sở Lý thuyết và Nguyên tắc Thiết kế (UI Standards)

Theo giáo trình **IT3120 - Thiết kế Giao diện (ThietKeGiaoDien)**:
Thiết kế giao diện trong quy trình OOSAD chuyển tiếp trực tiếp từ:
1. **Ca sử dụng (Use Cases) & Đặc tả chi tiết (Use Case Specs)**: Xác định các trường thông tin cần nhập và các tác vụ người dùng.
2. **Sơ đồ tuần tự mức hệ thống (SSD)**: Xác định chuỗi màn hình tương tác và phản hồi của hệ thống.
3. **Mô hình hóa cấu trúc (Domain Classes)**: Xác định các thực thể và thuộc tính hiển thị trên các biểu mẫu (Forms / Data Grids).

---

## Cấu trúc Điều hướng Hệ thống (Site Map)

```
[ ĐĂNG NHẬP HỆ THỐNG ]
          │
          ▼
   [ DASHBOARD TỔNG QUAN ]
          ├─────────────────────────┬─────────────────────────┬─────────────────────────┐
          ▼                         ▼                         ▼                         ▼
┌──────────────────┐      ┌──────────────────┐      ┌──────────────────┐      ┌──────────────────┐
│  QUẢN LÝ SẢN PHẨM│      │ QUẢN LÝ KHO HÀNG │      │ QUẢN LÝ MUA HÀNG │      │BÁO CÁO & THỐNG KÊ│
├──────────────────┤      ├──────────────────┤      ├──────────────────┤      ├──────────────────┤
│• Danh mục SP     │      │• Phiếu Nhập kho  │      │• Đơn mua (PO)    │      │• Báo cáo Tồn kho │
│• Danh sách SP    │      │• Phiếu Xuất kho  │      │• Duyệt đơn mua   │      │• Báo cáo Nhập/Xuất
│• Cảnh báo tồn    │      │• Chuyển kho      │      │• Nhà cung cấp    │      │• Báo cáo Mua hàng│
│• Định mức kho    │      │• Phiên Kiểm kê   │      │• Đánh giá NCC    │      │• Biên bản Kiểm kê│
└──────────────────┘      └──────────────────┘      └──────────────────┘      └──────────────────┘
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
| > Dashboard            | [ THỐNG KÊ KHO HÀNG TỔNG HỢP ]                                       |
|   Sản phẩm             | +------------------+ +------------------+ +------------------+       |
|     - Danh mục         | | TỔNG SẢN PHẨM    | | TỔNG TỒN KHO     | | CẢNH BÁO TỒN THẤP|       |
|     - Danh sách SP     | | 1,240 mặt hàng   | | 48,500 chiếc     | | 8 sản phẩm (ĐỎ)  |       |
|   Kho hàng             | +------------------+ +------------------+ +------------------+       |
|     - Nhập kho         | +------------------+ +------------------+ +------------------+       |
|     - Xuất kho         | | ĐƠN MUA CHỜ DUYỆT| | XUẤT KHO HÔM NAY | | GIÁ TRỊ KHO HÀNG |       |
|     - Tồn kho          | | 4 đơn mới        | | 12 phiếu xuất    | | 14.8 Tỷ VNĐ      |       |
|     - Kiểm kê          | +------------------+ +------------------+ +------------------+       |
|   Mua hàng (PO)        |                                                                      |
|     - Đơn mua          | [ CẢNH BÁO TỒN KHO DƯỚI NGƯỠNG AN TOÀN ]                             |
|     - Nhà cung cấp     | +------------+----------------------+----------+----------+---------+|
|   Báo cáo & Thống kê   | | Mã SP      | Tên sản phẩm         | Tồn hiện | Ngưỡng   | Thao tác||
|   Cài đặt hệ thống     | +------------+----------------------+----------+----------+---------+|
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

### 3. Màn hình Lập Phiếu Xuất Kho (UC07)

```
+-----------------------------------------------------------------------------------------------+
| TẠO PHIẾU XUẤT KHO                                            [Hủy bỏ]   [Lưu & Xác nhận Xuất]|
+-----------------------------------------------------------------------------------------------+
| THÔNG TIN PHIẾU XUẤT                                                                          |
| Mã phiếu: [ PXK-2026-301   ] (Tự sinh)           Ngày xuất: [ 15/09/2026 09:15 ]              |
| Kho xuất: [ Kho Tổng Hà Nội           ▼ ]        Thủ kho:   [ NV003 - Lê Hoàng Long          ]|
| Lý do:    (*) Chuyển kho nội bộ  ( ) Trả hàng NCC  ( ) Xuất hủy hàng hỏng  ( ) Cân đối kiểm kê|
| Nơi nhận: [ Kho Chi nhánh TP.HCM                                                            ▼]|
+-----------------------------------------------------------------------------------------------+
| DANH SÁCH MẶT HÀNG XUẤT KHO                                   [+ Thêm dòng]  [Quét mã vạch]   |
+----+-------------+-------------------------+-------+----------+------------+------------+-----+
| STT| Mã SP       | Tên sản phẩm            | ĐVT   | Tồn hiện | SL Xuất    | Vị trí kệ  | Xóa |
+----+-------------+-------------------------+-------+----------+------------+------------+-----+
| 1  | SP-SAM-S24U | Samsung S24 Ultra 512GB | Chiếc | 35       | [ 5    ]   | Kệ A-01-02 | [x] |
| 2  | SP-LOGI-M3  | Chuột không dây M331    | Chiếc | 80       | [ 20   ]   | Kệ B-03-01 | [x] |
+----+-------------+-------------------------+-------+----------+------------+------------+-----+
| Ghi chú: [ Điều chuyển hàng dự trữ phục vụ nhu cầu chi nhánh miền Nam                        ]|
|                                                                                               |
|                                                     TỔNG SỐ LƯỢNG MẶT HÀNG XUẤT: 25 chiếc     |
+-----------------------------------------------------------------------------------------------+
```

---

## Tiêu chí Đánh giá Trải nghiệm Người dùng (Usability Criteria)
- **Hiệu quả (Efficiency)**: Thời gian thao tác lập 1 phiếu nhập/xuất kho trung bình dưới 2 phút đối với thủ kho.
- **Tốc độ phản hồi (Speed)**: Tìm kiếm sản phẩm theo mã/tên trong kho dữ liệu 100,000 bản ghi dưới 0.5 giây.
- **Hỗ trợ đa phương tiện**: Hỗ trợ quét mã vạch Barcode/QR Code và các phím tắt chuyên dụng (`F2`: Tìm kiếm, `F4`: Thêm dòng hàng, `F9`: Lưu & In phiếu kho, `Esc`: Đóng cửa sổ).
