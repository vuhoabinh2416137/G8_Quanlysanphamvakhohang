# 01 - Yêu cầu Hệ thống (System Request)

## System Request - Hệ thống Quản lý Sản phẩm và Kho hàng

| Mục | Nội dung |
|-----|---------|
| **Project Sponsor** | Ban Giám đốc Công ty Thương mại ABC |
| **Business Need** | Công ty cần một hệ thống thông tin để quản lý sản phẩm, kho hàng, đơn mua hàng, nhà cung cấp và nhân viên. Hiện tại việc quản lý bằng sổ sách và bảng tính Excel gây ra nhiều sai sót, thiếu kiểm soát tồn kho, và khó khăn trong báo cáo thống kê. |
| **Business Requirements** | 1. Quản lý danh mục sản phẩm với phân loại theo danh mục<br>2. Quản lý nhập/xuất kho hàng hóa tại nhiều kho<br>3. Quản lý đơn đặt hàng mua từ nhà cung cấp<br>4. Kiểm kê và theo dõi tồn kho theo thời gian thực<br>5. Cảnh báo tự động khi tồn kho giảm dưới ngưỡng<br>6. Báo cáo thống kê: tồn kho, mua hàng<br>7. Quản lý nhân viên và phân quyền truy cập |
| **Business Value** | - Giảm 80% sai sót trong quản lý kho<br>- Tăng 50% hiệu quả xử lý nhập/xuất kho<br>- Báo cáo tức thời thay vì mất vài ngày tổng hợp<br>- Kiểm soát tồn kho chính xác, tránh thất thoát<br>- Hỗ trợ ra quyết định mua hàng dựa trên dữ liệu |
| **Special Issues or Constraints** | - Hệ thống Web, truy cập qua trình duyệt<br>- Hỗ trợ nhiều kho hàng<br>- Phân quyền theo vai trò<br>- Tích hợp hệ thống email để gửi thông báo<br>- Thời gian phát triển: 6 tháng |

---

## Phạm vi hệ thống

### Bối cảnh nghiệp vụ

Công ty Thương mại ABC là doanh nghiệp kinh doanh thương mại tổng hợp, quản lý nhiều loại sản phẩm tại nhiều kho hàng khác nhau. Quy trình nghiệp vụ chính bao gồm:

1. **Quy trình mua hàng**: Nhân viên mua hàng tạo đơn mua → Quản lý kho duyệt → Nhà cung cấp giao hàng → Nhân viên kho nhận hàng và tạo phiếu nhập kho → Cập nhật tồn kho.

2. **Quy trình xuất kho**: Nhân viên kho nhận yêu cầu xuất (chuyển kho, trả NCC, hủy hàng) → Kiểm tra tồn kho → Tạo phiếu xuất kho → Cập nhật tồn kho.

3. **Quy trình kiểm kê**: Quản lý kho lên kế hoạch kiểm kê → Nhân viên kho thực hiện kiểm kê → So sánh thực tế với hệ thống → Điều chỉnh chênh lệch.

4. **Quy trình cảnh báo**: Hệ thống tự động giám sát tồn kho → Khi tồn kho giảm dưới ngưỡng → Gửi cảnh báo cho quản lý kho.

### Các yêu cầu chức năng

| ID | Yêu cầu | Mức ưu tiên |
|----|---------|-------------|
| FR01 | Quản lý thông tin sản phẩm (thêm, sửa, xóa, tìm kiếm) | Cao |
| FR02 | Quản lý danh mục sản phẩm (phân loại theo nhóm/danh mục) | Cao |
| FR03 | Quản lý thông tin nhà cung cấp | Cao |
| FR04 | Tạo và quản lý đơn mua hàng | Cao |
| FR05 | Duyệt đơn mua hàng | Cao |
| FR06 | Tạo phiếu nhập kho khi nhận hàng | Cao |
| FR07 | Tạo phiếu xuất kho (chuyển kho, trả NCC, hủy hàng, điều chỉnh) | Cao |
| FR08 | Theo dõi tồn kho theo thời gian thực | Cao |
| FR09 | Kiểm kê kho hàng | Trung bình |
| FR10 | Chuyển kho giữa các kho hàng | Trung bình |
| FR11 | Cảnh báo tồn kho dưới ngưỡng | Cao |
| FR12 | Báo cáo tồn kho | Cao |
| FR13 | Báo cáo mua hàng | Trung bình |
| FR14 | Quản lý nhân viên | Trung bình |
| FR15 | Đăng nhập/Đăng xuất và phân quyền | Cao |

### Các yêu cầu phi chức năng

| ID | Loại | Yêu cầu |
|----|------|---------|
| NFR01 | Vận hành | Hệ thống Web, hoạt động trên mọi trình duyệt hiện đại |
| NFR02 | Vận hành | Hỗ trợ nhiều kho hàng |
| NFR03 | Vận hành | Tích hợp hệ thống email thông báo |
| NFR04 | Hiệu năng | Thời gian phản hồi < 3 giây |
| NFR05 | Hiệu năng | Hỗ trợ tối thiểu 50 người dùng đồng thời |
| NFR06 | Bảo mật | Phân quyền theo vai trò (RBAC) |
| NFR07 | Bảo mật | Mã hóa mật khẩu |
| NFR08 | Bảo mật | Ghi log hoạt động người dùng |
| NFR09 | Độ tin cậy | Sao lưu dữ liệu tự động hàng ngày |
| NFR10 | Giao diện | Giao diện thân thiện, dễ sử dụng |