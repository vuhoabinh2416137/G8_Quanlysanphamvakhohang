# 16 - Ước lượng Chi phí Dự án theo Phương pháp Use Case Points (UCP)

## Giới thiệu Phương pháp luận

Theo giáo trình **IT3120 - Ước lượng Chi phí Thực hiện Dự án theo UCP (Use Case Points)** của Đại học Bách Khoa Hà Nội (phát triển từ phương pháp của Gustav Karner - 1993):
Phương pháp UCP là kỹ thuật đo lường kích thước phần mềm dựa trên các ca sử dụng (Use Cases), tính toán độ phức tạp kỹ thuật và năng lực môi trường của đội ngũ triển khai để dự báo:
1. Tổng điểm ca sử dụng (UCP).
2. Tổng nỗ lực thực hiện tính theo giờ công (Person-Hours).
3. Thời gian phát triển và chi phí ngân sách dự kiến.

---

## 1. Tính toán Trọng số Tác nhân Chưa hiệu chỉnh (UAW - Unadjusted Actor Weight)

Phân loại tác nhân theo mức độ phức tạp giao tiếp với hệ thống:

| Tác nhân | Phân loại | Định nghĩa | Trọng số ($W$) | Số lượng | Thành tiền ($W \times Q$) |
|----------|-----------|------------|----------------|----------|---------------------------|
| Hệ thống thanh toán (Payment API) | Simple | Hệ thống ngoài qua API chuẩn | 1 | 1 | 1 |
| Dịch vụ Email (SMTP Gateway) | Simple | Hệ thống ngoài qua giao thức mạng | 1 | 1 | 1 |
| Quản trị viên (Admin) | Complex | Người dùng thao tác qua GUI Web | 3 | 1 | 3 |
| Quản lý kho (Warehouse Manager) | Complex | Người dùng thao tác qua GUI Web | 3 | 1 | 3 |
| Nhân viên bán hàng (Sales Staff) | Complex | Người dùng thao tác qua GUI Web | 3 | 1 | 3 |
| Nhân viên mua hàng (Purchasing Staff)| Complex | Người dùng thao tác qua GUI Web | 3 | 1 | 3 |
| Nhân viên kho (Warehouse Staff) | Complex | Người dùng thao tác qua Web/PDA | 3 | 1 | 3 |

$$\mathbf{UAW = 2 \times 1 + 5 \times 3 = 2 + 15 = 17}$$

---

## 2. Tính toán Trọng số Ca sử dụng Chưa hiệu chỉnh (UUCW - Unadjusted Use Case Weight)

Phân loại ca sử dụng theo số lượng giao dịch nghiệp vụ (Transactions):
- **Simple (Đơn giản)**: 1 - 3 transactions (Trọng số = 5)
- **Average (Trung bình)**: 4 - 7 transactions (Trọng số = 10)
- **Complex (Phức tạp)**: > 7 transactions (Trọng số = 15)

### Bảng phân loại 22 Ca sử dụng của Hệ thống:

| Mã UC | Tên Ca sử dụng | Số giao dịch ước tính | Phân loại | Trọng số |
|-------|----------------|-----------------------|-----------|----------|
| UC01 | Đăng nhập / Đăng xuất | 2 | Simple | 5 |
| UC02 | Phân quyền người dùng (RBAC) | 5 | Average | 10 |
| UC03 | Quản lý sản phẩm (CRUD) | 6 | Average | 10 |
| UC04 | Quản lý danh mục sản phẩm | 3 | Simple | 5 |
| UC05 | Tìm kiếm & tra cứu sản phẩm | 2 | Simple | 5 |
| UC06 | Tạo phiếu nhập kho | 10 | Complex | 15 |
| UC07 | Tạo phiếu xuất kho | 9 | Complex | 15 |
| UC08 | Chuyển kho nội bộ | 6 | Average | 10 |
| UC09 | Kiểm kê kho & cân đối | 11 | Complex | 15 |
| UC10 | Tra cứu tồn kho tức thời | 4 | Average | 10 |
| UC11 | Cảnh báo tồn kho dưới ngưỡng | 2 | Simple | 5 |
| UC12 | Quản lý nhà cung cấp | 5 | Average | 10 |
| UC13 | Tạo đơn mua hàng (PO) | 9 | Complex | 15 |
| UC14 | Duyệt / từ chối đơn mua hàng | 4 | Average | 10 |
| UC15 | Tiếp nhận hàng từ NCC | 8 | Complex | 15 |
| UC16 | Quản lý khách hàng | 5 | Average | 10 |
| UC17 | Tạo đơn bán hàng (SO & POS) | 11 | Complex | 15 |
| UC18 | Xử lý giao hàng & bàn giao | 5 | Average | 10 |
| UC19 | Quản lý hồ sơ nhân viên | 5 | Average | 10 |
| UC20 | Xem báo cáo tồn kho & biến động | 6 | Average | 10 |
| UC21 | Xem báo cáo doanh thu bán hàng | 6 | Average | 10 |
| UC22 | Xem báo cáo mua hàng & công nợ | 5 | Average | 10 |

### Tổng hợp UUCW:
- **Số ca sử dụng Simple**: 4 ca (UC01, UC04, UC05, UC11) $\rightarrow 4 \times 5 = 20$
- **Số ca sử dụng Average**: 12 ca (UC02, UC03, UC08, UC10, UC12, UC14, UC16, UC18, UC19, UC20, UC21, UC22) $\rightarrow 12 \times 10 = 120$
- **Số ca sử dụng Complex**: 6 ca (UC06, UC07, UC09, UC13, UC15, UC17) $\rightarrow 6 \times 15 = 90$

$$\mathbf{UUCW = 20 + 120 + 90 = 230}$$

---

## 3. Điểm Ca sử dụng Chưa hiệu chỉnh (UUCP)

$$\mathbf{UUCP = UAW + UUCW = 17 + 230 = 247}$$

---

## 4. Hệ số Phức tạp Kỹ thuật (TCF - Technical Complexity Factor)

Gồm 13 yếu tố kỹ thuật chuẩn ($T_1$ đến $T_{13}$):
$$TCF = 0.6 + \left(0.01 \times \sum_{i=1}^{13} (W_i \times C_i)\right)$$

| Mã | Yếu tố kỹ thuật | Trọng số ($W_i$) | Điểm gán ($C_i$: 0-5) | $W_i \times C_i$ | Đánh giá thực tế trong dự án |
|----|-----------------|-------------------|------------------------|------------------|------------------------------|
| T1 | Hệ thống phân tán | 2.0 | 3 | 6.0 | Hệ thống 3 tầng Web Client-Server-DB |
| T2 | Mục tiêu hiệu năng | 1.0 | 4 | 4.0 | Yêu cầu đáp ứng `< 3s`, chịu tải 50 concurrent users |
| T3 | Hiệu quả cho người dùng cuối | 1.0 | 4 | 4.0 | Giao diện thân thiện, hỗ trợ quét mã vạch |
| T4 | Xử lý nội bộ phức tạp | 1.0 | 4 | 4.0 | Thuật toán cân đối kiểm kê, tính thuế & chiết khấu |
| T5 | Tính tái sử dụng mã nguồn | 1.0 | 3 | 3.0 | Áp dụng Generic DAM, Factory, Strategy pattern |
| T6 | Dễ cài đặt | 0.5 | 3 | 1.5 | Đóng gói Docker / file JAR tiêu chuẩn |
| T7 | Dễ sử dụng | 0.5 | 4 | 2.0 | Tối ưu hóa phím tắt, tìm kiếm thông minh |
| T8 | Khả năng chuyển đổi môi trường | 2.0 | 3 | 6.0 | Chạy trên nền tảng Web tiêu chuẩn |
| T9 | Dễ thay đổi / bảo trì | 1.0 | 4 | 4.0 | Thiết kế theo nguyên lý SOLID & Clean Architecture |
| T10| Tính đồng thời cao | 1.0 | 4 | 4.0 | Nhiều thủ kho nhập/xuất đồng thời, khóa mức dòng |
| T11| Tính năng an toàn đặc biệt | 1.0 | 3 | 3.0 | Phân quyền RBAC, mã hóa mật khẩu, JWT, Audit log |
| T12| Truy cập trực tiếp từ bên thứ 3 | 1.0 | 3 | 3.0 | Tích hợp cổng thanh toán VNPay và Email SMTP |
| T13| Đào tạo người dùng đặc biệt | 1.0 | 2 | 2.0 | Nghiệp vụ chuẩn kho, có tài liệu hướng dẫn |
| **Tổng** | | | | **42.5** | |

$$TCF = 0.6 + (0.01 \times 42.5) = 0.6 + 0.425 = \mathbf{1.025}$$

---

## 5. Hệ số Môi trường (EF - Environmental Factor)

Gồm 8 yếu tố môi trường ($E_1$ đến $E_8$) đánh giá năng lực đội ngũ:
$$EF = 1.4 + \left(-0.03 \times \sum_{i=1}^{8} (W_i \times E_i)\right)$$

| Mã | Yếu tố môi trường | Trọng số ($W_i$) | Điểm gán ($E_i$: 0-5) | $W_i \times E_i$ | Nhận xét đội ngũ |
|----|-------------------|-------------------|------------------------|------------------|-------------------|
| E1 | Quen thuộc với quy trình EUP/RUP | 1.5 | 4 | 6.0 | Đã học và thực hành bài bản trong môn IT3120 |
| E2 | Kinh nghiệm ứng dụng thực tế | 0.5 | 3 | 1.5 | Đã làm qua các đồ án môn học Web/Java |
| E3 | Kinh nghiệm hướng đối tượng (OOD)| 1.0 | 4 | 4.0 | Nắm vững SOLID, Design Patterns, UML 2.5 |
| E4 | Năng lực của Trưởng nhóm kiến trúc| 0.5 | 4 | 2.0 | Thiết kế kiến trúc phân tầng, phân chia nhiệm vụ tốt |
| E5 | Động lực và tinh thần làm việc | 1.0 | 4 | 4.0 | Tinh thần trách nhiệm cao đối với bài tập lớn |
| E6 | Độ ổn định của các yêu cầu | 2.0 | 4 | 8.0 | Phạm vi nghiệp vụ rõ ràng, không thay đổi |
| E7 | Tỷ lệ nhân sự bán thời gian | -1.0 | 2 | -2.0 | Sinh viên vừa học vừa làm đồ án |
| E8 | Độ khó của ngôn ngữ lập trình | -1.0 | 2 | -2.0 | Dùng Java/TypeScript phổ biến, thư viện phong phú |
| **Tổng** | | | | **21.5** | |

$$EF = 1.4 + (-0.03 \times 21.5) = 1.4 - 0.645 = \mathbf{0.755}$$

---

## 6. Tính toán Điểm Ca sử dụng Cuối cùng (UCP)

$$\mathbf{UCP = UUCP \times TCF \times EF = 247 \times 1.025 \times 0.755 \approx 191.15 \text{ UCP}}$$

---

## 7. Ước lượng Nỗ lực và Chi phí Triển khai (Effort & Budget)

### 7.1. Định mức giờ công (Person-Hours Ratio - PHM)
Theo phương pháp Karner và giáo trình IT3120:
- Với đội ngũ có năng lực tốt ($EF < 1.0$): Áp dụng định mức chuẩn **$PHM = 20 \text{ giờ/UCP}$**.

### 7.2. Tổng nỗ lực thực hiện (Total Effort)
$$\mathbf{Effort = UCP \times PHM = 191.15 \times 20 \approx 3,823 \text{ giờ công (Person-Hours)}}$$

Quy đổi ra **Người-Tháng (Person-Months - PM)** (quy ước 1 tháng làm việc = 22 ngày $\times$ 8 giờ = 176 giờ):
$$\text{Person-Months} = \frac{3,823}{176} \approx \mathbf{21.7 \text{ Người-Tháng}}$$

### 7.3. Kế hoạch nhân sự và Thời gian hoàn thành
- **Quy mô đội dự án**: 4 lập trình viên & kỹ sư phân tích toàn thời gian (Full-time).
- **Thời gian triển khai dự kiến**:
  $$\text{Thời gian (tháng)} = \frac{21.7}{4} \approx \mathbf{5.4 \text{ tháng}} \approx 22 \text{ tuần}$$
  *(Hoàn toàn phù hợp với ràng buộc thời gian 6 tháng đề ra trong System Request).*

### 7.4. Ước lượng Chi phí Nhân công
- Giả định mức chi phí nhân công bình quân: 25,000,000 VNĐ / Người-Tháng.
- **Tổng ngân sách nhân công dự kiến**:
  $$\text{Tổng chi phí} = 21.7 \times 25,000,000 = \mathbf{542,500,000 \text{ VNĐ}}$$
- Thêm 10% chi phí dự phòng rủi ro: **~ 596,750,000 VNĐ**.
