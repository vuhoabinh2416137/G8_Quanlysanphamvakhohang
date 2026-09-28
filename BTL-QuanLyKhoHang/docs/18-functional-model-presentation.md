# Kịch Bản & Bản Trình Bày Thuyết Trình: Mô Hình Chức Năng Hệ Thống

> **Học phần**: IT3120 – Phân tích và Thiết kế Hệ thống Thông tin  
> **Đại học Bách Khoa Hà Nội (HUST)** — Nhóm G8  
> **Đề tài**: Hệ thống Quản lý Sản phẩm và Kho hàng  
> **Tài liệu tham chiếu gốc**: [17-functional-model.md](./17-functional-model.md)  
> **Hình ảnh sơ đồ minh họa**: Thư mục `../diagrams/`

---

## 📌 Hướng dẫn dành cho người thuyết trình

- **Thời lượng khuyến nghị**: 5 – 7 phút trình bày chính + 3 phút hỏi đáp phản biện.
- **Phong thái trình bày**: Đi từ **Tổng quan bức tranh lớn (Top-down)** $\rightarrow$ **Cụ thể từng phân hệ** $\rightarrow$ **Liên kết luồng nghiệp vụ** $\rightarrow$ **Quy tắc ràng buộc & Cân bằng mô hình**.
- **Tài liệu kèm theo khi chiếu**: Mở sẵn 7 ảnh sơ đồ trong thư mục `diagrams/` (`functional-model-bfd.png`, `functional-model-uc-relations.png`, `functional-model-rbac-matrix.png`, `functional-model-flow-mua-nhap.png`, `functional-model-flow-xuat-canh-bao.png`, `functional-model-flow-kiem-ke.png`, `functional-model-state-machines.png`).

---

## PHẦN 1: MỞ ĐẦU & TỔNG QUAN HỆ THỐNG (1 phút)

### 🗣️ Lời trình bày mẫu:
> *"Kính thưa thầy, hôm nay em xin đại diện nhóm G8 trình bày về **Mô hình chức năng** của dự án 'Hệ thống Quản lý Sản phẩm và Kho hàng'.*
>
> *Trong công đoạn phân tích hệ thống theo tiến trình EUP, mô hình chức năng đóng vai trò trả lời cho câu hỏi: **Hệ thống làm gì (WHAT)?** nhằm đáp ứng toàn bộ các yêu cầu nghiệp vụ của doanh nghiệp.*
>
> *Về phạm vi: Hệ thống tập trung chuyên sâu vào chu trình chuỗi cung ứng nội bộ gồm: Mua hàng, Quản lý kho, Sản phẩm, Tồn kho và Kiểm kê. Hệ thống không ôm đồm nghiệp vụ bán hàng thương mại nhằm đảm bảo tính chuyên biệt và độc lập dữ liệu.*
>
> *Mô hình chức năng của chúng em được chuẩn hóa gồm **6 phân hệ lớn**, bao phủ **18 Ca sử dụng (Use Cases)**, chi tiết hóa thành **~85 chức năng nguyên thủy mức lá**, phục vụ **4 nhóm tác nhân con người** và tích hợp **1 hệ thống gửi Email tự động**."*

### 📊 Con số cốt lõi cần nhớ:
- **6** nhóm chức năng lớn (F1 $\rightarrow$ F6)
- **18** Ca sử dụng (UC01 $\rightarrow$ UC18)
- **~85** Chức năng nguyên thủy (Leaf Functions)
- **4** Tác nhân con người: Admin, Quản lý kho, NV mua hàng, NV kho
- **1** Tác nhân hệ thống: Hệ thống Email tự động
- **41** Quy tắc nghiệp vụ (BR01 $\rightarrow$ BR41)
- **17** Thực thể dữ liệu quản lý

---

## PHẦN 2: CẤU TRÚC PHÂN RÃ CHỨC NĂNG (BFD) (2.5 phút)

*(Chiếu sơ đồ: `diagrams/functional-model-bfd.png`)*

### 🗣️ Lời trình bày mẫu:
> *"Để quản lý toàn diện bài toán kho, nhóm em sử dụng sơ đồ phân rã chức năng BFD chia hệ thống thành 6 phân hệ độc lập nhưng liên kết chặt chẽ:"*

### 1. Phân hệ F1: Quản lý Xác thực & Phân quyền (Security & Access Control)
- **Bao gồm 2 Use Case**:
  - `UC01: Đăng nhập / Đăng xuất`: Xác thực an toàn (mã hóa bcrypt, chống brute-force khóa sau 5 lần sai, timeout sau 30 phút).
  - `UC02: Phân quyền người dùng`: Quản trị vai trò (Role-Based Access Control - RBAC) và phân bổ quyền hạn chi tiết tới từng chức năng.

### 2. Phân hệ F2: Quản lý Sản phẩm (Product Management)
- **Bao gồm 3 Use Case**:
  - `UC03: Quản lý sản phẩm`: Thêm, sửa thông tin, cấu hình đơn vị tính, ngưỡng tồn an toàn tối thiểu. Áp dụng quy tắc *Soft Delete* (chuyển trạng thái Ngừng kinh doanh, không xóa vật lý để giữ lịch sử chứng từ).
  - `UC04: Quản lý danh mục sản phẩm`: Tổ chức danh mục đa cấp hình cây (cha - con), chống vòng lặp đệ quy.
  - `UC05: Tìm kiếm & Lọc sản phẩm`: Tra cứu nhanh theo mã SKU, tên, danh mục, trạng thái.

### 3. Phân hệ F3: Quản lý Kho hàng (Warehouse Core Operations) — *Trọng tâm hệ thống*
- **Bao gồm 6 Use Case**:
  - `UC06: Nhập kho`: Tạo phiếu nhập từ đơn mua đã duyệt, kiểm đếm số lượng, cập nhật tồn kho tự động theo transaction ACID.
  - `UC07: Xuất kho`: Tạo phiếu xuất theo nghiệp vụ, kiểm tra ràng buộc số lượng xuất $\le$ tồn khả dụng (chống xuất âm kho).
  - `UC08: Chuyển kho`: Điều chuyển hàng giữa các chi nhánh kho nội bộ, đồng bộ xuất kho đi và nhập kho đến.
  - `UC09: Kiểm kê kho`: Tổ chức phiên kiểm đếm thực tế, khóa tạm thời giao dịch xuất nhập, ghi nhận chênh lệch và lập phiếu điều chỉnh.
  - `UC10: Xem tồn kho`: Tra cứu tồn tức thời theo từng kho, từng vị trí.
  - `UC11: Cảnh báo tồn kho thấp`: Tự động so sánh số lượng thực tế với ngưỡng tối thiểu để bắn cảnh báo và gửi email cho Quản lý kho.

### 4. Phân hệ F4: Quản lý Mua hàng (Procurement & Purchasing)
- **Bao gồm 4 Use Case**:
  - `UC12: Quản lý Nhà cung cấp`: Lưu trữ hồ sơ đối tác, thông tin liên hệ, đánh giá hợp tác.
  - `UC13: Tạo đơn mua hàng (PO)`: Nhân viên mua hàng lập đơn đặt hàng dựa trên nhu cầu bổ sung hàng hóa.
  - `UC14: Duyệt đơn mua hàng`: Quản lý kho xem xét, phê duyệt hoặc từ chối đơn mua (bắt buộc nhập lý do nếu từ chối). Khi duyệt xong tự động gửi PO điện tử qua Email cho nhà cung cấp.
  - `UC15: Nhận hàng từ Nhà cung cấp`: Tiếp nhận lô hàng thực tế, đối soát với đơn mua và kích hoạt thủ tục tạo phiếu nhập kho.

### 5. Phân hệ F5: Quản lý Nhân viên (Human Resource & User Management)
- **Bao gồm 1 Use Case**:
  - `UC16: Quản lý nhân viên`: Quản lý hồ sơ nhân sự theo từng bộ phận, kho làm việc, cấp phát tài khoản định danh.

### 6. Phân hệ F6: Báo cáo & Thống kê (Reporting & Analytics)
- **Bao gồm 2 Use Case**:
  - `UC17: Báo cáo tồn kho`: Báo cáo xuất - nhập - tồn theo kỳ, báo cáo hàng cận date/hết hạn, báo cáo giá trị tồn kho.
  - `UC18: Báo cáo mua hàng`: Thống kê sản lượng nhập, tiến độ giao hàng của từng nhà cung cấp, chi phí mua hàng theo kỳ.

---

## PHẦN 3: QUAN HỆ CA SỬ DỤNG & CÁC LUỒNG NGHIỆP VỤ LIÊN PHÂN HỆ (2 phút)

*(Chiếu sơ đồ: `diagrams/functional-model-uc-relations.png` và các sơ đồ Flow)*

### 🗣️ Lời trình bày mẫu:
> *"Thưa thầy, các ca sử dụng không đứng rời rạc mà liên kết với nhau qua các quan hệ ngữ nghĩa UML chuẩn xác và 3 luồng nghiệp vụ khép kín:"*

### 1. Quan hệ Ca sử dụng đặc thù:
- **Quan hệ `<<include>>` (Bắt buộc phải thực hiện kèm theo)**:
  - `UC15 (Nhận hàng)` $\xrightarrow{include}$ `UC06 (Nhập kho)`: Khi nhận hàng thực tế từ NCC, bắt buộc hệ thống phải sinh phiếu nhập kho để ghi nhận tài sản.
  - `UC06 (Nhập kho)` & `UC07 (Xuất kho)` $\xrightarrow{include}$ `UC10 (Xem tồn kho)`: Mọi thao tác xuất/nhập đều phải đọc dữ liệu tồn kho hiện thời.
  - `UC13 (Tạo đơn mua)` $\xrightarrow{include}$ `UC12 (Quản lý NCC)`: Lập đơn mua bắt buộc phải chọn NCC hợp lệ đã được lưu trong hệ thống.
- **Quan hệ `<<extend>>` (Kích hoạt theo điều kiện mở rộng)**:
  - `UC10 (Xem tồn kho)` $\xleftarrow{extend}$ `UC11 (Cảnh báo tồn)`: Điểm mở rộng là khi `Số lượng tồn < Ngưỡng tồn tối thiểu`, hệ thống tự động kích hoạt tiến trình cảnh báo và gửi Email.
  - `UC07 (Xuất kho)` $\xleftarrow{extend}$ `UC08 (Chuyển kho)`: Khi mục đích xuất là điều chuyển nội bộ, hệ thống sẽ mở rộng thêm quy trình tạo phiếu nhập chờ ở kho đích.

### 2. Ba luồng nghiệp vụ cốt lõi:
1. **Luồng Mua hàng $\rightarrow$ Nhập kho**: 
   `NV Mua hàng tạo đơn (PO)` $\rightarrow$ `Quản lý kho duyệt` $\rightarrow$ `Gửi email PO cho NCC` $\rightarrow$ `NCC giao hàng` $\rightarrow$ `NV kho nhận hàng & tạo phiếu nhập kho` $\rightarrow$ `Hệ thống tự động tăng tồn kho`.
2. **Luồng Xuất kho $\rightarrow$ Kiểm soát cảnh báo**: 
   `NV Kho tạo yêu cầu xuất` $\rightarrow$ `Hệ thống kiểm tra tồn kho khả dụng` $\rightarrow$ `Nếu đủ: Trừ tồn kho & ghi log` $\rightarrow$ `Nếu tồn sau xuất < ngưỡng: Bắn thông báo + gửi email cảnh báo cho Quản lý kho`.
3. **Luồng Kiểm kê & Cân bằng tồn**: 
   `Quản lý kho mở đợt kiểm kê` $\rightarrow$ `Hệ thống chốt số liệu sổ sách (Snapshot) và khóa giao dịch kho` $\rightarrow$ `NV kho đếm thực tế` $\rightarrow$ `Quản lý duyệt chênh lệch` $\rightarrow$ `Hệ thống tự động sinh phiếu điều chỉnh kho và mở khóa`.

---

## PHẦN 4: MA TRẬN PHÂN QUYỀN (RBAC) & MA TRẬN CRUD (1 phút)

*(Chiếu sơ đồ: `diagrams/functional-model-rbac-matrix.png`)*

### 🗣️ Lời trình bày mẫu:
> *"Để bảo vệ an toàn dữ liệu và phân tách trách nhiệm (Separation of Duties), nhóm xây dựng ma trận phân quyền RBAC và ma trận CRUD chặt chẽ:"*

### 1. Phân quyền theo 4 vai trò rõ rệt:
| Vai trò | Phạm vi chức năng chính | Trách nhiệm then chốt |
|:---|:---|:---|
| **Admin** | F1 (Bảo mật), F5 (Nhân viên), Cấu hình | Toàn quyền quản trị tài khoản, cấp phát quyền, không can thiệp chứng từ kho hàng ngày |
| **Quản lý kho** | F2, F3, F4 (Duyệt), F6 (Báo cáo) | Phê duyệt đơn mua, mở đợt kiểm kê, cấu hình định mức tồn, xem báo cáo tổng hợp |
| **NV Mua hàng** | F2 (Xem/Tìm), F4.1-F4.2 (Tạo đơn mua), F6.2 | Khảo sát NCC, lập đơn mua hàng, theo dõi tiến độ giao hàng |
| **NV Kho** | F2 (Xem), F3.1-F3.3 (Thực hiện xuất/nhập/chuyển), F3.4 (Nhập số đếm kiểm kê) | Trực tiếp bốc dỡ hàng, kiểm đếm thực tế, lập phiếu nhập xuất kho hàng ngày |

### 2. Điểm sáng của Ma trận CRUD (18 chức năng $\times$ 17 thực thể):
- **100% Thực thể được tạo (C) và đọc (R)**: Không có thực thể "mồ côi" không ai dùng.
- **Ràng buộc cập nhật (U)**: Tồn kho chỉ được Update qua đúng 3 chức năng: Nhập kho (tăng), Xuất kho (giảm), Duyệt kiểm kê (điều chỉnh). Người dùng không được can thiệp sửa trực tiếp số tồn trong CSDL.

---

## PHẦN 5: CÁC QUY TẮC NGHIỆP VỤ & TÍNH CÂN BẰNG MÔ HÌNH (0.5 phút)

### 🗣️ Lời trình bày mẫu:
> *"Cuối cùng, mô hình của nhóm tuân thủ 41 quy tắc nghiệp vụ khắt khe và đạt tính cân bằng mô hình chuẩn mực:"*
- **Quy tắc bảo vệ dữ liệu (BR09, BR31, BR41)**: Áp dụng triệt để *Soft Delete* đối với Sản phẩm, Nhà cung cấp, Nhân viên. Tuyệt đối không xóa vật lý khi đã có phát sinh giao dịch xuất/nhập/đơn mua trong lịch sử.
- **Quy tắc an toàn kho (BR21, BR27)**: Không cho phép xuất vượt quá tồn kho khả dụng; Khóa toàn bộ nghiệp vụ xuất/nhập của kho đang trong phiên kiểm kê để chống xung đột dữ liệu (Concurrency Control).
- **Tính cân bằng mô hình (Model Balancing)**: Đã được kiểm chứng ánh xạ $1:1$ giữa 15 Yêu cầu chức năng ban đầu (FR01–FR15) $\rightarrow$ 18 Ca sử dụng $\rightarrow$ 17 bảng Cơ sở dữ liệu và 4 Biểu đồ hoạt động chi tiết.

---

## 🎯 BỘ CÂU HỎI THẦY CÔ HAY HỎI PHẢN BIỆN & GỢI Ý TRẢ LỜI NHANH

### Câu 1: Tại sao hệ thống chia thành 6 nhóm chức năng này?
- **Trả lời**: *"Dạ thưa thầy, 6 nhóm chức năng này được phân rã theo đúng ranh giới nghiệp vụ (Business Boundary) của doanh nghiệp: F1 phụ trách an ninh hệ thống; F2 quản lý đối tượng kinh doanh (sản phẩm); F3 là nghiệp vụ vận hành lõi (kho); F4 là đầu vào hàng hóa (mua hàng); F5 là nhân lực thực thi; và F6 phục vụ ra quyết định cho ban quản lý. Việc chia tách này giúp phân hệ có độ kết dính nội tại cao (High Cohesion) và giảm độ phụ thuộc lẫn nhau (Low Coupling)."*

### Câu 2: Trong BFD, tại sao UC15 (Nhận hàng) nằm ở nhóm Mua hàng (F4) chứ không để ở Kho (F3)?
- **Trả lời**: *"Dạ thưa thầy, về mặt quy trình chuỗi cung ứng, việc 'Nhận hàng' là khâu nghiệm thu đối soát giữa Doanh nghiệp với Nhà cung cấp theo Đơn mua hàng (PO). Khi nhận hàng thành công, nó sẽ gọi quan hệ `<<include>>` tới UC06 (Nhập kho) để nhân viên kho thực hiện việc đưa hàng vào kệ. Như vậy phân tách rõ: Quản lý mua hàng phụ trách việc giao dịch với NCC, còn Quản lý kho phụ trách việc lưu kho vật lý."*

### Câu 3: Hãy giải thích sự khác biệt giữa `<<include>>` và `<<extend>>` trong sơ đồ của nhóm?
- **Trả lời**: 
  - *"`<<include>>` là mối quan hệ bắt buộc: Ví dụ khi 'Nhận hàng từ NCC' (UC15), hệ thống bắt buộc phải thực hiện 'Tạo phiếu nhập kho' (UC06), không thể bỏ qua.*
  - *"`<<extend>>` là mối quan hệ tùy chọn có điều kiện: Ví dụ khi người dùng 'Xem tồn kho' (UC10), CHỈ KHI số lượng tồn rớt xuống dưới ngưỡng an toàn thì hệ thống mới kích hoạt ca sử dụng 'Cảnh báo tồn kho thấp' (UC11) và gửi email."*

### Câu 4: Khi kiểm kê kho, làm sao hệ thống xử lý nếu có người đang muốn xuất hàng?
- **Trả lời**: *"Dạ thưa thầy, theo quy tắc nghiệp vụ BR27 và máy trạng thái kiểm kê, ngay khi Quản lý kho bấm mở phiên kiểm kê, hệ thống lập tức chốt Snapshot số liệu sổ sách và đặt cờ khóa (Lock) toàn bộ giao dịch xuất/nhập đối với kho đó. Mọi yêu cầu xuất kho sẽ bị hệ thống chặn lại và báo kho đang kiểm kê. Sau khi Quản lý kho phê duyệt biên bản kiểm kê và hệ thống cân bằng tồn kho xong thì cờ khóa mới được mở."*

### Câu 5: Tại sao hệ thống không làm chức năng Bán hàng (Sales)?
- **Trả lời**: *"Dạ thưa thầy, ngay từ tài liệu Yêu cầu hệ thống (System Request), nhóm đã định vị đây là 'Hệ thống Quản lý Sản phẩm và Kho hàng' nội bộ (WMS). Nghiệp vụ bán hàng thuộc về hệ thống POS hoặc E-commerce chuyên biệt. Hệ thống này chỉ nhận đầu vào từ mua hàng (Procurement) và xuất hàng theo các yêu cầu xuất nội bộ hoặc lệnh xuất điều chuyển. Điều này giúp bài toán đúng trọng tâm vào quản trị kho và chuỗi cung ứng vật tư."*

---

## 📋 TÓM TẮT DÀN Ý 1 TRANG (DÙNG ĐỂ NHÌN NHANH KHI ĐỨNG THUYẾT TRÌNH)

```text
[MỞ ĐẦU]
- Tên: Quản lý Sản phẩm & Kho hàng (IT3120 - G8)
- Mục tiêu: Trả lời "Hệ thống làm gì?" (WHAT)
- Quy mô: 6 nhóm F1-F6 | 18 Use Cases | ~85 chức năng lá | 4 vai trò + 1 email

[CẤU TRÚC 6 PHÂN HỆ]
- F1: Xác thực & Phân quyền (UC01 Login, UC02 RBAC)
- F2: Sản phẩm (UC03 Sản phẩm, UC04 Danh mục cây, UC05 Tìm kiếm)
- F3: Kho hàng - LÕI (UC06 Nhập, UC07 Xuất, UC08 Chuyển kho, UC09 Kiểm kê, UC10 Tồn kho, UC11 Cảnh báo)
- F4: Mua hàng (UC12 NCC, UC13 Đơn mua, UC14 Duyệt mua, UC15 Nhận hàng)
- F5: Nhân sự (UC16 Nhân viên theo kho)
- F6: Báo cáo (UC17 Báo cáo tồn, UC18 Báo cáo mua)

[LIÊN KẾT & LUỒNG CHÍNH]
- Include: Nhận hàng -> Nhập kho; Nhập/Xuất -> Xem tồn; Đơn mua -> NCC
- Extend: Xem tồn -> (tồn < ngưỡng) -> Cảnh báo email; Xuất kho -> (chuyển kho) -> Nhập đích
- 3 Luồng: (1) Mua -> Duyệt -> Nhập; (2) Xuất -> Kiểm tra tồn -> Cảnh báo; (3) Kiểm kê -> Khóa -> Cân bằng

[QUY TẮC CỐT LÕI & CÂN BẰNG]
- 41 Business Rules: Soft Delete (SP/NCC/NV), Không xuất âm, Khóa kho khi kiểm kê, ACID transaction
- CRUD: 18x17, không thực thể mồ côi, tồn kho chỉ sửa qua chứng từ
- Cân bằng: FR01-FR15 -> 18 UC -> 17 Bảng CSDL -> 4 Activity Diagrams
```
