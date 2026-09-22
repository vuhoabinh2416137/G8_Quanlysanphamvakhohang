# 03 - Đặc tả Chi tiết Ca sử dụng (Use Case Specifications)

---

## UC06: Tạo Phiếu Nhập Kho

### Thông tin tổng quan

| Mục | Nội dung |
|-----|---------|
| **Tên ca sử dụng** | Tạo Phiếu Nhập Kho |
| **ID** | UC06 |
| **Tác nhân chính** | Nhân viên kho (Warehouse Staff) |
| **Các bên liên quan** | Quản lý kho (kiểm tra), Nhà cung cấp (bên giao hàng) |
| **Mô tả** | Nhân viên kho tạo phiếu nhập kho khi nhận hàng hóa, ghi nhận chi tiết sản phẩm nhập, số lượng, và cập nhật tồn kho tương ứng |
| **Loại** | Complex (>7 transactions) |
| **Tiền điều kiện** | - Nhân viên kho đã đăng nhập hệ thống<br>- Hàng hóa đã được giao đến kho |
| **Hậu điều kiện** | - Phiếu nhập kho được lưu trong hệ thống<br>- Tồn kho được cập nhật (tăng)<br>- Nếu nhập kho từ đơn mua: trạng thái đơn mua được cập nhật |

### Luồng sự kiện chính (Main Flow)

| Bước | Tác nhân | Hệ thống |
|------|---------|---------|
| 1 | NV kho chọn chức năng "Tạo phiếu nhập kho" | |
| 2 | | Hệ thống hiển thị biểu mẫu tạo phiếu nhập kho với mã phiếu tự sinh, ngày hiện tại |
| 3 | NV kho chọn kho nhận hàng từ danh sách kho | |
| 4 | | Hệ thống hiển thị thông tin kho được chọn |
| 5 | NV kho chọn lý do nhập kho (từ NCC, chuyển kho, kiểm kê điều chỉnh) | |
| 6 | NV kho nhập thông tin nhà cung cấp (nếu nhập từ NCC) hoặc chọn đơn mua hàng liên quan | |
| 7 | | Nếu có đơn mua, hệ thống hiển thị danh sách sản phẩm trong đơn mua |
| 8 | NV kho thêm từng mục hàng vào phiếu: chọn sản phẩm, nhập số lượng thực nhận, đơn giá nhập | |
| 9 | | Hệ thống kiểm tra tính hợp lệ dữ liệu (số lượng > 0, sản phẩm tồn tại) |
| 10 | NV kho lặp lại bước 8-9 cho đến khi nhập xong tất cả mục hàng | |
| 11 | NV kho nhập ghi chú (nếu có) và xác nhận hoàn thành phiếu | |
| 12 | | Hệ thống tính tổng giá trị phiếu nhập |
| 13 | | Hệ thống lưu phiếu nhập kho |
| 14 | | Hệ thống cập nhật tồn kho cho từng sản phẩm (tăng số lượng) |
| 15 | | Nếu có đơn mua liên quan, hệ thống cập nhật trạng thái đơn mua |
| 16 | | Hệ thống hiển thị xác nhận tạo phiếu nhập kho thành công |

### Luồng thay thế (Alternative Flows)

**A1: Không tìm thấy sản phẩm (Bước 8)**
- 8a. NV kho nhập mã sản phẩm không tồn tại trong hệ thống
- 8b. Hệ thống hiển thị thông báo "Sản phẩm không tồn tại"
- 8c. NV kho có thể tạo sản phẩm mới hoặc nhập lại mã sản phẩm
- Quay lại bước 8

**A2: Nhập kho từ đơn mua hàng (Bước 6)**
- 6a. NV kho chọn "Nhập từ đơn mua hàng"
- 6b. Hệ thống hiển thị danh sách đơn mua đã duyệt, chưa nhận hết hàng
- 6c. NV kho chọn đơn mua
- 6d. Hệ thống tự động điền danh sách sản phẩm và số lượng từ đơn mua
- Tiếp tục bước 8 (NV kho có thể chỉnh sửa số lượng thực nhận)

**A3: Hủy phiếu nhập kho (Bước bất kỳ)**
- NV kho chọn "Hủy"
- Hệ thống xác nhận hủy, không lưu phiếu, quay về màn hình chính

### Luồng ngoại lệ (Exception Flows)

**E1: Số lượng nhập vượt quá đơn mua (Bước 9)**
- 9a. Số lượng thực nhận > số lượng trong đơn mua
- 9b. Hệ thống hiển thị cảnh báo "Số lượng vượt quá đơn mua"
- 9c. NV kho xác nhận nhập vượt hoặc điều chỉnh lại số lượng

---

## UC07: Tạo Phiếu Xuất Kho

### Thông tin tổng quan

| Mục | Nội dung |
|-----|---------|
| **Tên ca sử dụng** | Tạo Phiếu Xuất Kho |
| **ID** | UC07 |
| **Tác nhân chính** | Nhân viên kho (Warehouse Staff) |
| **Các bên liên quan** | Quản lý kho, Nhân viên kho, Nhà cung cấp (nếu xuất trả) |
| **Mô tả** | Nhân viên kho tạo phiếu xuất kho khi cần xuất hàng hóa ra khỏi kho (chuyển kho nội bộ, trả hàng nhà cung cấp, xuất hủy hàng hỏng/hết hạn, hoặc điều chỉnh kiểm kê) |
| **Loại** | Complex |
| **Tiền điều kiện** | - Nhân viên kho đã đăng nhập<br>- Hàng hóa cần xuất có sẵn trong kho |
| **Hậu điều kiện** | - Phiếu xuất kho được lưu vào hệ thống<br>- Tồn kho được cập nhật (giảm)<br>- Cảnh báo tồn kho thấp được kích hoạt nếu chạm ngưỡng |

### Luồng sự kiện chính (Main Flow)

| Bước | Tác nhân | Hệ thống |
|------|---------|---------|
| 1 | NV kho chọn chức năng "Tạo phiếu xuất kho" | |
| 2 | | Hệ thống hiển thị biểu mẫu tạo phiếu xuất kho, tự sinh mã phiếu |
| 3 | NV kho chọn kho xuất hàng | |
| 4 | NV kho chọn lý do xuất kho (chuyển kho nội bộ, xuất trả nhà cung cấp, xuất hủy, điều chỉnh kiểm kê) | |
| 5 | NV kho chọn địa điểm/đối tác tiếp nhận (kho đích, nhà cung cấp, hoặc bộ phận hủy hàng) | |
| 6 | | Nếu xuất chuyển kho, hệ thống kiểm tra và hiển thị danh mục kho nhận hợp lệ |
| 7 | NV kho thêm từng mục hàng: chọn sản phẩm, nhập số lượng xuất | |
| 8 | | Hệ thống kiểm tra tồn kho: Số lượng xuất ≤ Tồn kho hiện có |
| 9 | | Hệ thống tính đơn giá xuất và tổng giá trị |
| 10 | NV kho lặp lại bước 7-9 cho đến khi hoàn thành | |
| 11 | NV kho xác nhận phiếu xuất kho | |
| 12 | | Hệ thống lưu phiếu xuất kho |
| 13 | | Hệ thống cập nhật tồn kho (giảm số lượng) |
| 14 | | Kiểm tra ngưỡng tồn kho: nếu < ngưỡng → kích hoạt UC11 |
| 15 | | Hệ thống hiển thị xác nhận thành công |

### Luồng thay thế

**A1: Tồn kho không đủ (Bước 8)**
- 8a. Hệ thống phát hiện số lượng yêu cầu > tồn kho hiện có
- 8b. Hệ thống hiển thị thông báo "Tồn kho không đủ. Hiện có: X"
- 8c. NV kho giảm số lượng hoặc hủy mục hàng
- Quay lại bước 7

### Luồng ngoại lệ

**E1: Sản phẩm bị khóa do đang kiểm kê (Bước 7)**
- 7a. Sản phẩm đang trong quá trình kiểm kê
- 7b. Hệ thống thông báo "Sản phẩm đang bị khóa do kiểm kê"
- 7c. NV kho chờ hoặc chọn sản phẩm khác

---

## UC13: Tạo Đơn Mua Hàng

### Thông tin tổng quan

| Mục | Nội dung |
|-----|---------|
| **Tên ca sử dụng** | Tạo Đơn Mua Hàng |
| **ID** | UC13 |
| **Tác nhân chính** | Nhân viên mua hàng (Purchasing Staff) |
| **Các bên liên quan** | Quản lý kho (duyệt), Nhà cung cấp (nhận đơn) |
| **Mô tả** | NV mua hàng tạo đơn đặt mua hàng hóa từ nhà cung cấp để bổ sung hàng cho kho |
| **Loại** | Complex |
| **Tiền điều kiện** | - NV mua hàng đã đăng nhập<br>- Có ít nhất 1 nhà cung cấp trong hệ thống |
| **Hậu điều kiện** | - Đơn mua hàng được lưu với trạng thái "Mới tạo"<br>- Chờ Quản lý kho duyệt |

### Luồng sự kiện chính

| Bước | Tác nhân | Hệ thống |
|------|---------|---------|
| 1 | NV mua hàng chọn "Tạo đơn mua hàng" | |
| 2 | | Hệ thống hiển thị biểu mẫu, tự sinh mã đơn mua |
| 3 | NV mua hàng chọn nhà cung cấp từ danh sách | |
| 4 | | Hệ thống hiển thị thông tin NCC và danh sách sản phẩm NCC cung cấp |
| 5 | NV mua hàng chọn kho nhận hàng | |
| 6 | NV mua hàng thêm mục hàng: chọn sản phẩm, nhập số lượng, đơn giá mua | |
| 7 | | Hệ thống kiểm tra tính hợp lệ và tính thành tiền |
| 8 | NV mua hàng lặp lại bước 6-7 | |
| 9 | NV mua hàng nhập ngày giao hàng dự kiến, ghi chú | |
| 10 | NV mua hàng xác nhận tạo đơn | |
| 11 | | Hệ thống lưu đơn mua với trạng thái "Mới tạo" |
| 12 | | Hệ thống gửi thông báo cho Quản lý kho để duyệt (email) |

### Luồng thay thế

**A1: NCC chưa có trong hệ thống (Bước 3)**
- 3a. NV mua hàng chọn "Thêm nhà cung cấp mới"
- 3b. Kích hoạt UC12: Quản lý nhà cung cấp
- 3c. Sau khi thêm NCC, quay lại bước 3

---

## UC09: Kiểm Kê Kho

### Thông tin tổng quan

| Mục | Nội dung |
|-----|---------|
| **Tên ca sử dụng** | Kiểm Kê Kho |
| **ID** | UC09 |
| **Tác nhân chính** | Quản lý kho, Nhân viên kho |
| **Mô tả** | Thực hiện kiểm kê hàng hóa trong kho, so sánh số lượng thực tế với số liệu trên hệ thống, và điều chỉnh chênh lệch |
| **Loại** | Complex |
| **Tiền điều kiện** | - Quản lý kho đã lên kế hoạch kiểm kê<br>- NV kho đã đăng nhập |
| **Hậu điều kiện** | - Phiếu kiểm kê được lưu<br>- Tồn kho được điều chỉnh (nếu có chênh lệch)<br>- Báo cáo chênh lệch được tạo |

### Luồng sự kiện chính

| Bước | Tác nhân | Hệ thống |
|------|---------|---------|
| 1 | Quản lý kho chọn "Tạo phiên kiểm kê" | |
| 2 | | Hệ thống tạo phiên kiểm kê, tự sinh mã |
| 3 | Quản lý kho chọn kho cần kiểm kê, phạm vi (toàn bộ hoặc theo danh mục) | |
| 4 | | Hệ thống tạo danh sách sản phẩm cần kiểm kê với số lượng hệ thống |
| 5 | NV kho đi kiểm đếm thực tế và nhập số lượng thực tế cho từng sản phẩm | |
| 6 | | Hệ thống so sánh số lượng thực tế và số lượng hệ thống |
| 7 | | Hệ thống hiển thị danh sách chênh lệch (thừa/thiếu) |
| 8 | Quản lý kho xem xét chênh lệch, nhập lý do cho từng chênh lệch | |
| 9 | Quản lý kho xác nhận điều chỉnh | |
| 10 | | Hệ thống cập nhật tồn kho theo số lượng thực tế |
| 11 | | Hệ thống tạo phiếu điều chỉnh (nhập/xuất) tương ứng |
| 12 | | Hệ thống lưu báo cáo kiểm kê |

### Luồng thay thế

**A1: Không có chênh lệch (Bước 7)**
- 7a. Số lượng thực tế = số lượng hệ thống cho tất cả sản phẩm
- 7b. Hệ thống thông báo "Kiểm kê hoàn tất - Không có chênh lệch"
- 7c. Hệ thống lưu phiên kiểm kê, bỏ qua bước 8-11

---

## UC14: Duyệt Đơn Mua Hàng

### Thông tin tổng quan

| Mục | Nội dung |
|-----|---------|
| **Tên ca sử dụng** | Duyệt Đơn Mua Hàng |
| **ID** | UC14 |
| **Tác nhân chính** | Quản lý kho (Warehouse Manager) |
| **Mô tả** | Quản lý kho xem xét và phê duyệt hoặc từ chối các đơn mua hàng do NV mua hàng tạo |
| **Loại** | Average |
| **Tiền điều kiện** | - Có đơn mua hàng với trạng thái "Mới tạo"<br>- Quản lý kho đã đăng nhập |
| **Hậu điều kiện** | - Đơn mua chuyển trạng thái "Đã duyệt" hoặc "Từ chối" |

### Luồng sự kiện chính

| Bước | Tác nhân | Hệ thống |
|------|---------|---------|
| 1 | Quản lý kho xem danh sách đơn mua chờ duyệt | |
| 2 | | Hệ thống hiển thị danh sách đơn mua, sắp xếp theo ngày tạo |
| 3 | Quản lý kho chọn 1 đơn mua để xem chi tiết | |
| 4 | | Hệ thống hiển thị chi tiết: NCC, sản phẩm, số lượng, đơn giá, tổng tiền |
| 5 | Quản lý kho chọn "Phê duyệt" | |
| 6 | | Hệ thống cập nhật trạng thái đơn mua thành "Đã duyệt" |
| 7 | | Hệ thống gửi thông báo cho NV mua hàng và NCC |

### Luồng thay thế

**A1: Từ chối đơn mua (Bước 5)**
- 5a. Quản lý kho chọn "Từ chối"
- 5b. Quản lý kho nhập lý do từ chối
- 5c. Hệ thống cập nhật trạng thái "Từ chối" kèm lý do
- 5d. Gửi thông báo cho NV mua hàng
