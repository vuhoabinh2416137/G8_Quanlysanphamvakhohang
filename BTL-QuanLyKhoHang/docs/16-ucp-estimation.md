# 16 - Ước lượng Chi phí & Quy mô Dự án theo Use Case Points (07 Ca sử dụng Cốt lõi)

## Giới thiệu Phương pháp luận

Theo giáo trình **IT3120 - Ước lượng Chi phí Thực hiện Dự án theo UCP (Use Case Points)** của Viện CNTT&TT - Đại học Bách Khoa Hà Nội (phát triển từ phương pháp của Gustav Karner - 1993):
- Hệ thống chuẩn hóa theo quy định của Giảng viên hướng dẫn: **Không tính ca sử dụng Đăng nhập/Đăng xuất**; giới hạn đúng **07 Ca sử dụng nghiệp vụ cốt lõi** tương ứng với **07 thành viên trong nhóm dự án** (1 thành viên = 1 UC trọn gói).
- Hệ thống tập trung cốt lõi vào **Quản lý Kho hàng và Vật tư Nội bộ Tổ chức** (hoàn toàn không có nghiệp vụ mua bán thương mại).

---

## 1. Tính toán Trọng số Tác nhân Chưa hiệu chỉnh (UAW - Unadjusted Actor Weight)

| Tác nhân | Phân loại | Định nghĩa | Trọng số ($W$) | Số lượng | Thành tiền ($W \times Q$) |
|:---|:---:|:---|:---:|:---:|:---:|
| **Quản trị viên (Admin)** | Complex | Thao tác qua GUI Web quản trị người dùng, phân quyền RBAC | 3 | 1 | 3 |
| **Quản lý kho (Warehouse Manager)** | Complex | Thao tác qua GUI Web thẩm định duyệt cấp phát, chuyển kho, kiểm kê | 3 | 1 | 3 |
| **Đại diện Phòng ban (Department Staff)**| Complex | Thao tác qua GUI Web lập yêu cầu cấp phát, ký nhận | 3 | 1 | 3 |
| **Nhân viên kho (Warehouse Staff)** | Complex | Thao tác qua Web / PDA quét mã nhập/xuất/kiểm đếm | 3 | 1 | 3 |
| **Dịch vụ Email (SMTP Gateway)** | Simple | Hệ thống ngoài nhận thông báo tự động (API / SMTP) | 1 | 1 | 1 |

$$\mathbf{UAW = 4 \times 3 + 1 \times 1 = 12 + 1 = 13}$$

---

## 2. Tính toán Trọng số Ca sử dụng Chưa hiệu chỉnh (UUCW - Unadjusted Use Case Weight)

Phân loại 07 Ca sử dụng nghiệp vụ cốt lõi theo số lượng giao dịch nghiệp vụ (Transactions):
- **Average (Trung bình)**: 4 – 7 transactions (Trọng số = 10)
- **Complex (Phức tạp)**: > 7 transactions (Trọng số = 15)

| Mã UC | Tên Ca sử dụng Cốt lõi | Tác nhân chính | Số giao dịch | Phân loại | Trọng số UUCW | Thành viên phụ trách |
|:---:|:---|:---|:---:|:---:|:---:|:---|
| **UC01** | Quản trị Người dùng & Phân quyền RBAC | Admin | 6 | Average | 10 | **Vũ Hòa Bình** |
| **UC02** | Quản lý Danh mục & Hồ sơ Vật tư | Quản lý kho | 8 | Complex | 15 | **Nguyễn Trung Ngân** |
| **UC03** | Lập & Theo dõi Yêu cầu Cấp phát | Đại diện Phòng ban | 9 | Complex | 15 | **Lý Công Hiếu** |
| **UC04** | Thẩm định & Phê duyệt Yêu cầu Cấp phát | Quản lý kho | 6 | Average | 10 | **Phạm Duy Hiếu** |
| **UC05** | Quản lý Nhập kho & Điều chuyển Vật tư | Thủ kho / NV Kho | 10 | Complex | 15 | **Hoàng Trọng Đức Anh** |
| **UC06** | Quản lý Xuất kho & Bàn giao Cấp phát | Thủ kho / NV Kho | 10 | Complex | 15 | **Đỗ Duy Đức** |
| **UC07** | Kiểm kê Kho hàng & Báo cáo Thống kê | Quản lý kho | 12 | Complex | 15 | **Thành viên 7** |

### Tổng hợp UUCW:
- **Số ca sử dụng Average**: 2 ca (UC01, UC04) $\rightarrow 2 \times 10 = 20\ \text{điểm}$
- **Số ca sử dụng Complex**: 5 ca (UC02, UC03, UC05, UC06, UC07) $\rightarrow 5 \times 15 = 75\ \text{điểm}$

$$\mathbf{UUCW = 20 + 75 = 95\ \text{điểm}}$$

---

## 3. Điểm Ca sử dụng Chưa hiệu chỉnh (UUCP)

$$\mathbf{UUCP = UAW + UUCW = 13 + 95 = 108\ \text{điểm}}$$

---

## 4. Hệ số Phức tạp Kỹ thuật (TCF - Technical Complexity Factor)

Gồm 13 yếu tố kỹ thuật chuẩn ($T_1$ đến $T_{13}$):
$$TCF = 0.6 + \left(0.01 \times \sum_{i=1}^{13} (W_i \times C_i)\right)$$

| Mã | Yếu tố kỹ thuật | Trọng số ($W_i$) | Điểm gán ($C_i$: 0-5) | $W_i \times C_i$ | Đánh giá thực tế trong dự án |
|:---|:---|:---:|:---:|:---:|:---|
| T1 | Hệ thống phân tán | 2.0 | 3 | 6.0 | Hệ thống 3 tầng Web Client-Server-DB |
| T2 | Mục tiêu hiệu năng | 1.0 | 4 | 4.0 | Thời gian đáp ứng `< 2s`, tải 50 concurrent users |
| T3 | Hiệu quả cho người dùng cuối | 1.0 | 4 | 4.0 | Giao diện thân thiện, hỗ trợ quét mã vạch |
| T4 | Xử lý nội bộ phức tạp | 1.0 | 4 | 4.0 | Cân đối kiểm kê, kiểm tra định mức phòng ban |
| T5 | Tính tái sử dụng mã nguồn | 1.0 | 3 | 3.0 | Generic DAO, Factory, Service pattern |
| T6 | Dễ cài đặt | 0.5 | 3 | 1.5 | Đóng gói Docker Compose / JAR tiêu chuẩn |
| T7 | Dễ sử dụng | 0.5 | 4 | 2.0 | Tối ưu hóa luồng thao tác xuất/nhập kho |
| T8 | Khả năng chuyển đổi môi trường | 2.0 | 3 | 6.0 | Chạy độc lập trên nền tảng Web tiêu chuẩn |
| T9 | Dễ thay đổi / bảo trì | 1.0 | 4 | 4.0 | Kiến trúc phân tầng Clean Architecture |
| T10| Tính đồng thời cao | 1.0 | 4 | 4.0 | Giao dịch kho đồng thời, khóa mức dòng (Pessimistic/Optimistic Locking) |
| T11| Tính năng an toàn đặc biệt | 1.0 | 3 | 3.0 | Phân quyền RBAC, mã hóa bcrypt, JWT, Audit Log |
| T12| Truy cập trực tiếp bên thứ 3 | 1.0 | 2 | 2.0 | Tích hợp dịch vụ gửi Email thông báo (SMTP Gateway) |
| T13| Đào tạo người dùng đặc biệt | 1.0 | 2 | 2.0 | Quy trình chuẩn kho nội bộ, có HDSD chi tiết |
| **Tổng** | | | | **41.5** | |

$$TCF = 0.6 + (0.01 \times 41.5) = 0.6 + 0.415 = \mathbf{1.015}$$

---

## 5. Hệ số Môi trường (EF - Environmental Complexity Factor)

Gồm 8 yếu tố môi trường năng lực đội ngũ ($E_1$ đến $E_8$):
$$EF = 1.4 + \left(-0.03 \times \sum_{i=1}^{8} (W_i \times E_i)\right)$$

| Mã | Yếu tố môi trường | Trọng số ($W_i$) | Điểm gán ($E_i$: 0-5) | $W_i \times E_i$ | Đánh giá năng lực nhóm sinh viên |
|:---|:---|:---:|:---:|:---:|:---|
| E1 | Quen thuộc với quy trình RUP/EUP | 1.5 | 4 | 6.0 | Đã nắm vững lý thuyết và bài tập IT3120 |
| E2 | Kinh nghiệm ứng dụng nghiệp vụ | 0.5 | 3 | 1.5 | Hiểu rõ nghiệp vụ kho vật tư nội bộ |
| E3 | Kinh nghiệm hướng đối tượng (OOP)| 1.0 | 4 | 4.0 | Thành thạo Java OOP và chuẩn UML 2.5 |
| E4 | Khả năng lãnh đạo nhóm | 0.5 | 4 | 2.0 | Nhóm trưởng điều phối tốt, phân chia 1:1 rõ ràng |
| E5 | Động lực làm việc | 1.0 | 4 | 4.0 | Tinh thần trách nhiệm cao, hướng tới điểm A/A+ |
| E6 | Độ ổn định yêu cầu | 2.0 | 3 | 6.0 | Phạm vi dự án được chốt chặt chẽ từ System Request |
| E7 | Nhân sự bán thời gian | -1.0 | 2 | -2.0 | Sinh viên học song song các môn khác trong kỳ |
| E8 | Độ khó ngôn ngữ lập trình | -1.0 | 0 | 0.0 | Dùng Java/Spring Boot phổ biến, tài liệu phong phú |
| **Tổng** | | | | **21.5** | |

$$EF = 1.4 + (-0.03 \times 21.5) = 1.4 - 0.645 = \mathbf{0.755}$$

---

## 6. Tính toán Điểm Ca sử dụng Đã hiệu chỉnh (UCP)

$$\mathbf{UCP = UUCP \times TCF \times EF = 108 \times 1.015 \times 0.755 \approx 82.76\ \text{UCP}}$$

---

## 7. Ước lượng Nỗ lực & Thời gian Triển khai (Quy mô Nhóm 7 Thành viên)

### 7.1 Xác định Năng suất Lập trình (Productivity Factor - PF)
- Chọn chuẩn Karner: **$PF = 20\ \text{giờ công / UCP}$**.

### 7.2 Tổng Nỗ lực Thực hiện (Effort)
$$\text{Effort} = UCP \times PF = 82.76 \times 20 \approx \mathbf{1,655\ \text{giờ công (Person-Hours)}}$$

$$\text{Trung bình mỗi thành viên} = \frac{1,655\ \text{giờ}}{7\ \text{người}} \approx \mathbf{236.4\ \text{giờ / người}}$$

### 7.3 Phân bổ Thời gian theo 4 Pha EUP (Học kỳ 15 Tuần):

| Pha phát triển (Phase) | Tỷ lệ (%) | Giờ công tổng | Giờ / người (7 TV) | Tiến độ (15 tuần) | Deliverables chính |
|:---|:---:|:---:|:---:|:---:|:---|
| **1. Khởi tạo (Inception)** | 10% | 165.5h | ~23.6h / người | Tuần 1 – Tuần 2 | System Request, BFD, Bảng UCP, UC Diagram tổng quan |
| **2. Tinh chỉnh (Elaboration)** | 35% | 579.3h | ~82.8h / người | Tuần 3 – Tuần 6 | Đặc tả 07 UC Specs, Domain Model, Sequence, DCD, DB 3NF |
| **3. Xây dựng (Construction)** | 45% | 744.8h | ~106.4h / người | Tuần 7 – Tuần 13 | Lập trình Prototype Spring Boot, UI Web, Unit Tests |
| **4. Chuyển giao (Transition)** | 10% | 165.5h | ~23.6h / người | Tuần 14 – Tuần 15 | Kiểm thử UAT, Đóng gói Docker, Slide bảo vệ, Hồ sơ nộp |
| **TỔNG CỘNG** | **100%** | **1,655 giờ** | **~236.4 giờ / người** | **15 tuần (1 Học kỳ)** | **Hệ thống hoàn chỉnh sẵn sàng bảo vệ hội đồng** |

> **Đánh giá tải làm việc**: Mỗi thành viên dành trung bình **$\approx 15.8$ giờ/tuần** trong suốt 15 tuần học kỳ. Đây là mức nỗ lực **hoàn hảo và cực kỳ thực tế** đối với học phần Bài tập lớn 3 tín chỉ tại ĐHBK Hà Nội.

---

## 8. Ước lượng Quy mô Dòng mã Phần mềm (Source Lines of Code - SLOC)

$$\text{Tổng quy mô SLOC dự kiến} = 82.76 \times 122 \approx \mathbf{10,100\ \text{SLOC}}$$

| Tầng kiến trúc | Công nghệ sử dụng | Mức SLOC ước lượng | Tỷ lệ (%) |
|:---|:---|:---:|:---:|
| **Backend Service & API** | Java 17, Spring Boot 3, JPA/Hibernate, Spring Security | ~5,800 SLOC | 57.4% |
| **Frontend Web** | HTML5, Vanilla CSS, JavaScript ES6, Chart.js | ~3,300 SLOC | 32.7% |
| **Database Scripts** | ANSI SQL (PostgreSQL / MySQL Schema, Migrations, Seed) | ~1,000 SLOC | 9.9% |
| **Tổng cộng toàn dự án** | **Fullstack Enterprise Web Application** | **~10,100 SLOC** | **100%** |

---

## 9. Đánh giá Cân bằng Khối lượng 7 Ca sử dụng cho 7 Thành viên

| STT | Thành viên | Ca sử dụng phụ trách chính (Owner) | Phân loại | Điểm UUCW | Tỷ lệ nỗ lực (%) |
|:---:|:---|:---|:---:|:---:|:---:|
| **01** | **Vũ Hòa Bình** | **UC01**: Quản trị Người dùng & Phân quyền RBAC | Average | **10 điểm** | 10.5% |
| **02** | **Lý Công Hiếu** | **UC03**: Lập & Theo dõi Yêu cầu Cấp phát Vật tư | Complex | **15 điểm** | 15.8% |
| **03** | **Phạm Duy Hiếu** | **UC04**: Thẩm định & Phê duyệt Yêu cầu Cấp phát | Average | **10 điểm** | 10.5% |
| **04** | **Nguyễn Trung Ngân** | **UC02**: Quản lý Danh mục & Hồ sơ Vật tư, Thiết bị | Complex | **15 điểm** | 15.8% |
| **05** | **Hoàng Trọng Đức Anh**| **UC05**: Quản lý Nhập kho & Điều chuyển Vật tư | Complex | **15 điểm** | 15.8% |
| **06** | **Đỗ Duy Đức** | **UC06**: Quản lý Xuất kho & Bàn giao Cấp phát | Complex | **15 điểm** | 15.8% |
| **07** | **Thành viên 7** | **UC07**: Kiểm kê Kho hàng & Báo cáo Thống kê | Complex | **15 điểm** | 15.8% |
| **Tổng** | **07 Thành viên** | **07 Ca sử dụng cốt lõi (UC01 – UC07)** | **2 Average, 5 Complex** | **95 điểm** | **100%** |

---

## 10. Kết luận Đánh giá Quy mô Dự án
1. **Phù hợp chuẩn mực đồ án**: Mô hình 7 Ca sử dụng cốt lõi giúp loại bỏ các chức năng vụn vặt dạng CRUD đơn giản, gom thành các tiến trình nghiệp vụ hoàn chỉnh mang lại giá trị trọn vẹn cho tác nhân.
2. **Cân bằng tuyệt đối**: Đúng 7 thành viên phụ trách 7 ca sử dụng (tỷ lệ 1:1), điểm số chênh lệch chỉ từ 10 - 15 điểm UUCW, tạo điều kiện thuận lợi nhất để Giảng viên đánh giá công bằng điểm số cá nhân khi chấm đồ án.
