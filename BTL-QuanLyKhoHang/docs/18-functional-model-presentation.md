# 18 - Kịch bản Thuyết trình Bảo vệ Đồ án (07 Ca sử dụng Cốt lõi)

> **Học phần**: IT3120 - Phân tích và Thiết kế Hệ thống Thông tin  
> **Viện Công nghệ Thông tin và Truyền thông - Đại học Bách Khoa Hà Nội (HUST)**  
> **Đề tài**: Hệ thống Quản lý Vật tư và Kho hàng Nội bộ Tổ chức  
> **Nhóm thực hiện**: Nhóm 8 (G8) — Quy mô: 07 thành viên  

---

## PHẦN 1: MỞ ĐẦU & TỔNG QUAN PHẠM VI (1 Phút)

### 🗣️ Lời trình bày mẫu (Trưởng nhóm - Vũ Hòa Bình):
> *"Kính thưa các thầy cô trong Hội đồng phản biện môn IT3120. Hôm nay, Nhóm 8 xin phép được bảo vệ Đồ án: **Hệ thống Quản lý Vật tư và Kho hàng Nội bộ của Tổ chức**.*
>
> *Đề tài tập trung chuyên sâu vào công tác quản trị hiện vật, cấp phát theo nhu cầu phòng ban, xuất/nhập/điều chuyển kho nội bộ và kiểm kê định kỳ — **tuyệt đối không có các nghiệp vụ mua bán thương mại hay giao dịch tiền tệ**.*
>
> *Theo quy chuẩn hướng dẫn của Thầy, hệ thống **không tính ca sử dụng Đăng nhập/Đăng xuất** và được chuẩn hóa thành đúng **07 Ca sử dụng nghiệp vụ cốt lõi (UC01 – UC07)**, phân bổ cân bằng 1-1 cho **07 thành viên trong nhóm**, ánh xạ hoàn chỉnh với **18 bảng CSDL quan hệ chuẩn hóa 3NF**."*

---

## PHẦN 2: DANH MỤC 07 CA SỬ DỤNG CỐT LÕI (1 THÀNH VIÊN = 1 UC) (2 Phút)

| Mã UC | Tên Ca sử dụng Cốt lõi | Thành viên chủ trì (Owner) | Mục tiêu nghiệp vụ cốt lõi |
|:---:|:---|:---|:---|
| **UC01** | **Quản trị Người dùng & Phân quyền RBAC** | **Vũ Hòa Bình** *(TV1)* | Cấp tài khoản nhân viên, phân quyền truy cập theo 4 vai trò, giám sát an toàn hệ thống |
| **UC02** | **Quản lý Danh mục & Hồ sơ Vật tư, Thiết bị** | **Nguyễn Trung Ngân** *(TV4)*| Cây danh mục phân cấp, hồ sơ thông số kỹ thuật, cấu hình ngưỡng tồn an toàn tối thiểu |
| **UC03** | **Lập & Theo dõi Yêu cầu Cấp phát Vật tư** | **Lý Công Hiếu** *(TV2)* | Phòng ban lập phiếu đề xuất vật tư, kiểm soát định mức kỳ, theo dõi tiến độ duyệt |
| **UC04** | **Thẩm định & Phê duyệt Yêu cầu Cấp phát** | **Phạm Duy Hiếu** *(TV3)* | Quản lý kho đối soát tồn khả dụng, thẩm định định mức, duyệt/từ chối, phát lệnh xuất |
| **UC05** | **Quản lý Nhập kho & Điều chuyển Vật tư** | **Hoàng Trọng Đức Anh** *(TV5)*| Tiếp nhận phân bổ, hoàn nhập phòng ban, điều chuyển kho, tăng tồn kho nguyên tử |
| **UC06** | **Quản lý Xuất kho & Bàn giao Cấp phát** | **Đỗ Duy Đức** *(TV6)* | Xuất kho theo lệnh duyệt, ký biên bản bàn giao 2 bên, trừ tồn kho và cảnh báo tồn thấp |
| **UC07** | **Kiểm kê Kho hàng & Báo cáo Thống kê** | **Thành viên 7** *(TV7)* | Mở đợt kiểm kê, chốt sổ, đối soát chênh lệch, tự cân đối kho, xuất báo cáo XNT kỳ |

---

## PHẦN 3: CÁC LUỒNG NGHIỆP VỤ CỐT LÕI (2 Phút)

### 1. Luồng Cấp phát Vật tư Phòng ban:
```
[Đại diện Phòng ban]        [Quản lý Kho]              [Thủ kho / NV Kho]
        │                         │                             │
        ├─ Lập yêu cầu (UC03) ───>│                             │
        │                         ├─ Thẩm định duyệt (UC04) ───>│
        │                         │                             ├─ Xuất kho cấp phát (UC06)
        │<── Ký nhận bàn giao (UC06) ───────────────────────────┤
```

### 2. Luồng Xuất kho & Cảnh báo Tồn thấp:
- Khi thủ kho hoàn tất xuất kho trong `UC06`, Transaction Service trừ tồn kho nguyên tử (`TonKho -= soLuong`).
- Nếu `TonKho <= NguongToiThieu`, hệ thống tự động phát cảnh báo đỏ trên Dashboard và gửi email đến Quản lý kho.

### 3. Luồng Kiểm kê & Tự động Cân bằng:
- Quản lý kho mở đợt kiểm kê (`UC07`) $\rightarrow$ Chốt tồn sổ sách & tạm khóa giao dịch $\rightarrow$ Thủ kho đếm thực tế $\rightarrow$ Hệ thống tính chênh lệch $\rightarrow$ Quản lý duyệt giải trình $\rightarrow$ Hệ thống tự sinh phiếu cân bằng kho và mở khóa.

---

## PHẦN 4: HƯỚNG DẪN TRẢ LỜI CÂU HỎI PHẢN BIỆN (Q&A DEFENSE)

### Câu 1: Tại sao hệ thống chỉ có đúng 7 Ca sử dụng và không có Đăng nhập/Đăng xuất?
- **Trả lời**: *"Dạ thưa Thầy/Cô, theo nguyên lý OOSAD hiện đại và chỉ đạo của Giảng viên hướng dẫn: Đăng nhập/Đăng xuất chỉ là cơ chế kỹ thuật hỗ trợ (Utility/Security Mechanism), không mang lại giá trị nghiệp vụ trực tiếp cho tác nhân nên không tính là Use Case nghiệp vụ. Nhóm đã tránh chia vụn thành các hàm CRUD đơn giản mà chuẩn hóa hệ thống thành **đúng 7 Ca sử dụng nghiệp vụ cốt lõi**. Mỗi ca sử dụng là một tiến trình nghiệp vụ hoàn chỉnh mang lại giá trị trọn vẹn, tương ứng 1-1 với 7 thành viên trong nhóm, giúp phân định trách nhiệm rõ ràng và bảo vệ độc lập."*

### Câu 2: Làm sao đảm bảo tính cân bằng giữa các thành viên?
- **Trả lời**: *"Dạ thưa Thầy/Cô, nhóm đánh giá quy mô theo phương pháp Use Case Points (UCP). Tổng điểm UUCW của 7 ca sử dụng là 95 điểm, gồm 2 ca Average (10 điểm) và 5 ca Complex (15 điểm). Điểm số của từng bạn nằm trong khoảng từ 10 đến 15 điểm (độ lệch cực tiểu $\le 5$ điểm). Mỗi thành viên chịu trách nhiệm trọn gói 6 artifacts kỹ thuật của ca sử dụng mình làm Owner (Đặc tả, Activity, SSD, Sequence, UI Mockup, Test Cases) và đóng góp ~236 giờ làm việc."*
