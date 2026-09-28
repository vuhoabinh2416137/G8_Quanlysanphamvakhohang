# 16 - Ước lượng Chi phí Dự án theo Phương pháp Use Case Points (UCP)

## Giới thiệu Phương pháp luận

Theo giáo trình **IT3120 - Ước lượng Chi phí Thực hiện Dự án theo UCP (Use Case Points)** của Đại học Bách Khoa Hà Nội (phát triển từ phương pháp của Gustav Karner - 1993):
Phương pháp UCP là kỹ thuật đo lường kích thước phần mềm dựa trên các ca sử dụng (Use Cases), tính toán độ phức tạp kỹ thuật và năng lực môi trường của đội ngũ triển khai để dự báo:
1. Tổng điểm ca sử dụng (UCP).
2. Tổng nỗ lực thực hiện tính theo giờ công (Person-Hours).
3. Thời gian phát triển và chi phí ngân sách dự kiến.

Hệ thống tập trung cốt lõi vào **Quản lý Kho hàng và Vật tư Nội bộ Tổ chức** (hoàn toàn không có nghiệp vụ mua bán thương mại).

---

## 1. Tính toán Trọng số Tác nhân Chưa hiệu chỉnh (UAW - Unadjusted Actor Weight)

Phân loại tác nhân theo mức độ phức tạp giao tiếp với hệ thống:

| Tác nhân | Phân loại | Định nghĩa | Trọng số ($W$) | Số lượng | Thành tiền ($W \times Q$) |
|----------|-----------|------------|----------------|----------|---------------------------|
| Quản trị viên (Admin) | Complex | Thao tác qua GUI Web phân quyền, quản trị tài khoản | 3 | 1 | 3 |
| Quản lý kho (Warehouse Manager) | Complex | Thao tác qua GUI Web duyệt cấp phát, chuyển kho, kiểm kê | 3 | 1 | 3 |
| Đại diện Phòng ban (Department Staff)| Complex | Thao tác qua GUI Web tạo yêu cầu cấp phát, ký nhận | 3 | 1 | 3 |
| Nhân viên kho (Warehouse Staff) | Complex | Thao tác qua Web / PDA quét mã vạch nhập/xuất/kiểm đếm | 3 | 1 | 3 |
| Dịch vụ Email (SMTP Gateway) | Simple | Hệ thống ngoài nhận thông báo tự động (API / SMTP) | 1 | 1 | 1 |

$$\mathbf{UAW = 4 \times 3 + 1 \times 1 = 12 + 1 = 13}$$

---

## 2. Tính toán Trọng số Ca sử dụng Chưa hiệu chỉnh (UUCW - Unadjusted Use Case Weight)

Phân loại ca sử dụng theo số lượng giao dịch nghiệp vụ (Transactions):
- **Simple (Đơn giản)**: 1 - 3 transactions (Trọng số = 5)
- **Average (Trung bình)**: 4 - 7 transactions (Trọng số = 10)
- **Complex (Phức tạp)**: > 7 transactions (Trọng số = 15)

### Bảng phân loại 18 Ca sử dụng của Hệ thống:

| Mã UC | Tên Ca sử dụng | Tác nhân chính | Số giao dịch | Phân loại | Trọng số |
|-------|----------------|----------------|--------------|-----------|----------|
| UC01 | Đăng nhập / Đăng xuất | Tất cả | 2 | Simple | 5 |
| UC02 | Phân quyền người dùng (RBAC) | Admin | 5 | Average | 10 |
| UC03 | Quản lý vật tư, thiết bị (CRUD) | Quản lý kho | 6 | Average | 10 |
| UC04 | Quản lý danh mục vật tư | Quản lý kho | 3 | Simple | 5 |
| UC05 | Tìm kiếm & tra cứu vật tư | Tất cả | 2 | Simple | 5 |
| UC06 | Tạo phiếu nhập kho nội bộ | NV Kho | 10 | Complex | 15 |
| UC07 | Tạo phiếu xuất kho nội bộ | NV Kho | 9 | Complex | 15 |
| UC08 | Chuyển kho nội bộ | Quản lý kho | 6 | Average | 10 |
| UC09 | Kiểm kê kho & cân đối | Quản lý kho, NV Kho | 11 | Complex | 15 |
| UC10 | Tra cứu tồn kho tức thời | Quản lý kho, NV Kho | 4 | Average | 10 |
| UC11 | Cảnh báo tồn kho dưới ngưỡng | Hệ thống | 2 | Simple | 5 |
| UC12 | Quản lý phòng ban / đơn vị | Quản lý kho, Admin | 5 | Average | 10 |
| UC13 | Tạo yêu cầu cấp phát vật tư | Đại diện Phòng ban | 9 | Complex | 15 |
| UC14 | Duyệt / từ chối yêu cầu cấp phát | Quản lý kho | 4 | Average | 10 |
| UC15 | Bàn giao & tiếp nhận vật tư | NV Kho, Đại diện PB | 8 | Complex | 15 |
| UC16 | Quản lý nhân viên | Admin | 5 | Average | 10 |
| UC17 | Xem báo cáo tồn kho & biến động | Quản lý kho | 6 | Average | 10 |
| UC18 | Báo cáo X-N-T & cấp phát PB | Admin, Quản lý kho | 5 | Average | 10 |

### Tổng hợp UUCW:
- **Số ca sử dụng Simple**: 4 ca (UC01, UC04, UC05, UC11) $\rightarrow 4 \times 5 = 20$
- **Số ca sử dụng Average**: 9 ca (UC02, UC03, UC08, UC10, UC12, UC14, UC16, UC17, UC18) $\rightarrow 9 \times 10 = 90$
- **Số ca sử dụng Complex**: 5 ca (UC06, UC07, UC09, UC13, UC15) $\rightarrow 5 \times 15 = 75$

$$\mathbf{UUCW = 20 + 90 + 75 = 185}$$

---

## 3. Điểm Ca sử dụng Chưa hiệu chỉnh (UUCP)

$$\mathbf{UUCP = UAW + UUCW = 13 + 185 = 198}$$

---

## 4. Hệ số Phức tạp Kỹ thuật (TCF - Technical Complexity Factor)

Gồm 13 yếu tố kỹ thuật chuẩn ($T_1$ đến $T_{13}$):
$$TCF = 0.6 + \left(0.01 \times \sum_{i=1}^{13} (W_i \times C_i)\right)$$

| Mã | Yếu tố kỹ thuật | Trọng số ($W_i$) | Điểm gán ($C_i$: 0-5) | $W_i \times C_i$ | Đánh giá thực tế trong dự án |
|----|-----------------|-------------------|------------------------|------------------|------------------------------|
| T1 | Hệ thống phân tán | 2.0 | 3 | 6.0 | Hệ thống 3 tầng Web Client-Server-DB |
| T2 | Mục tiêu hiệu năng | 1.0 | 4 | 4.0 | Yêu cầu đáp ứng `< 3s`, chịu tải 50 concurrent users |
| T3 | Hiệu quả cho người dùng cuối | 1.0 | 4 | 4.0 | Giao diện thân thiện, hỗ trợ quét mã vạch kho |
| T4 | Xử lý nội bộ phức tạp | 1.0 | 4 | 4.0 | Thuật toán cân đối kiểm kê, định mức phòng ban |
| T5 | Tính tái sử dụng mã nguồn | 1.0 | 3 | 3.0 | Áp dụng Generic DAM, Factory, Observer pattern |
| T6 | Dễ cài đặt | 0.5 | 3 | 1.5 | Đóng gói Docker / file JAR tiêu chuẩn |
| T7 | Dễ sử dụng | 0.5 | 4 | 2.0 | Tối ưu hóa phím tắt, tìm kiếm kho thông minh |
| T8 | Khả năng chuyển đổi môi trường | 2.0 | 3 | 6.0 | Chạy trên nền tảng Web tiêu chuẩn |
| T9 | Dễ thay đổi / bảo trì | 1.0 | 4 | 4.0 | Thiết kế theo nguyên lý SOLID & Clean Architecture |
| T10| Tính đồng thời cao | 1.0 | 4 | 4.0 | Nhiều thủ kho nhập/xuất đồng thời, khóa mức dòng |
| T11| Tính năng an toàn đặc biệt | 1.0 | 3 | 3.0 | Phân quyền RBAC, mã hóa mật khẩu, JWT, Audit log |
| T12| Truy cập trực tiếp từ bên thứ 3 | 1.0 | 2 | 2.0 | Tích hợp dịch vụ gửi Email thông báo tự động (SMTP)|
| T13| Đào tạo người dùng đặc biệt | 1.0 | 2 | 2.0 | Nghiệp vụ chuẩn kho nội bộ, có tài liệu hướng dẫn |
| **Tổng** | | | | **41.5** | |

$$TCF = 0.6 + (0.01 \times 41.5) = 0.6 + 0.415 = \mathbf{1.015}$$

---

## 5. Hệ số Môi trường (EF - Environmental Complexity Factor)

Gồm 8 yếu tố môi trường năng lực đội ngũ ($E_1$ đến $E_8$):
$$EF = 1.4 + \left(-0.03 \times \sum_{i=1}^{8} (W_i \times E_i)\right)$$

| Mã | Yếu tố môi trường | Trọng số ($W_i$) | Điểm gán ($E_i$: 0-5) | $W_i \times E_i$ | Đánh giá năng lực nhóm dự án |
|----|-------------------|-------------------|------------------------|------------------|------------------------------|
| E1 | Quen thuộc với quy trình RUP/EUP | 1.5 | 4 | 6.0 | Đã hoàn thành các bài tập môn IT3120 |
| E2 | Kinh nghiệm ứng dụng nghiệp vụ | 0.5 | 3 | 1.5 | Hiểu rõ nghiệp vụ quản lý kho nội bộ |
| E3 | Kinh nghiệm hướng đối tượng | 1.0 | 4 | 4.0 | Thành thạo Java OOP và UML 2.5 |
| E4 | Khả năng lãnh đạo nhóm | 0.5 | 4 | 2.0 | Nhóm trưởng điều phối tốt, phân chia rõ ràng |
| E5 | Động lực làm việc | 1.0 | 4 | 4.0 | Tinh thần trách nhiệm cao, hướng tới điểm A/A+ |
| E6 | Độ ổn định yêu cầu | 2.0 | 3 | 6.0 | Phạm vi dự án được chốt rõ ràng từ System Request |
| E7 | Nhân sự bán thời gian | -1.0 | 2 | -2.0 | Sinh viên làm thêm hoặc học song song các môn khác |
| E8 | Độ khó ngôn ngữ lập trình | -1.0 | 0 | 0.0 | Sử dụng Java/Spring Boot phổ biến, thư viện dồi dào |
| **Tổng** | | | | **21.5** | |

$$EF = 1.4 + (-0.03 \times 21.5) = 1.4 - 0.645 = \mathbf{0.755}$$

---

## 6. Tính toán Điểm Ca sử dụng Đã hiệu chỉnh (UCP)

$$\mathbf{UCP = UUCP \times TCF \times EF = 198 \times 1.015 \times 0.755 \approx 151.73\ \text{UCP}}$$

---

## 7. Ước lượng Nỗ lực và Chi phí Dự án

### 7.1 Xác định Năng suất Lập trình (Productivity Factor - PF)
Dựa trên số yếu tố môi trường bất lợi ($E_1$ đến $E_6 < 3$, và $E_7, E_8 > 3$):
- Số yếu tố bất lợi = 0.
- Theo quy tắc Karner: Chọn năng suất chuẩn **$PF = 20\ \text{giờ công/UCP}$**.

### 7.2 Tổng Nỗ lực Thực hiện (Effort)
$$\text{Effort} = UCP \times PF = 151.73 \times 20 \approx \mathbf{3,035\ \text{giờ công (Person-Hours)}}$$

### 7.3 Phân bổ Thời gian theo 4 Pha của Tiến trình EUP:

| Pha (Phase) | Tỷ lệ nỗ lực (%) | Giờ công (Hours) | Số tháng dự kiến (Nhóm 6 người) | Deliverables chính |
|-------------|-------------------|------------------|----------------------------------|-------------------|
| **Khởi tạo (Inception)** | 10% | 303.5 | 0.5 tháng | System Request, BFD, UC Diagram tổng quan |
| **Tinh chỉnh (Elaboration)**| 35% | 1,062.2 | 1.8 tháng | UC Specs, Domain Model, Sequence, Class, DB Design |
| **Xây dựng (Construction)** | 45% | 1,365.7 | 2.3 tháng | Lập trình Spring Boot, Web UI, Unit Test |
| **Chuyển giao (Transition)**| 10% | 303.5 | 0.5 tháng | Kiểm thử chấp nhận (UAT), Đóng gói Docker, HDSD |
| **Tổng cộng** | **100%** | **3,035 giờ** | **~5.1 tháng** | **Hệ thống hoàn chỉnh sẵn sàng bàn giao** |

---

## Kết luận Đánh giá
Dự án có quy mô trung bình lớn (151.73 UCP $\approx$ 3,035 giờ công), hoàn toàn khả thi để nhóm sinh viên 6 thành viên hoàn thành trong thời gian 5 - 6 tháng học kỳ với cam kết nỗ lực 20-25 giờ/tuần/người.
