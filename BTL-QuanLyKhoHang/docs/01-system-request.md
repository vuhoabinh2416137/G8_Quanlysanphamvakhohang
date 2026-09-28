# 01 - Yêu cầu Hệ thống (System Request)

## System Request - Hệ thống Quản lý Kho hàng và Vật tư Nội bộ Tổ chức

| Mục | Nội dung |
|-----|---------|
| **Project Sponsor** | Ban Giám đốc / Lãnh đạo Cơ quan Tổ chức ABC |
| **Business Need** | Tổ chức cần một hệ thống thông tin hiện đại để quản lý tài sản, vật tư, trang thiết bị và kho hàng nội bộ. Hệ thống phục vụ việc tiếp nhận phân bổ, cấp phát vật tư cho các phòng ban/đơn vị trực thuộc, điều chuyển giữa các kho nội bộ, kiểm kê định kỳ và giám sát tồn kho theo thời gian thực. Hiện tại việc quản lý bằng sổ sách và bảng tính Excel gây ra nhiều sai sót, thiếu minh bạch trong phân bổ vật tư, nguy cơ thất thoát tài sản và chậm trễ trong báo cáo thống kê. **Lưu ý: Hệ thống quản lý tài sản nội bộ của một tổ chức, hoàn toàn không có hoạt động mua bán hay giao dịch thương mại.** |
| **Business Requirements** | 1. Quản lý danh mục vật tư, trang thiết bị theo cấu trúc phân cấp đa tầng<br>2. Tiếp nhận và nhập kho vật tư từ phân bổ cấp trên, hoàn nhập thu hồi từ phòng ban<br>3. Quản lý lập và phê duyệt phiếu yêu cầu cấp phát vật tư từ các phòng ban nội bộ<br>4. Quản lý xuất kho cấp phát vật tư và điều chuyển giữa các kho nội bộ của tổ chức<br>5. Kiểm kê kho định kỳ, chốt số liệu sổ sách và xử lý chênh lệch thực tế<br>6. Giám sát tồn kho thời gian thực, cảnh báo tự động khi số lượng chạm ngưỡng an toàn<br>7. Báo cáo thống kê: tồn kho, biến động xuất-nhập-tồn, tổng hợp cấp phát theo phòng ban<br>8. Quản lý hồ sơ nhân viên, cơ cấu phòng ban và phân quyền truy cập theo vai trò (RBAC) |
| **Business Value** | - Giảm 85% sai sót và thất thoát trong quản lý vật tư tài sản nội bộ<br>- Tăng 60% tốc độ xử lý quy trình yêu cầu và cấp phát vật tư cho các phòng ban<br>- Báo cáo xuất-nhập-tồn tức thời phục vụ công tác lập kế hoạch ngân sách và phân bổ tài sản<br>- Kiểm soát chính xác vị trí lưu kho và định mức sử dụng vật tư của từng bộ phận |
| **Special Issues or Constraints** | - Ứng dụng Web truy cập qua trình duyệt, tương thích thiết bị cầm tay quét mã vạch kho (PDA)<br>- Hỗ trợ mô hình đa kho nội bộ trong cùng khuôn viên hoặc chi nhánh<br>- Phân quyền chặt chẽ theo vai trò (Admin, Quản lý kho, Thủ kho, Đại diện phòng ban)<br>- Tích hợp dịch vụ email thông báo kết quả duyệt cấp phát và cảnh báo tồn kho<br>- Thời gian phát triển: 6 tháng |

---

## Phạm vi Hệ thống

### Bối cảnh nghiệp vụ

Tổ chức ABC quản lý nhiều cơ sở/phòng ban với nhu cầu sử dụng trang thiết bị, công cụ dụng cụ và vật tư văn phòng lớn tại nhiều kho lưu trữ. Chu trình vận hành kho nội bộ gồm:

1. **Quy trình tiếp nhận & Nhập kho nội bộ**: Tiếp nhận vật tư phân bổ từ đơn vị cấp trên hoặc thu hồi hoàn nhập trang thiết bị từ các phòng ban → Nhân viên kho tiếp nhận, kiểm đếm quy cách chất lượng thực tế → Lập phiếu nhập kho → Hệ thống cập nhật tăng tồn kho vật lý và ghi log lịch sử.

2. **Quy trình yêu cầu & Cấp phát vật tư**: Đại diện các phòng ban lập phiếu yêu cầu cấp phát vật tư theo nhu cầu công tác → Quản lý kho xem xét định mức và số lượng tồn khả dụng để phê duyệt → Nhân viên kho lập phiếu xuất kho cấp phát → Đại diện phòng ban ký nhận biên bản bàn giao → Hệ thống tự động trừ tồn kho.

3. **Quy trình điều chuyển kho nội bộ**: Quản lý kho tạo lệnh điều chuyển vật tư giữa kho trung tâm và các kho phụ/kho chi nhánh → Thực hiện xuất kho nguồn và nhập kho đích đồng bộ.

4. **Quy trình kiểm kê**: Quản lý kho lên kế hoạch kiểm kê → Hệ thống chốt số liệu sổ sách và tạm khóa giao dịch → Nhân viên kho kiểm đếm thực tế → Hệ thống so sánh, hiển thị sai lệch thừa/thiếu → Phê duyệt điều chỉnh cân đối tồn kho.

5. **Quy trình giám sát & Cảnh báo định mức**: Hệ thống tự động theo dõi mức tồn khả dụng → Khi số lượng giảm xuống dưới ngưỡng an toàn tối thiểu → Tự động gửi cảnh báo lên Dashboard và gửi email cho Quản lý kho để có kế hoạch đề xuất tiếp nhận bổ sung.

---

### Các yêu cầu chức năng

| ID | Yêu cầu | Mức ưu tiên |
|----|---------|-------------|
| FR01 | Quản lý thông tin vật tư, thiết bị (thêm, sửa, ngừng sử dụng, tìm kiếm) | Cao |
| FR02 | Quản lý danh mục vật tư (phân loại nhóm/loại vật tư đa cấp) | Cao |
| FR03 | Quản lý danh mục phòng ban, đơn vị nội bộ trực thuộc tổ chức | Cao |
| FR04 | Tạo và theo dõi phiếu yêu cầu cấp phát vật tư từ phòng ban | Cao |
| FR05 | Phê duyệt hoặc từ chối yêu cầu cấp phát vật tư | Cao |
| FR06 | Tạo phiếu nhập kho (tiếp nhận phân bổ, hoàn nhập thu hồi, kiểm kê thừa) | Cao |
| FR07 | Tạo phiếu xuất kho (cấp phát phòng ban, chuyển kho, thanh lý hủy, kiểm kê thiếu) | Cao |
| FR08 | Theo dõi tồn kho theo thời gian thực và vị trí lưu trữ | Cao |
| FR09 | Kiểm kê kho định kỳ, chốt sổ và xử lý cân đối chênh lệch | Trung bình |
| FR10 | Điều chuyển vật tư giữa các kho nội bộ | Trung bình |
| FR11 | Cảnh báo tự động khi số lượng tồn kho giảm dưới ngưỡng định mức | Cao |
| FR12 | Báo cáo tồn kho tổng hợp và theo từng kho lưu trữ | Cao |
| FR13 | Báo cáo xuất - nhập - tồn và thống kê cấp phát vật tư theo từng phòng ban | Trung bình |
| FR14 | Quản lý thông tin nhân viên theo phòng ban/bộ phận | Trung bình |
| FR15 | Đăng nhập/Đăng xuất và phân quyền người dùng theo vai trò (RBAC) | Cao |

---

### Các yêu cầu phi chức năng

| ID | Loại | Yêu cầu |
|----|------|---------|
| NFR01 | Vận hành | Ứng dụng Web hoạt động trên mọi trình duyệt hiện đại (Chrome, Edge, Firefox) |
| NFR02 | Vận hành | Hỗ trợ quản lý đa kho hàng nội bộ và vị trí ô/kệ lưu kho |
| NFR03 | Vận hành | Tích hợp cổng SMTP gửi email tự động (thông báo duyệt cấp phát, cảnh báo tồn) |
| NFR04 | Hiệu năng | Thời gian phản hồi các thao tác tra cứu, nhập liệu `< 3` giây |
| NFR05 | Hiệu năng | Đảm bảo phục vụ tối thiểu 50 người dùng thao tác đồng thời không suy giảm hiệu năng |
| NFR06 | Bảo mật | Kiểm soát truy cập nghiêm ngặt dựa trên vai trò người dùng (RBAC) |
| NFR07 | Bảo mật | Mã hóa mật khẩu người dùng với thuật toán bcrypt, xác thực phiên bằng JWT |
| NFR08 | Bảo mật | Ghi nhật ký hệ thống (Audit Log) cho mọi giao dịch xuất/nhập kho và kiểm kê |
| NFR09 | Độ tin cậy | Tự động sao lưu dữ liệu toàn diện hàng ngày lúc 02:00 sáng |
| NFR10 | Giao diện | Giao diện thân thiện, chuẩn hóa bảng biểu, hỗ trợ phím tắt và thiết bị đọc mã vạch |