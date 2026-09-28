# BTL-IT3120: Phân tích & Thiết kế Hệ thống Quản lý Vật tư và Kho hàng Nội bộ

> **Học phần**: IT3120 - Phân tích và Thiết kế Hệ thống Thông tin  
> **Viện Công nghệ Thông tin và Truyền thông - Đại học Bách Khoa Hà Nội (HUST)**.  
> **Chủ đề**: Hệ thống Quản lý Vật tư và Kho hàng Nội bộ Tổ chức (Tập trung Danh mục Vật tư/Thiết bị, Cấp phát phòng ban, Nhập/Xuất kho nội bộ, Điều chuyển, Tồn kho & Kiểm kê - Tuyệt đối không có nghiệp vụ mua bán thương mại).

Dự án áp dụng toàn diện phương pháp **Phân tích và Thiết kế Hệ thống Hướng đối tượng (OOSAD)** theo tiến trình phát triển hợp nhất nâng cao (**Enhanced Unified Process - EUP**), sử dụng ngôn ngữ mô hình hóa **UML 2.5** để xây dựng bộ hồ sơ phân tích & thiết kế hoàn chỉnh cho **Hệ thống Quản lý Vật tư và Kho hàng Nội bộ** phục vụ nhu cầu vận hành của một cơ quan / tổ chức / doanh nghiệp.

---

## Danh mục Hồ sơ & Deliverables Đã Hoàn Thành (18/18)

| STT | Giai đoạn | Deliverable | Tài liệu Markdown | Mã nguồn PlantUML | Hình ảnh Sơ đồ Rendered |
|:---:|:---|:---|:---|:---|:---|
| 01 | Khởi tạo (Inception) | Yêu cầu hệ thống (System Request) | [01-system-request.md](./docs/01-system-request.md) | - | - |
| 02 | Phân tích chức năng | Biểu đồ Ca sử dụng (Use Case Diagram) | [02-use-case-diagram.md](./docs/02-use-case-diagram.md) | [use-case-diagram.puml](./plantuml/use-case-diagram.puml) | [use-case-diagram.png](./diagrams/use-case-diagram.png) |
| 03 | Phân tích chức năng | Đặc tả Chi tiết Ca sử dụng (Use Case Specs) | [03-use-case-specs.md](./docs/03-use-case-specs.md) | - | - |
| 04 | Phân tích chức năng | Biểu đồ Hoạt động (Activity Diagrams) | [04-activity-diagrams.md](./docs/04-activity-diagrams.md) | [activity-diagrams.puml](./plantuml/activity-diagrams.puml)<br>[activity-nhap-kho.puml](./plantuml/activity-nhap-kho.puml) | [activity-nhap-kho.png](./diagrams/activity-nhap-kho.png)<br>[activity-xuat-kho.png](./diagrams/activity-xuat-kho.png)<br>[activity-kiem-ke-kho.png](./diagrams/activity-kiem-ke-kho.png)<br>[activity-yeu-cau-cap-phat.png](./diagrams/activity-yeu-cau-cap-phat.png) |
| 05 | Phân tích cấu trúc | Biểu đồ Lớp Lĩnh vực (Domain Model) | [05-domain-class-diagram.md](./docs/05-domain-class-diagram.md) | [domain-class-diagram.puml](./plantuml/domain-class-diagram.puml) | [domain-class-diagram.png](./diagrams/domain-class-diagram.png) |
| 06 | Phân tích cấu trúc | Biểu đồ Đối tượng (Object Diagrams) | [06-object-diagrams.md](./docs/06-object-diagrams.md) | [object-diagrams.puml](./plantuml/object-diagrams.puml) | [object-diagram-phieu-nhap.png](./diagrams/object-diagram-phieu-nhap.png)<br>[object-diagram-phieu-xuat-chuyen-kho.png](./diagrams/object-diagram-phieu-xuat-chuyen-kho.png) |
| 07 | Phân tích hành vi | Sơ đồ Tuần tự Hệ thống (SSD) | [07-ssd.md](./docs/07-ssd.md) | [ssd.puml](./plantuml/ssd.puml) | [ssd-nhap-kho.png](./diagrams/ssd-nhap-kho.png)<br>[ssd-xuat-kho.png](./diagrams/ssd-xuat-kho.png)<br>[ssd-yeu-cau-cap-phat.png](./diagrams/ssd-yeu-cau-cap-phat.png)<br>[ssd-kiem-ke.png](./diagrams/ssd-kiem-ke.png) |
| 08 | Phân tích hành vi | Sơ đồ Tuần tự Thiết kế (Design Sequence) | [08-sequence-diagrams.md](./docs/08-sequence-diagrams.md) | [sequence-diagrams.puml](./plantuml/sequence-diagrams.puml) | [sequence-nhap-kho.png](./diagrams/sequence-nhap-kho.png)<br>[sequence-xuat-kho.png](./diagrams/sequence-xuat-kho.png)<br>[sequence-kiem-ke.png](./diagrams/sequence-kiem-ke.png) |
| 09 | Phân tích hành vi | Sơ đồ Máy Trạng thái (State Machine) | [09-state-machine.md](./docs/09-state-machine.md) | [state-machine.puml](./plantuml/state-machine.puml) | [state-yeu-cau-cap-phat.png](./diagrams/state-yeu-cau-cap-phat.png)<br>[state-phieu-xuat-kho.png](./diagrams/state-phieu-xuat-kho.png)<br>[state-san-pham.png](./diagrams/state-san-pham.png) |
| 10 | Kiến trúc hệ thống | Sơ đồ Gói (Package Diagram) | [10-package-diagram.md](./docs/10-package-diagram.md) | [package-diagram.puml](./plantuml/package-diagram.puml) | [package-diagram.png](./diagrams/package-diagram.png) |
| 11 | Kiến trúc hệ thống | Sơ đồ Triển khai (Deployment Diagram) | [11-deployment-diagram.md](./docs/11-deployment-diagram.md) | [deployment-diagram.puml](./plantuml/deployment-diagram.puml) | [deployment-diagram.png](./diagrams/deployment-diagram.png) |
| 12 | Thiết kế lớp | Biểu đồ Lớp Thiết kế (Design Class Diagram) | [12-design-class-diagram.md](./docs/12-design-class-diagram.md) | [design-class-diagram.puml](./plantuml/design-class-diagram.puml) | [design-class-diagram.png](./diagrams/design-class-diagram.png) |
| 13 | Thiết kế lưu trữ | Thiết kế Cơ sở Dữ liệu & DDL SQL | [13-database-design.md](./docs/13-database-design.md) | [database-design.puml](./plantuml/database-design.puml) | [database-design.png](./diagrams/database-design.png) |
| 14 | Thiết kế lưu trữ | Thiết kế các Lớp DAM / DAO | [14-dam-classes.md](./docs/14-dam-classes.md) | [dam-classes.puml](./plantuml/dam-classes.puml) | [dam-classes.png](./diagrams/dam-classes.png) |
| 15 | Thiết kế giao diện | Thiết kế Giao diện Người dùng (UI/UX) | [15-ui-design.md](./docs/15-ui-design.md) | - | Wireframe Dashboard Kho, Nhập kho nội bộ, Xuất kho cấp phát phòng ban |
| 16 | Ước lượng dự án | Ước lượng Chi phí Dự án theo UCP | [16-ucp-estimation.md](./docs/16-ucp-estimation.md) | - | UAW=13, UUCW=185, TCF=1.015, EF=0.755 $\rightarrow$ 151.73 UCP $\approx$ 3,035 giờ |
| 17 | Phân tích chức năng | Mô hình Chức năng Chi tiết (BFD, CRUD, Luồng NV) | [17-functional-model.md](./docs/17-functional-model.md) | [functional-model-*.puml](./plantuml/) | BFD 3 cấp, Ma trận CRUD 18×17, 41 Business Rules, Luồng cấp phát |
| 18 | Thuyết trình & Bảo vệ | Kịch bản & Bản trình bày Mô hình Chức năng | [18-functional-model-presentation.md](./docs/18-functional-model-presentation.md) | - | Kịch bản thuyết trình từng phần, tóm tắt 1 trang, Q&A phản biện |

---

## Cấu trúc Thư mục

```
BTL-QuanLyKhoHang/
├── docs/                              # 18 tài liệu phân tích, thiết kế & thuyết trình chi tiết
│   ├── 01-system-request.md           # Yêu cầu hệ thống
│   ├── 02-use-case-diagram.md         # Biểu đồ ca sử dụng
│   ├── 03-use-case-specs.md           # Đặc tả ca sử dụng chi tiết
│   ├── 04-activity-diagrams.md        # Biểu đồ hoạt động
│   ├── 05-domain-class-diagram.md     # Biểu đồ lớp lĩnh vực
│   ├── 06-object-diagrams.md          # Biểu đồ đối tượng
│   ├── 07-ssd.md                      # Sơ đồ tuần tự mức hệ thống
│   ├── 08-sequence-diagrams.md        # Sơ đồ tuần tự thiết kế
│   ├── 09-state-machine.md            # Sơ đồ máy trạng thái
│   ├── 10-package-diagram.md          # Sơ đồ gói
│   ├── 11-deployment-diagram.md       # Sơ đồ triển khai
│   ├── 12-design-class-diagram.md     # Biểu đồ lớp thiết kế
│   ├── 13-database-design.md          # Thiết kế CSDL (18 bảng chuẩn 3NF)
│   ├── 14-dam-classes.md              # Lớp DAM/DAO
│   ├── 15-ui-design.md                # Thiết kế giao diện kho hàng
│   ├── 16-ucp-estimation.md           # Ước lượng UCP
│   ├── 17-functional-model.md         # Mô hình chức năng chi tiết
│   └── 18-functional-model-presentation.md # Kịch bản thuyết trình mô hình chức năng
├── plantuml/                          # Mã nguồn PlantUML
│   ├── use-case-diagram.puml
│   ├── domain-class-diagram.puml
│   ├── object-diagrams.puml
│   ├── activity-diagrams.puml
│   ├── activity-nhap-kho.puml
│   ├── ssd.puml
│   ├── sequence-diagrams.puml
│   ├── state-machine.puml
│   ├── package-diagram.puml
│   ├── deployment-diagram.puml
│   ├── design-class-diagram.puml
│   ├── dam-classes.puml
│   ├── database-design.puml
│   ├── functional-model-bfd.puml
│   ├── functional-model-flow-mua-nhap.puml
│   ├── functional-model-flow-xuat-canh-bao.puml
│   ├── functional-model-flow-kiem-ke.puml
│   ├── functional-model-rbac-matrix.puml
│   ├── functional-model-state-machines.puml
│   └── functional-model-uc-relations.puml
├── diagrams/                          # Các ảnh PNG kết xuất từ PlantUML
├── sql/                               # Kịch bản DDL & dữ liệu mẫu
│   ├── schema.sql                     # DDL tạo 18 bảng CSDL chuẩn hóa
│   └── seed-data.sql                  # Dữ liệu mẫu kiểm thử
├── render-diagrams.bat                # Script render tự động toàn bộ diagrams
└── README.md                          # Tổng quan dự án
```

---

## Kiểm tra Cân bằng Mô hình (Model Balancing Checklist)
Hệ thống tuân thủ nghiêm ngặt checklist cân bằng mô hình theo giáo trình môn học:
- [x] **Chức năng $\leftrightarrow$ Hành vi**: Các bước trong luồng sự kiện của đặc tả UC ánh xạ 1-1 với các hoạt động trên Activity Diagram và các sự kiện trong SSD.
- [x] **Cấu trúc $\leftrightarrow$ Hành vi**: Tất cả các đối tượng và phương thức trao đổi thông điệp trong sơ đồ tuần tự mức thiết kế đều tồn tại trên Biểu đồ lớp thiết kế (Design Class Diagram).
- [x] **Cấu trúc $\leftrightarrow$ Lưu trữ**: Mọi thực thể nghiệp vụ (Domain Entities) đều được ánh xạ chính xác sang bảng quan hệ (3NF) và có lớp quản lý truy cập dữ liệu (DAM/DAO) tương ứng theo chuẩn mã nguồn IT3120.
- [x] **Mô hình tĩnh $\leftrightarrow$ Thể hiện**: Sơ đồ đối tượng (Object Diagram) hoàn toàn khớp với định nghĩa thuộc tính và cơ số trên Biểu đồ lớp miền.
- [x] **Thiết kế phần mềm $\leftrightarrow$ Nguyên lý chuẩn**: Áp dụng đầy đủ nguyên lý SOLID, GRASP và các Design Patterns kinh điển (Factory, Observer, Strategy, Repository).

---

## Kế hoạch Phân công Nhiệm vụ (07 Thành viên)
Chi tiết ma trận phân công WBS, vai trò, khối lượng giờ theo UCP, tiến độ 6 tuần và tiêu chí nghiệm thu được quy định tại:
👉 **[PHAN-CONG-NHIEM-VU.md](./PHAN-CONG-NHIEM-VU.md)**

---

## Nhóm Sinh viên Thực hiện (Nhóm 8)
1. **Vũ Hòa Bình** — *Project Manager & Lead Architect*
2. **Lý Công Hiếu** — *Business Analyst 1 (Cấp phát & Đơn vị)*
3. **Phạm Duy Hiếu** — *Business Analyst 2 (Kho vận, Xuất-Nhập-Tồn, Kiểm kê)*
4. **Nguyễn Trung Ngân** — *Database Architect & Data Engineer*
5. **Hoàng Trọng Đức Anh** — *Software System Architect*
6. **Đỗ Duy Đức** — *UI/UX Designer & Prototype Specialist*
7. **Thành viên 7** *(Cập nhật Họ tên)* — *QA Lead & Functional Auditor*

