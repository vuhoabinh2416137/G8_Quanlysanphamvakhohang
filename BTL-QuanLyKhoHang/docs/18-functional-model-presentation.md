# 18 - Kịch bản & Tài liệu Thuyết trình Bảo vệ Đồ án (Functional Model & System Defense)

> **Học phần**: IT3120 - Phân tích và Thiết kế Hệ thống Thông tin  
> **Viện Công nghệ Thông tin và Truyền thông - Đại học Bách Khoa Hà Nội (HUST)**  
> **Đề tài**: Hệ thống Quản lý Vật tư và Kho hàng Nội bộ Tổ chức  
> **Nhóm thực hiện**: Nhóm 8 (G8) — Quy mô: 07 thành viên  

---

## PHẦN 1: MỞ ĐẦU & TỔNG QUAN PHẠM VI HỆ THỐNG (1 Phút)

### 🗣️ Lời trình bày mẫu:
> *"Kính thưa các thầy cô trong Hội đồng phản biện môn IT3120. Hôm nay, Nhóm 8 xin phép được bảo vệ Đồ án Phân tích và Thiết kế: **Hệ thống Quản lý Vật tư và Kho hàng Nội bộ của Tổ chức**.*
>
> *Khác biệt cơ bản của bài toán nhóm em là: Hệ thống được xây dựng chuyên biệt cho việc quản trị vật tư, trang thiết bị, tài sản và công cụ dụng cụ nội bộ của một tổ chức / cơ quan / viện trường — **hoàn toàn tập trung vào công tác quản lý hiện vật, cấp phát theo nhu cầu phòng ban, xuất/nhập/điều chuyển kho và kiểm kê định kỳ, tuyệt đối không có các nghiệp vụ mua bán thương mại hay giao dịch tiền tệ**.*
>
> *Toàn bộ hệ thống được phân tích và thiết kế chuẩn mực theo phương pháp OOSAD (UML 2.5), phân rã thành **6 nhóm chức năng chính (F1 - F6)**, bao gồm **18 Ca sử dụng (UC01 - UC18)** và ánh xạ cân bằng 1-1 với **18 bảng CSDL quan hệ chuẩn hóa 3NF**."*

---

## PHẦN 2: CẤU TRÚC PHÂN RÃ CHỨC NĂNG (BFD) & 6 PHÂN HỆ NGHIỆP VỤ (2 Phút)

*(Chiếu sơ đồ: `diagrams/functional-model-bfd.png`)*

### 1. Sáu nhóm chức năng nghiệp vụ (F1 - F6):
1. **F1: Quản trị Hệ thống & Bảo mật (System & Security)**:
   - `UC01`: Đăng nhập, đăng xuất, đổi mật khẩu và cấp phát JWT token an toàn.
   - `UC02`: Quản lý phân quyền dựa trên vai trò (Role-Based Access Control - RBAC).
2. **F2: Quản lý Danh mục Vật tư & Thiết bị (Material Catalog)**:
   - `UC03`: Quản lý danh mục nhóm/chủng loại vật tư (Cấu trúc phân cấp).
   - `UC04`: Quản lý hồ sơ vật tư, thông số kỹ thuật, đơn vị tính, định mức tồn an toàn tối thiểu.
   - `UC05`: Tra cứu & Tìm kiếm vật tư đa tiêu chí.
3. **F3: Quản trị Kho bãi & Lưu trữ Vật lý (Storage & Warehouses)**:
   - Quản lý mạng lưới kho nội bộ và các khu vực lưu trữ, dãy kệ, tầng lưu trữ.
4. **F4: Nghiệp vụ Kho vận Nội bộ - LÕI (Core Internal Warehouse Operations)**:
   - `UC06`: Tạo & Ghi sổ Phiếu Nhập kho nội bộ (Tiếp nhận bàn giao tập trung, hoàn nhập từ phòng ban).
   - `UC07`: Tạo & Ghi sổ Phiếu Xuất kho cấp phát phòng ban theo quyết định duyệt.
   - `UC08`: Điều chuyển vật tư giữa các kho nội bộ trong cơ quan.
   - `UC09`: Cảnh báo tự động vật tư chạm ngưỡng tồn kho tối thiểu.
   - `UC10`: Lập kế hoạch & Mở phiên Kiểm kê kho định kỳ.
   - `UC11`: Xử lý chênh lệch kiểm kê & Cân bằng sổ sách kho tự động.
5. **F5: Quản lý Phòng ban & Cấp phát Nội bộ (Departments & Material Allocation)**:
   - `UC12`: Quản lý danh mục Phòng ban / Đơn vị nội bộ trong tổ chức.
   - `UC13`: Lập phiếu Yêu cầu cấp phát vật tư (phía Cán bộ / Phòng ban).
   - `UC14`: Phê duyệt yêu cầu cấp phát (phía Lãnh đạo / Người có thẩm quyền).
   - `UC15`: Bàn giao & Tiếp nhận vật tư nội bộ (Biên bản giao nhận thực tế).
6. **F6: Báo cáo Thống kê & Phân tích Tồn kho (Reporting & Analytics)**:
   - `UC16`: Báo cáo Xuất - Nhập - Tồn kho tổng hợp và chi tiết theo kỳ.
   - `UC17`: Báo cáo Kiểm kê sai lệch và lịch sử điều chỉnh kho.
   - `UC18`: Báo cáo Tình hình cấp phát vật tư theo từng Phòng ban / Đơn vị.

---

## PHẦN 3: CÁC LUỒNG NGHIỆP VỤ CỐT LÕI (CORE BUSINESS FLOWS) (2 Phút)

### 1. Luồng Cấp phát Vật tư Phòng ban (Allocation Flow):
```
[Cán bộ Phòng ban]          [Lãnh đạo Cơ quan]          [Thủ kho]
        │                            │                      │
        ├─ Tạo yêu cầu (UC13) ──────>│                      │
        │                            ├─ Xét duyệt (UC14) ──>│
        │                            │                      ├─ Lập phiếu xuất (UC07)
        │<── Bàn giao & Ký nhận (UC15) ─────────────────────┤
```

### 2. Luồng Xuất kho Cấp phát & Cảnh báo Tồn tối thiểu:
- Khi thủ kho hoàn tất phiếu xuất, Transaction Service trừ số lượng tồn khả dụng (`so_luong_ton = so_luong_ton - so_luong_xuat`).
- Hệ thống tự động kích hoạt quan hệ `<<extend>>` kiểm tra nếu `so_luong_ton <= muc_ton_toi_thieu` thì kích hoạt `UC09` gửi thông báo cảnh báo đến Quản lý kho.

### 3. Luồng Kiểm kê Kho & Khóa giao dịch:
- Quản lý kho mở đợt kiểm kê $\rightarrow$ Hệ thống chốt số liệu sổ sách (Snapshot) và khóa giao dịch kho $\rightarrow$ Nhân viên kho kiểm đếm thực tế $\rightarrow$ Quản lý duyệt chênh lệch $\rightarrow$ Hệ thống tự động sinh phiếu điều chỉnh kho và mở khóa.

---

## PHẦN 4: MA TRẬN PHÂN QUYỀN (RBAC) & MA TRẬN CRUD (1 Phút)

*(Chiếu sơ đồ: `diagrams/functional-model-rbac-matrix.png`)*

### 1. Bốn vai trò người dùng trong cơ quan:
| Vai trò | Ký hiệu Role | Phạm vi chức năng chính | Trách nhiệm then chốt |
|:---|:---|:---|:---|
| **Quản trị viên Hệ thống** | `ROLE_ADMIN` | F1 (Bảo mật), Danh mục hệ thống | Quản trị tài khoản người dùng, phân quyền, sao lưu dữ liệu |
| **Quản lý Kho / Lãnh đạo** | `ROLE_MANAGER` | F4 (Duyệt), F5 (Duyệt cấp phát), F6 | Duyệt yêu cầu cấp phát, mở đợt kiểm kê, duyệt cân bằng kho, xem báo cáo |
| **Nhân viên / Thủ kho** | `ROLE_WAREHOUSE_STAFF` | F2, F3, F4 (Xuất/Nhập/Chuyển kho, đếm kiểm kê) | Lập phiếu nhập/xuất kho, bố trí vị trí kệ, kiểm kê thực tế |
| **Cán bộ Phòng ban** | `ROLE_DEPT_STAFF` | F5 (Tạo yêu cầu cấp phát, nhận bàn giao) | Đại diện đơn vị xin cấp phát vật tư/thiết bị, ký nhận bàn giao |

### 2. Tính toàn vẹn của Ma trận CRUD (18 Ca sử dụng $\times$ 18 Bảng):
- **100% Thực thể được tạo (C) và đọc (R)**: Không có thực thể mồ côi (Dead-end Entity).
- **Ràng buộc kiểm soát cập nhật (U)**: Bảng `ton_kho` tuyệt đối không cho phép người dùng sửa trực tiếp; chỉ được cập nhật tự động thông qua giao dịch ACID của Phiếu Nhập, Phiếu Xuất, hoặc Quyết định Cân bằng Kiểm kê.

---

## PHẦN 5: CÂU HỎI THƯỜNG GẶP KHI BẢO VỆ & HƯỚNG DẪN TRẢ LỜI PHẢN BIỆN (Q&A DEFENSE)

### Câu 1: Tại sao hệ thống lại không có nghiệp vụ mua bán hàng hóa?
- **Trả lời**: *"Dạ thưa thầy cô, mục tiêu nghiên cứu và phạm vi của bài toán là giải quyết công tác **Quản lý Tài sản, Vật tư và Kho hàng nội bộ của một tổ chức/cơ quan/doanh nghiệp** (như các Viện trường, Bệnh viện, Cơ quan hành chính hoặc Doanh nghiệp sản xuất). Các đơn vị này quản lý kho phục vụ nhu cầu hoạt động chuyên môn của các phòng ban, việc mua sắm tài sản công được thực hiện qua cổng đấu thầu/mua sắm tập trung riêng biệt của Nhà nước hoặc phòng Mua sắm độc lập. Hệ thống của nhóm tập trung chuyên sâu vào: tiếp nhận vật tư bàn giao, bảo quản lưu kho, cấp phát phòng ban, điều chuyển và kiểm kê đối soát, hoàn toàn không phát sinh dòng tiền bán hàng hay giao dịch thương mại."*

### Câu 2: Làm thế nào đảm bảo tính cân bằng mô hình OOSAD (Model Balancing)?
- **Trả lời**: *"Dạ thưa thầy cô, nhóm kiểm soát tính cân bằng qua 4 trục liên kết khép kín:
  1. **Chức năng $\leftrightarrow$ Hành vi**: Từng bước trong luồng sự kiện Use Case Specs ánh xạ 1-1 với Action trong Activity Diagram và Message trong SSD.
  2. **Hành vi $\leftrightarrow$ Cấu trúc**: Mọi phương thức trao đổi trong Sequence Diagram đều tồn tại trong Design Class Diagram (DCD).
  3. **Cấu trúc $\leftrightarrow$ Lưu trữ**: 18 thực thể trong DCD ánh xạ 1-1 với 18 bảng chuẩn hóa 3NF trong CSDL.
  4. **Lưu trữ $\leftrightarrow$ Giao diện**: Mọi trường dữ liệu trên UI Wireframe đều có trường lưu trữ tương ứng trong từ điển dữ liệu."*

### Câu 3: Hãy giải thích cơ chế xử lý đồng thời (Concurrency Control) khi kiểm kê kho?
- **Trả lời**: *"Dạ thưa thầy cô, theo Quy tắc nghiệp vụ BR27 và Sơ đồ máy trạng thái, ngay khi Quản lý kho mở đợt kiểm kê, hệ thống lập tức chốt Snapshot số lượng tồn sổ sách và bật cờ `is_locked = TRUE` trên kho đó. Khi kho bị khóa, mọi giao dịch tạo phiếu xuất kho hoặc phiếu nhập kho trên kho này đều bị hệ thống chặn lại nhằm đảm bảo số liệu đếm thực tế không bị sai lệch. Sau khi Hội đồng kiểm kê hoàn tất đối soát và Quản lý kho duyệt phiếu cân bằng, hệ thống tự động cập nhật tồn và mở khóa `is_locked = FALSE`."*

### Câu 4: Sự khác biệt giữa quan hệ `<<include>>` và `<<extend>>` trong hệ thống?
- **Trả lời**: 
  - *"`<<include>>` là quan hệ bắt buộc: Ví dụ khi thực hiện 'Bàn giao & tiếp nhận vật tư nội bộ' (UC15), hệ thống bắt buộc phải thực hiện 'Tạo phiếu xuất kho cấp phát' (UC07) để xuất kho ra khỏi hệ thống.*
  - *"`<<extend>>` là quan hệ mở rộng có điều kiện: Ví dụ sau khi 'Tạo phiếu xuất kho' (UC07), CHỈ KHI số lượng tồn rớt xuống dưới mức tồn tối thiểu (`so_luong <= muc_ton_toi_thieu`) thì hệ thống mới kích hoạt ca sử dụng 'Cảnh báo định mức tồn kho' (UC09) để gửi cảnh báo đến thủ kho."*

---

## PHẦN 6: DÀN Ý TÓM TẮT 1 TRANG (DÙNG ĐỂ THEO DÕI NHANH KHI ĐỨNG THUYẾT TRÌNH)

```text
[MỞ ĐẦU]
- Tên: Hệ thống Quản lý Vật tư & Kho hàng Nội bộ Tổ chức (IT3120 - G8)
- Định vị: Quản lý hiện vật, cấp phát phòng ban, tồn kho & kiểm kê (KHÔNG MUA BÁN THƯƠNG MẠI)
- Quy mô: 6 nhóm chức năng F1-F6 | 18 Use Cases | 18 Bảng CSDL 3NF | 4 Vai trò RBAC

[6 PHÂN HỆ NGHIỆP VỤ]
- F1: Bảo mật & Phân quyền (UC01 Login, UC02 RBAC)
- F2: Danh mục Vật tư/Thiết bị (UC03 Chủng loại, UC04 Vật tư & Định mức tồn, UC05 Tra cứu)
- F3: Quản trị Kho bãi & Vị trí Kệ lưu trữ
- F4: Nghiệp vụ Kho vận Lõi (UC06 Nhập kho nội bộ, UC07 Xuất cấp phát, UC08 Chuyển kho, UC09 Cảnh báo tồn, UC10-UC11 Kiểm kê)
- F5: Quản lý Phòng ban & Cấp phát (UC12 Phòng ban, UC13 Tạo yêu cầu, UC14 Duyệt yêu cầu, UC15 Bàn giao nội bộ)
- F6: Báo cáo Thống kê (UC16 Xuất-Nhập-Tồn, UC17 Kiểm kê, UC18 Cấp phát theo Phòng ban)

[3 LUỒNG NGHIỆP VỤ CHÍNH]
- Luồng Cấp phát: Phòng ban tạo yêu cầu -> Lãnh đạo duyệt -> Thủ kho xuất cấp phát -> Bàn giao ký nhận
- Luồng Cảnh báo tồn: Xuất kho -> Kiểm tra tồn kho khả dụng -> (tồn <= tối thiểu) -> Gửi cảnh báo
- Luồng Kiểm kê: Mở đợt kiểm kê -> Chốt snapshot & Khóa giao dịch kho -> Đếm thực tế -> Duyệt chênh lệch -> Tự động cân bằng

[ĐIỂM NỔI BẬT & CÂN BẰNG MÔ HÌNH]
- 41 Quy tắc nghiệp vụ (BR01-BR41): Soft Delete, Khóa kho kiểm kê, Không xuất âm, ACID transaction
- Ma trận CRUD: 18 UC x 18 Bảng, 100% C-R, Tồn kho chỉ cập nhật qua chứng từ
- Cân bằng chuẩn OOSAD: Use Case -> Activity -> SSD -> DCD -> CSDL 3NF -> UI
```
