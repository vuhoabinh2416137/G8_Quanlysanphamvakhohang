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
│  QUẢN LÝ VẬT TƯ  │      │ QUẢN LÝ KHO HÀNG │      │YÊU CẦU & CẤP PHÁT│      │BÁO CÁO & THỐNG KÊ│
├──────────────────┤      ├──────────────────┤      ├──────────────────┤      ├──────────────────┤
│• Danh mục vật tư │      │• Phiếu Nhập kho  │      │• Lập yêu cầu     │      │• Báo cáo Tồn kho │
│• Danh sách VT    │      │• Phiếu Xuất kho  │      │• Duyệt cấp phát  │      │• Báo cáo X-N-T   │
│• Định mức tồn kho│      │• Chuyển kho      │      │• Danh mục PB     │      │• Cấp phát theo PB│
│• Cảnh báo tồn    │      │• Phiên Kiểm kê   │      │• Biên bản giao   │      │• Biên bản Kiểm kê│
└──────────────────┘      └──────────────────┘      └──────────────────┘      └──────────────────┘
```

---

## Bản vẽ Wireframe / Mockup Màn hình Trọng yếu

### 1. Màn hình Dashboard Tổng quan (Trang chủ sau khi đăng nhập)

```
+-----------------------------------------------------------------------------------------------+
| LOGO  HỆ THỐNG QUẢN LÝ KHO & VẬT TƯ NỘI BỘ        [Chuông: 3 Cảnh báo]  [Avatar: Trần Khánh Linh]  |
+-----------------------------------------------------------------------------------------------+
| [MENU]                 | DASHBOARD TỔNG QUAN                             Thứ Hai, 14/09/2026   |
|                        +----------------------------------------------------------------------+
| > Dashboard            | [ THỐNG KÊ VẬT TƯ KHO HÀNG TỔNG HỢP ]                                |
|   Vật tư, thiết bị     | +------------------+ +------------------+ +------------------+       |
|     - Danh mục         | | TỔNG VẬT TƯ      | | TỔNG TỒN KHO     | | CẢNH BÁO TỒN THẤP|       |
|     - Danh sách VT     | | 1,240 loại VT    | | 48,500 đơn vị    | | 8 loại vật tư(ĐỎ)|       |
|   Kho hàng             | +------------------+ +------------------+ +------------------+       |
|     - Nhập kho         | +------------------+ +------------------+ +------------------+       |
|     - Xuất kho         | | YÊU CẦU CHỜ DUYỆT| | XUẤT KHO HÔM NAY | | TỔNG SỐ KHO HÀNG |       |
|     - Tồn kho          | | 4 yêu cầu mới    | | 12 phiếu xuất    | | 2 cơ sở kho      |       |
|     - Kiểm kê          | +------------------+ +------------------+ +------------------+       |
|   Yêu cầu & Cấp phát   |                                                                      |
|     - Phiếu yêu cầu    | [ CẢNH BÁO VẬT TƯ DƯỚI NGƯỠNG ĐỊNH MỨC AN TOÀN ]                     |
|     - Duyệt cấp phát   | +------------+----------------------+----------+----------+---------+|
|     - Phòng ban        | | Mã VT      | Tên vật tư           | Tồn hiện | Ngưỡng   | Thao tác||
|   Báo cáo & Thống kê   | +------------+----------------------+----------+----------+---------+|
|   Cài đặt hệ thống     | | VT-DELL-OPT| Máy tính Dell Opti   | 2 bộ     | 5 bộ     | [Chuyển]||
|                        | | VT-MUC-IN  | Hộp mực máy in Canon | 3 hộp    | 10 hộp   | [Đề xuất]||
|                        | | VT-GIAY-A4 | Giấy in Double A A4  | 8 ram    | 20 ram   | [Đề xuất]||
|                        | +------------+----------------------+----------+----------+---------+|
+-----------------------------------------------------------------------------------------------+
```

---

### 2. Màn hình Lập Phiếu Nhập Kho Nội bộ (UC06)

```
+-----------------------------------------------------------------------------------------------+
| TẠO PHIẾU NHẬP KHO NỘI BỘ                                     [Hủy bỏ]   [Lưu & Xác nhận Nhập]|
+-----------------------------------------------------------------------------------------------+
| THÔNG TIN PHIẾU NHẬP                                                                          |
| Mã phiếu: [ PNK-2026-101   ] (Tự sinh)           Ngày nhập: [ 14/09/2026 14:30 ]              |
| Kho nhận: [ Kho Vật tư Tổng           ▼ ]        Thủ kho:   [ NV002 - Trần Khánh Linh        ]|
| Lý do:    (*) Phân bổ cấp trên  ( ) Thu hồi phòng ban  ( ) Chuyển kho đến  ( ) Kiểm kê thừa   |
| Đơn vị:   [ PB-HCTH - Phòng Hành chính - Tổng hợp bàn giao                                  ▼]|
+-----------------------------------------------------------------------------------------------+
| DANH SÁCH MẶT HÀNG TIẾP NHẬN                                  [+ Thêm dòng]  [Quét mã vạch]   |
+----+-------------+------------------------------------+-------+----------+--------------+-----+
| STT| Mã VT       | Tên vật tư                         | ĐVT   | SL Nhận  | Vị trí kệ    | Xóa |
+----+-------------+------------------------------------+-------+----------+--------------+-----+
| 1  | VT-DELL-OPT | Máy tính để bàn Dell OptiPlex      | Bộ    | [ 20   ] | VT-HN-A1-1   | [x] |
| 2  | VT-LOGI-M331| Chuột quang không dây Logitech M331| Chiếc | [ 50   ] | VT-HN-A1-2   | [x] |
+----+-------------+------------------------------------+-------+----------+--------------+-----+
| Ghi chú: [ Tiếp nhận bàn giao vật tư đợt 1 năm 2026 từ Ban Quản lý Cơ sở Vật chất            ]|
|                                                                                               |
|                                                     TỔNG SỐ LƯỢNG NHẬP: 70 đơn vị             |
+-----------------------------------------------------------------------------------------------+
```

---

### 3. Màn hình Lập Phiếu Xuất Kho Cấp phát Nội bộ (UC07)

```
+-----------------------------------------------------------------------------------------------+
| TẠO PHIẾU XUẤT KHO CẤP PHÁT                                   [Hủy bỏ]   [Lưu & Xác nhận Xuất]|
+-----------------------------------------------------------------------------------------------+
| THÔNG TIN PHIẾU XUẤT                                                                          |
| Mã phiếu: [ PXK-2026-301   ] (Tự sinh)           Ngày xuất: [ 15/09/2026 09:15 ]              |
| Kho xuất: [ Kho Vật tư Tổng           ▼ ]        Thủ kho:   [ NV003 - Lê Hoàng Long          ]|
| Lý do:    (*) Cấp phát phòng ban  ( ) Chuyển kho  ( ) Thanh lý hủy  ( ) Kiểm kê thiếu         |
| Căn cứ:   [ YCCP-2026-001 - Phòng Công nghệ Thông tin & Kỹ thuật                            ▼]|
+-----------------------------------------------------------------------------------------------+
| DANH SÁCH MẶT HÀNG XUẤT CẤP PHÁT                              [+ Thêm dòng]  [Quét mã vạch]   |
+----+-------------+------------------------------------+-------+----------+--------------+-----+
| STT| Mã VT       | Tên vật tư                         | ĐVT   | SL Duyệt | SL Thực xuất | Kho |
+----+-------------+------------------------------------+-------+----------+--------------+-----+
| 1  | VT-DELL-OPT | Máy tính để bàn Dell OptiPlex      | Bộ    | 5        | [ 5    ]     | ĐỦ  |
| 2  | VT-LOGI-M331| Chuột quang không dây Logitech M331| Chiếc | 5        | [ 5    ]     | ĐỦ  |
+----+-------------+------------------------------------+-------+----------+--------------+-----+
| Đại diện nhận: [ NV004 - Phạm Minh Tuấn - Phòng CNTT & Kỹ thuật                              ]|
| Ghi chú:       [ Cấp phát trang bị phòng thực hành tin học theo phê duyệt của Quản lý kho    ]|
|                                                                                               |
|                                                     TỔNG SỐ LƯỢNG XUẤT: 10 đơn vị             |
+-----------------------------------------------------------------------------------------------+
```
