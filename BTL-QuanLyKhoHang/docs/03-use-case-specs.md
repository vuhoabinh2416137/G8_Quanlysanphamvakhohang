# 03 - Đặc tả Chi tiết Ca sử dụng (Use Case Specifications)

---

## UC06: Tạo Phiếu Nhập Kho Nội Bộ

### Thông tin tổng quan

| Mục | Nội dung |
|-----|---------|
| **Tên ca sử dụng** | Tạo Phiếu Nhập Kho Nội Bộ |
| **ID** | UC06 |
| **Tác nhân chính** | Nhân viên kho (Warehouse Staff) |
| **Các bên liên quan** | Quản lý kho (kiểm tra, giám sát), Phòng ban / Đơn vị bàn giao vật tư |
| **Mô tả** | Nhân viên kho tạo phiếu nhập kho khi tiếp nhận vật tư bàn giao từ cấp trên, hoàn nhập thu hồi từ các phòng ban, nhận hàng điều chuyển từ kho khác hoặc nhập cân đối sau kiểm kê |
| **Loại** | Complex (>7 transactions) |
| **Tiền điều kiện** | - Nhân viên kho đã đăng nhập thành công vào hệ thống<br>- Vật tư và biên bản bàn giao đã được chuyển đến kho |
| **Hậu điều kiện** | - Phiếu nhập kho được lưu vào hệ thống ở trạng thái `DA_XAC_NHAN`<br>- Tồn kho vật tư tương ứng được tự động cập nhật (tăng số lượng)<br>- Ghi nhật ký giao dịch kho |

### Luồng sự kiện chính (Main Flow)

| Bước | Tác nhân | Hệ thống |
|------|---------|---------|
| 1 | NV kho chọn chức năng "Tạo phiếu nhập kho" | |
| 2 | | Hệ thống hiển thị biểu mẫu tạo phiếu nhập với mã phiếu tự sinh, ngày giờ hiện tại |
| 3 | NV kho chọn kho tiếp nhận từ danh sách kho quản lý | |
| 4 | | Hệ thống hiển thị thông tin kho và vị trí lưu trữ khả dụng |
| 5 | NV kho chọn lý do nhập kho (`TIEP_NHAN_PHAN_BO`, `THU_HOI_PHONG_BAN`, `CHUYEN_KHO_DEN`, `CAN_DOI_KIEM_KE`) | |
| 6 | NV kho chọn phòng ban/đơn vị bàn giao (nếu là hoàn nhập) hoặc nguồn giao | |
| 7 | | Hệ thống hiển thị danh mục vật tư hiện hành của tổ chức |
| 8 | NV kho thêm từng mục vật tư vào phiếu: chọn mã vật tư, nhập số lượng thực nhận, chỉ định vị trí kệ/tầng | |
| 9 | | Hệ thống kiểm tra tính hợp lệ dữ liệu (số lượng `> 0`, vật tư đang ở trạng thái `DANG_SU_DUNG`) |
| 10 | NV kho lặp lại bước 8-9 cho đến khi nhập xong tất cả các mục vật tư | |
| 11 | NV kho nhập ghi chú (nếu có) và xác nhận hoàn tất phiếu nhập | |
| 12 | | Hệ thống lưu phiếu nhập kho vào CSDL |
| 13 | | Hệ thống cập nhật tăng số lượng tồn kho (`TonKho += soLuongThucNhan`) |
| 14 | | Hệ thống ghi log kiểm toán giao dịch (Audit Log) |
| 15 | | Hệ thống hiển thị thông báo tạo phiếu nhập kho thành công và cung cấp tùy chọn in phiếu |

### Luồng thay thế (Alternative Flows)

**A1: Không tìm thấy vật tư trong danh mục (Bước 8)**
- 8a. NV kho tìm kiếm mã vật tư nhưng không có trong danh mục.
- 8b. Hệ thống hiển thị thông báo "Vật tư chưa có trong danh mục tổ chức".
- 8c. NV kho thông báo cho Quản lý kho để tạo mới danh mục vật tư (UC03).
- Quay lại bước 8.

**A2: Hủy bỏ thao tác lập phiếu (Bước bất kỳ trước bước 11)**
- NV kho nhấn nút "Hủy".
- Hệ thống yêu cầu xác nhận hủy bỏ, không lưu dữ liệu tạm, quay về màn hình danh sách phiếu nhập.

---

## UC07: Tạo Phiếu Xuất Kho Nội Bộ

### Thông tin tổng quan

| Mục | Nội dung |
|-----|---------|
| **Tên ca sử dụng** | Tạo Phiếu Xuất Kho Nội Bộ |
| **ID** | UC07 |
| **Tác nhân chính** | Nhân viên kho (Warehouse Staff) |
| **Các bên liên quan** | Quản lý kho (giám sát), Đại diện phòng ban nhận vật tư cấp phát |
| **Mô tả** | Nhân viên kho tạo phiếu xuất kho để cấp phát vật tư cho các phòng ban theo phiếu yêu cầu đã duyệt, điều chuyển sang kho khác, hoặc xuất thanh lý/tiêu hủy vật tư hỏng |
| **Loại** | Complex |
| **Tiền điều kiện** | - Nhân viên kho đã đăng nhập<br>- Vật tư cần xuất có sẵn và đủ số lượng khả dụng trong kho |
| **Hậu điều kiện** | - Phiếu xuất kho được lưu vào hệ thống<br>- Tồn kho được cập nhật (giảm số lượng)<br>- Kích hoạt cảnh báo tự động nếu tồn kho chạm hoặc giảm dưới ngưỡng an toàn (UC11) |

### Luồng sự kiện chính (Main Flow)

| Bước | Tác nhân | Hệ thống |
|------|---------|---------|
| 1 | NV kho chọn chức năng "Tạo phiếu xuất kho" | |
| 2 | | Hệ thống hiển thị biểu mẫu xuất kho với mã phiếu tự sinh |
| 3 | NV kho chọn kho xuất vật tư | |
| 4 | NV kho chọn lý do xuất (`CAP_PHAT_NOI_BO`, `CHUYEN_KHO`, `THANH_LY_HUY`, `CAN_DOI_KIEM_KE`) | |
| 5 | NV kho chọn phòng ban tiếp nhận (hoặc chọn phiếu yêu cầu cấp phát liên quan nếu là xuất cấp phát) | |
| 6 | | Nếu xuất theo yêu cầu cấp phát, hệ thống tự động điền danh sách vật tư và số lượng đã duyệt |
| 7 | NV kho kiểm tra hoặc thêm từng mục vật tư cần xuất: mã vật tư, số lượng thực xuất | |
| 8 | | Hệ thống kiểm tra số lượng tồn kho khả dụng (`soLuongXuat <= TonKho.soLuong`) |
| 9 | NV kho lặp lại bước 7-8 cho đến khi hoàn thành | |
| 10 | NV kho nhập ghi chú và xác nhận xuất kho | |
| 11 | | Hệ thống lưu phiếu xuất kho vào CSDL |
| 12 | | Hệ thống cập nhật giảm số lượng tồn kho |
| 13 | | Hệ thống kiểm tra ngưỡng an toàn: nếu tồn kho `< nguongTonKho` → kích hoạt UC11 (Cảnh báo tồn kho thấp) |
| 14 | | Hệ thống hiển thị xác nhận thành công và hỗ trợ in phiếu bàn giao |

### Luồng thay thế (Alternative Flows)

**A1: Tồn kho không đủ (Bước 8)**
- 8a. Hệ thống phát hiện số lượng yêu cầu xuất vượt quá tồn kho khả dụng tại kho xuất.
- 8b. Hệ thống thông báo lỗi: "Tồn kho không đủ để xuất. Số lượng tồn khả dụng hiện tại: X".
- 8c. NV kho điều chỉnh lại số lượng xuất thực tế hoặc đề xuất điều chuyển từ kho khác.
- Quay lại bước 7.

**A2: Vật tư đang bị tạm khóa kiểm kê (Bước 8)**
- 8a. Vật tư thuộc danh mục kho đang có phiên kiểm kê chưa đóng (`DANG_THUC_HIEN`).
- 8b. Hệ thống hiển thị thông báo "Vật tư đang bị tạm khóa giao dịch do đang trong phiên kiểm kê".
- 8c. NV kho không thể xuất vật tư này cho đến khi phiên kiểm kê hoàn tất.

---

## UC13: Tạo Yêu Cầu Cấp Phát Vật Tư

### Thông tin tổng quan

| Mục | Nội dung |
|-----|---------|
| **Tên ca sử dụng** | Tạo Yêu Cầu Cấp Phát Vật Tư |
| **ID** | UC13 |
| **Tác nhân chính** | Đại diện Phòng ban (Department Staff) |
| **Các bên liên quan** | Quản lý kho (thẩm định, phê duyệt) |
| **Mô tả** | Cán bộ đại diện phòng ban lập phiếu đề nghị cấp phát vật tư, trang thiết bị phục vụ công tác chuyên môn của đơn vị |
| **Loại** | Complex |
| **Tiền điều kiện** | - Đại diện phòng ban đã đăng nhập vào hệ thống<br>- Tài khoản được liên kết với một phòng ban hợp lệ |
| **Hậu điều kiện** | - Phiếu yêu cầu cấp phát được lưu với trạng thái `CHO_DUYET`<br>- Hệ thống gửi thông báo đến Quản lý kho |

### Luồng sự kiện chính (Main Flow)

| Bước | Tác nhân | Hệ thống |
|------|---------|---------|
| 1 | Đại diện PB chọn "Tạo yêu cầu cấp phát" | |
| 2 | | Hệ thống hiển thị biểu mẫu yêu cầu, tự động sinh mã yêu cầu (`YC-YYYYMMDD-XXX`) và hiển thị thông tin phòng ban |
| 3 | Đại diện PB nhập mục đích sử dụng (trang bị mới, thay thế hư hỏng, phục vụ đề tài/dự án) | |
| 4 | Đại diện PB thêm từng mục vật tư: chọn vật tư từ danh mục, nhập số lượng yêu cầu | |
| 5 | | Hệ thống kiểm tra quy chuẩn định mức của phòng ban (nếu có cấu hình) |
| 6 | Đại diện PB lặp lại bước 4-5 cho các vật tư khác | |
| 7 | Đại diện PB nhập ngày cần tiếp nhận dự kiến và ghi chú chi tiết | |
| 8 | Đại diện PB xác nhận gửi phiếu yêu cầu | |
| 9 | | Hệ thống lưu phiếu yêu cầu cấp phát với trạng thái `CHO_DUYET` |
| 10 | | Hệ thống gửi thông báo và email đến Quản lý kho để xem xét phê duyệt |
| 11 | | Hệ thống hiển thị thông báo gửi yêu cầu thành công |

---

## UC14: Duyệt Yêu Cầu Cấp Phát Vật Tư

### Thông tin tổng quan

| Mục | Nội dung |
|-----|---------|
| **Tên ca sử dụng** | Duyệt Yêu Cầu Cấp Phát Vật Tư |
| **ID** | UC14 |
| **Tác nhân chính** | Quản lý kho (Warehouse Manager) |
| **Mô tả** | Quản lý kho xem xét, thẩm định tính hợp lý về định mức và kiểm tra tồn kho khả dụng để phê duyệt hoặc từ chối yêu cầu cấp phát của phòng ban |
| **Loại** | Average |
| **Tiền điều kiện** | - Có phiếu yêu cầu cấp phát đang ở trạng thái `CHO_DUYET`<br>- Quản lý kho đã đăng nhập |
| **Hậu điều kiện** | - Phiếu yêu cầu chuyển sang trạng thái `DA_DUYET` hoặc `TU_CHOI`<br>- Hệ thống gửi email thông báo kết quả cho phòng ban |

### Luồng sự kiện chính (Main Flow)

| Bước | Tác nhân | Hệ thống |
|------|---------|---------|
| 1 | Quản lý kho mở danh sách "Yêu cầu cấp phát chờ duyệt" | |
| 2 | | Hệ thống hiển thị danh sách các phiếu yêu cầu `CHO_DUYET`, sắp xếp theo độ ưu tiên và thời gian |
| 3 | Quản lý kho chọn 1 phiếu yêu cầu để xem chi tiết | |
| 4 | | Hệ thống hiển thị chi tiết phòng ban yêu cầu, mục đích, danh sách vật tư, số lượng yêu cầu, tồn kho khả dụng tương ứng |
| 5 | Quản lý kho xác nhận số lượng duyệt cấp phát cho từng mục (cho phép duyệt đủ hoặc duyệt một phần) | |
| 6 | Quản lý kho chọn "Phê duyệt" | |
| 7 | | Hệ thống cập nhật trạng thái phiếu thành `DA_DUYET`, ghi nhận người duyệt và thời điểm duyệt |
| 8 | | Hệ thống gửi thông báo kết quả qua email cho Đại diện phòng ban và gửi lệnh xuất kho cho Thủ kho |

### Luồng thay thế (Alternative Flows)

**A1: Từ chối yêu cầu cấp phát (Bước 6)**
- 6a. Quản lý kho chọn "Từ chối".
- 6b. Hệ thống yêu cầu Quản lý kho bắt buộc nhập lý do từ chối (vượt định mức, không đúng mục đích sử dụng, kho hết hàng).
- 6c. Hệ thống cập nhật trạng thái thành `TU_CHOI` kèm nội dung lý do.
- 6d. Gửi email thông báo từ chối về Đại diện phòng ban.

---

## UC09: Kiểm Kê Kho Hàng

### Thông tin tổng quan

| Mục | Nội dung |
|-----|---------|
| **Tên ca sử dụng** | Kiểm Kê Kho Hàng |
| **ID** | UC09 |
| **Tác nhân chính** | Quản lý kho, Nhân viên kho |
| **Mô tả** | Tổ chức đợt kiểm kê thực tế vật tư trong kho, so khớp số lượng thực tế với số liệu sổ sách trên hệ thống và tự động tạo phiếu điều chỉnh cân đối kho |
| **Loại** | Complex |
| **Tiền điều kiện** | - Quản lý kho đã lên kế hoạch kiểm kê<br>- Nhân viên kho đã đăng nhập |
| **Hậu điều kiện** | - Phiếu kiểm kê được hoàn tất và lưu trữ<br>- Tồn kho được điều chỉnh khớp đúng với thực tế (nếu có chênh lệch)<br>- Tự động sinh phiếu điều chỉnh tăng/giảm |

### Luồng sự kiện chính (Main Flow)

| Bước | Tác nhân | Hệ thống |
|------|---------|---------|
| 1 | Quản lý kho chọn "Tạo phiên kiểm kê" | |
| 2 | | Hệ thống khởi tạo phiên kiểm kê, tự sinh mã phiên (`PKK-YYYYMMDD-XXX`) |
| 3 | Quản lý kho chọn kho kiểm kê và phạm vi (toàn bộ kho hoặc theo nhóm vật tư) | |
| 4 | | Hệ thống chốt số liệu tồn sổ sách (Stock Snapshot) và tạm khóa xuất/nhập đối với phạm vi kiểm kê |
| 5 | | Hệ thống sinh danh sách kiểm đếm (Count sheet) |
| 6 | NV kho tiến hành đếm thực tế và nhập số lượng thực tế kiểm đếm vào hệ thống | |
| 7 | | Hệ thống so sánh số lượng thực tế và số lượng sổ sách, tính toán chênh lệch (thừa/thiếu) |
| 8 | Quản lý kho xem xét báo cáo chênh lệch, yêu cầu kiểm tra lại nếu cần và nhập lý do giải trình | |
| 9 | Quản lý kho xác nhận phê duyệt kết quả kiểm kê | |
| 10 | | Hệ thống tự động tạo phiếu nhập điều chỉnh (nếu thừa) hoặc phiếu xuất điều chỉnh (nếu thiếu) |
| 11 | | Hệ thống cập nhật số lượng tồn kho chính thức theo số liệu thực tế |
| 12 | | Hệ thống mở khóa giao dịch xuất/nhập và lưu biên bản kiểm kê hoàn tất |
