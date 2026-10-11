# KẾ HOẠCH PHÂN CÔNG NHIỆM VỤ DỰ ÁN (07 THÀNH VIÊN — 07 CA SỬ DỤNG CỐT LÕI)

> **Học phần**: IT3120 - Phân tích và Thiết kế Hệ thống Thông tin  
> **Viện Công nghệ Thông tin và Truyền thông - Đại học Bách Khoa Hà Nội (HUST)**  
> **Đề tài**: Hệ thống Quản lý Vật tư và Kho hàng Nội bộ Tổ chức  
> **Nhóm thực hiện**: Nhóm 8 (G8) — Quy mô: **07 Thành viên**  
> **Quy định**: Phân chia cân bằng **1 Thành viên = 1 Ca sử dụng trọn gói (Owner)** (Không tính Đăng nhập/Đăng xuất).

---

## PHÂN CÔNG NHIỆM VỤ CHI TIẾT TỪNG THÀNH VIÊN

### 1. Thành viên 1: Vũ Hòa Bình

- **Ca sử dụng phụ trách chính (Owner)**: `UC01: Quản trị Người dùng & Phân quyền RBAC`
- **Hạng mục phụ trách trọn gói & Nhiệm vụ chi tiết**:
  1. **Khởi tạo & Quản trị Dự án**: Xây dựng toàn bộ tài liệu Khởi tạo dự án (01-system-request.md); đề ra mục tiêu bài toán, phạm vi nghiệp vụ và kế hoạch quản lý rủi ro dự án.
  2. **Ước lượng Nỗ lực Phần mềm**: Tính toán và bảo vệ bảng tính ước lượng khối lượng công việc theo phương pháp Use Case Points (16-ucp-estimation.md).
  3. **Phân tích & Đặc tả chi tiết Nghiệp vụ UC01 (Quản trị Người dùng & Phân quyền RBAC)**:
     - *Quản lý hồ sơ nhân sự*: Khai báo, chỉnh sửa, tra cứu thông tin nhân viên (Mã NV, Họ tên, Email, SĐT, CCCD, Phòng ban trực thuộc, Trạng thái hoạt động).
     - *Cấp phát & Khóa tài khoản*: Cấp mới tài khoản đăng nhập gắn với nhân sự, khóa/mở khóa tài khoản khi thay đổi nhân sự, cơ chế đặt lại mật khẩu an toàn.
     - *Phân quyền theo vai trò (RBAC - Role-Based Access Control)*: Cấu hình ma trận 4 vai trò chính (`ROLE_ADMIN`, `ROLE_WAREHOUSE_MGR`, `ROLE_DEPT_STAFF`, `ROLE_WAREHOUSE_STAFF`); gán vai trò cho tài khoản; kiểm soát phân quyền truy cập chức năng và dữ liệu.
     - *Quản lý danh mục Phòng ban/Đơn vị*: Khai báo cơ cấu tổ chức phòng ban nội bộ làm căn cứ phân quyền và kiểm soát hạn mức cấp phát.
     - *An toàn thông tin & Nhật ký kiểm toán (Audit Log)*: Băm mật khẩu (BCrypt hashing), ghi nhận lịch sử thao tác đăng nhập và thay đổi quyền hạn trong hệ thống.
  4. **Hoàn thiện trọn gói 06 Artifacts kỹ thuật cho UC01**: Hoàn thiện trọn gói 6 artifacts bao gồm Use Case Specifications, Activity Diagram, System Sequence Diagram (SSD), Design Sequence Diagram (4 tầng), UI Prototype, và Test Cases cho ca sử dụng `UC01`.
  5. **Kiểm soát Chất lượng Kiến trúc (Model Balancing Checklist)**: Chủ trì rà soát tính nhất quán tuyệt đối giữa các góc nhìn: Chức năng $\leftrightarrow$ Hành vi $\leftrightarrow$ Cấu trúc $\leftrightarrow$ Lưu trữ $\leftrightarrow$ Giao diện.
  6. **Quản lý Cấu hình & Tích hợp**: Quản lý kho mã nguồn Git, thiết lập quy trình làm việc (Git workflow), kiểm duyệt Pull Requests và tổng hợp bộ tài liệu đồ án nộp giảng viên.

---

### 2. Thành viên 2: Lý Công Hiếu

- **Ca sử dụng phụ trách chính (Owner)**: `UC03: Lập & Theo dõi Yêu cầu Cấp phát Vật tư`
- **Hạng mục phụ trách trọn gói & Nhiệm vụ chi tiết**:
  1. **Xây dựng Biểu đồ Ca sử dụng Tổng thể**: Khảo sát yêu cầu, xây dựng Biểu đồ Ca sử dụng toàn hệ thống (02-use-case-diagram.md) và mã nguồn biểu đồ Use Case bao gồm 07 UC cốt lõi và các quan hệ include, extend.
  2. **Chuẩn hóa Quy trình Nhu cầu Đơn vị**: Khảo sát biểu mẫu, định mức sử dụng vật tư định kỳ của các phòng ban trong cơ quan/tổ chức.
  3. **Phân tích & Đặc tả chi tiết Nghiệp vụ UC03 (Lập & Theo dõi Yêu cầu Cấp phát Vật tư)**:
     - *Khởi tạo phiếu yêu cầu*: Tự động sinh mã phiếu chuẩn (`YC-YYYYMMDD-XXX`), xác định thông tin phòng ban yêu cầu và cán bộ đại diện.
     - *Chọn vật tư & Khai báo nhu cầu*: Tra cứu danh mục vật tư khả dụng, nhập số lượng cần cấp, mục đích sử dụng (trang bị mới, sửa chữa, định kỳ), thời hạn mong muốn nhận.
     - *Kiểm soát định mức kỳ của đơn vị*: Hệ thống tự động kiểm tra số lượng yêu cầu so với hạn mức/định mức tháng/quý của phòng ban; hiển thị cảnh báo nếu vượt hạn mức.
     - *Gửi yêu cầu & Kích hoạt luồng duyệt*: Chuyển trạng thái phiếu sang `CHO_DUYET`, gửi thông báo qua Dashboard và Email cho Quản lý kho.
     - *Theo dõi tiến độ & Lịch sử đề xuất*: Cho phép phòng ban theo dõi trạng thái phiếu theo thời gian thực (Chờ duyệt, Đã duyệt, Đang xuất kho, Đã hoàn thành, Từ chối), cho phép hủy yêu cầu khi chưa duyệt.
  4. **Hoàn thiện trọn gói 06 Artifacts kỹ thuật cho UC03**: Hoàn thiện trọn gói 6 artifacts bao gồm Use Case Specifications, Activity Diagram, System Sequence Diagram (SSD), Design Sequence Diagram (4 tầng), UI Prototype, và Test Cases cho ca sử dụng `UC03`.
  5. **Rà soát Liên thông Nghiệp vụ Phân hệ Cấp phát**: Phối hợp cùng Thành viên 3 và Thành viên 6 đảm bảo tính liền mạch của luồng thông tin: Lập yêu cầu (`UC03`) $\rightarrow$ Thẩm định phê duyệt (`UC04`) $\rightarrow$ Xuất kho bàn giao (`UC06`).

---

### 3. Thành viên 3: Phạm Duy Hiếu

- **Ca sử dụng phụ trách chính (Owner)**: `UC04: Thẩm định & Phê duyệt Yêu cầu Cấp phát`
- **Hạng mục phụ trách trọn gói & Nhiệm vụ chi tiết**:
  1. **Chuẩn hóa Sơ đồ Hoạt động Tổng thể**: Chủ trì rà soát và chuẩn hóa toàn bộ Sơ đồ Hoạt động nghiệp vụ trong tài liệu Sơ đồ hoạt động (04-activity-diagrams.md) đảm bảo khớp 100% với luồng sự kiện Use Case.
  2. **Thiết kế Cơ chế Tích hợp Thông báo**: Thiết kế quy trình gửi email thông báo tự động (qua SMTP Gateway) khi có kết quả phê duyệt hoặc yêu cầu bị từ chối.
  3. **Phân tích & Đặc tả chi tiết Nghiệp vụ UC04 (Thẩm định & Phê duyệt Yêu cầu Cấp phát)**:
     - *Tiếp nhận hàng đợi thẩm định*: Hiển thị danh sách các phiếu yêu cầu ở trạng thái `CHO_DUYET`, sắp xếp theo thời gian gửi và mức độ ưu tiên.
     - *Thẩm định tính hợp lý & Đối soát tồn kho*: Tra cứu tồn kho khả dụng thực tế của từng mục vật tư yêu cầu; đối chiếu định mức và lịch sử sử dụng của phòng ban.
     - *Quyết định phê duyệt đa phương án*:
       * **Duyệt toàn phần**: Phê duyệt 100% số lượng vật tư theo đề xuất của phòng ban.
       * **Duyệt một phần**: Điều chỉnh giảm số lượng duyệt cấp phát dựa trên tồn kho thực tế và mức độ ưu tiên.
       * **Từ chối yêu cầu**: Từ chối cấp phát và bắt buộc nhập lý do cụ thể (hết hàng tồn kho, không đúng định mức, nhu cầu chưa hợp lý).
     - *Phát lệnh xuất kho cấp phát*: Cập nhật trạng thái phiếu sang `DA_DUYET`, tự động tạo lệnh xuất kho chuyển tiếp sang Dashboard của Thủ kho.
     - *Thông báo tự động*: Kích hoạt gửi email thông báo kết quả thẩm định kèm lý do/số lượng duyệt về đại diện phòng ban.
  4. **Hoàn thiện trọn gói 06 Artifacts kỹ thuật cho UC04**: Hoàn thiện trọn gói 6 artifacts bao gồm Use Case Specifications, Activity Diagram, System Sequence Diagram (SSD), Design Sequence Diagram (4 tầng), UI Prototype, và Test Cases cho ca sử dụng `UC04`.
  5. **Kiểm soát Tính toàn vẹn Trạng thái Nghiệp vụ**: Rà soát tính logic giữa trạng thái `CHO_DUYET` $\rightarrow$ `DA_DUYET` / `TU_CHOI` đảm bảo không xảy ra xung đột dữ liệu.

---

### 4. Thành viên 4: Nguyễn Trung Ngân

- **Ca sử dụng phụ trách chính (Owner)**: `UC02: Quản lý Danh mục & Hồ sơ Vật tư, Thiết bị`
- **Hạng mục phụ trách trọn gói & Nhiệm vụ chi tiết**:
  1. **Thiết kế Kiến trúc Cơ sở Dữ liệu Tổng thể**:
     - Thiết kế mô hình CSDL quan hệ 18 bảng chuẩn hóa 3NF (13-database-design.md).
     - Viết kịch bản DDL chuẩn ANSI SQL (schema.sql) và bộ dữ liệu mẫu thực nghiệm (seed-data.sql).
     - Xây dựng Biểu đồ Lớp Lĩnh vực (05-domain-class-diagram.md) và Biểu đồ Đối tượng (06-object-diagrams.md).
     - Thiết kế các lớp truy xuất dữ liệu theo mẫu Data Access Module (14-dam-classes.md).
  2. **Phân tích & Đặc tả chi tiết Nghiệp vụ UC02 (Quản lý Danh mục & Hồ sơ Vật tư, Thiết bị)**:
     - *Cây danh mục phân cấp*: Thiết lập nhóm và loại vật tư theo cấu trúc phân cấp hình cây (nhóm cha - nhóm con, ngăn chặn vòng lặp danh mục).
     - *Quản lý hồ sơ thông số kỹ thuật*: Khai báo mã vật tư duy nhất, tên, quy cách kỹ thuật, xuất xứ, đơn vị tính chuẩn (Cái, Bộ, Mét, Thùng...), trạng thái lưu hành.
     - *Cấu hình định mức tồn an toàn*: Thiết lập ngưỡng tồn tối thiểu (Min) và tồn tối đa (Max) cho từng loại vật tư tại từng kho làm căn cứ cảnh báo tự động.
     - *Quy chuẩn định vị & Mã hóa*: Quy định vị trí lưu trữ mặc định (Dãy - Kệ - Tầng - Ô) và cấu hình mã hóa barcode/QR code tra cứu nhanh.
     - *Bộ lọc tìm kiếm đa tiêu chí*: Xây dựng bộ chỉ mục (Index) tìm kiếm nhanh theo mã, tên, danh mục, trạng thái tồn và quy cách kỹ thuật.
  3. **Hoàn thiện trọn gói 06 Artifacts kỹ thuật cho UC02**: Hoàn thiện trọn gói 6 artifacts bao gồm Use Case Specifications, Activity Diagram, System Sequence Diagram (SSD), Design Sequence Diagram (4 tầng), UI Prototype, và Test Cases cho ca sử dụng `UC02`.
  4. **Tối ưu hóa Truy vấn & Toàn vẹn Dữ liệu**: Thiết lập khóa ngoại (Foreign Keys), ràng buộc kiểm tra (Check Constraints), chỉ mục (Indexes) và tối ưu hóa hiệu năng truy vấn cho toàn bộ 7 ca sử dụng của nhóm.

---

### 5. Thành viên 5: Hoàng Trọng Đức Anh

- **Ca sử dụng phụ trách chính (Owner)**: `UC05: Quản lý Nhập kho & Điều chuyển Vật tư`
- **Hạng mục phụ trách trọn gói & Nhiệm vụ chi tiết**:
  1. **Thiết kế Kiến trúc Phần mềm Tổng thể**:
     - Xây dựng Biểu đồ Lớp Thiết kế toàn diện (Design Class Diagram - DCD) trong tài liệu (12-design-class-diagram.md).
     - Thiết kế Sơ đồ Gói kiến trúc 4 tầng (10-package-diagram.md) và Sơ đồ Triển khai vật lý (11-deployment-diagram.md).
     - Thiết kế Sơ đồ Máy Trạng thái (State Machine Diagrams) cho vòng đời của các thực thể cốt lõi (09-state-machine.md).
     - Chuẩn hóa cấu trúc Design Sequence Diagrams toàn hệ thống (08-sequence-diagrams.md).
  2. **Phân tích & Đặc tả chi tiết Nghiệp vụ UC05 (Quản lý Nhập kho & Điều chuyển Vật tư)**:
     - *Tiếp nhận nhiều nguồn nhập kho*: Xử lý 3 nguồn nhập chính: Nhập phân bổ từ cấp trên/nhà cung cấp, Nhập hoàn trả/thu hồi từ phòng ban, Nhập điều chuyển giữa các kho nội bộ.
     - *Kiểm đếm thực tế & Lập biên bản*: Ghi nhận số lượng thực tế nhận bàn giao, kiểm tra quy cách chất lượng, lập biên bản ghi nhận sai lệch (nếu có).
     - *Định vị lưu trữ vào kho*: Chỉ định chính xác vị trí lưu cất hiện vật theo cấu trúc Dãy Kệ - Tầng - Ô để quản lý vị trí trực quan.
     - *Quy trình điều chuyển kho nội bộ*: Thiết lập lệnh điều chuyển từ Kho nguồn sang Kho đích, đối soát khớp lệnh giữa 2 thủ kho xuất và nhập.
     - *Tăng tồn kho nguyên tử & Cập nhật thẻ kho*: Thực thi Transaction ACID cập nhật tức thời tồn kho (`TonKho += soLuongThucNhan`), tự động ghi log thẻ kho (Stock Card) và cập nhật giá trị tồn.
  3. **Hoàn thiện trọn gói 06 Artifacts kỹ thuật cho UC05**: Hoàn thiện trọn gói 6 artifacts bao gồm Use Case Specifications, Activity Diagram, System Sequence Diagram (SSD), Design Sequence Diagram (4 tầng), UI Prototype, và Test Cases cho ca sử dụng `UC05`.
  4. **Kiểm soát Tính toàn vẹn Giao dịch (Transaction Integrity)**: Đảm bảo cơ chế Rollback khi có lỗi xảy ra trong quá trình ghi đồng thời nhiều bảng (`phieunhapkho`, `mucnhapkho`, `tonkho`, `thekho`).

---

### 6. Thành viên 6: Đỗ Duy Đức

- **Ca sử dụng phụ trách chính (Owner)**: `UC06: Quản lý Xuất kho & Bàn giao Cấp phát`
- **Hạng mục phụ trách trọn gói & Nhiệm vụ chi tiết**:
  1. **Thiết kế Hệ thống Giao diện Người dùng (Design System & UI)**:
     - Xây dựng tài liệu Thiết kế Giao diện (15-ui-design.md) theo phong cách Dashboard quản trị hiện đại.
     - Chuẩn hóa bộ hướng dẫn thiết kế (Design Guidelines, Typography, Color Palette, UI Components) cho cả 7 Ca sử dụng của nhóm.
     - Xây dựng bản mẫu tương tác (Interactive Web / Figma Prototype) phục vụ buổi báo cáo và bảo vệ đồ án.
  2. **Phân tích & Đặc tả chi tiết Nghiệp vụ UC06 (Quản lý Xuất kho & Bàn giao Cấp phát)**:
     - *Tiếp nhận lệnh xuất cấp phát*: Tự động kế thừa thông tin từ phiếu yêu cầu đã ở trạng thái `DA_DUYET` (hoặc lệnh xuất điều chuyển kho).
     - *Kiểm soát điều kiện xuất kho (Chống xuất âm & Khóa kiểm kê)*: Hệ thống tự động kiểm tra số lượng xuất không vượt quá tồn kho khả dụng (`soLuongXuat <= TonKho`), ngăn chặn xuất đối với các mặt hàng đang bị khóa tạm thời do kiểm kê.
     - *Soạn hàng & In phiếu xuất*: Chỉ dẫn vị trí kệ kho cần lấy hàng, in Phiếu xuất kho theo mẫu quy chuẩn kế toán nội bộ.
     - *Bàn giao hiện vật & Ký nhận 2 bên*: Thủ kho giao hiện vật cho cán bộ phòng ban nhận, ký xác nhận biên bản bàn giao hai bên.
     - *Giảm tồn kho & Cảnh báo tồn an toàn*: Giảm trừ tồn kho nguyên tử (`TonKho -= soLuongXuat`), chuyển trạng thái phiếu yêu cầu sang `HOAN_THANH`, tự động kích hoạt cảnh báo đỏ trên Dashboard và gửi email cảnh báo nếu tồn kho giảm xuống dưới ngưỡng tối thiểu (`TonKho <= NguongToiThieu`).
  3. **Hoàn thiện trọn gói 06 Artifacts kỹ thuật cho UC06**: Hoàn thiện trọn gói 6 artifacts bao gồm Use Case Specifications, Activity Diagram, System Sequence Diagram (SSD), Design Sequence Diagram (4 tầng), UI Prototype, và Test Cases cho ca sử dụng `UC06`.
  4. **Kiểm tra Tính khả dụng Giao diện (Usability Testing)**: Rà soát tính thân thiện, độ tiện dụng trên form nhập liệu và khả năng tương thích hiển thị trên nhiều độ phân giải màn hình.

---

### 7. Thành viên 7: [Điền Họ và Tên]

- **Ca sử dụng phụ trách chính (Owner)**: `UC07: Kiểm kê Kho hàng & Báo cáo Thống kê`
- **Hạng mục phụ trách trọn gói & Nhiệm vụ chi tiết**:
  1. **Xây dựng Mô hình Chức năng Nâng cao**:
     - Xây dựng tài liệu Mô hình chức năng (17-functional-model.md) gồm: Biểu đồ BFD 3 cấp phân rã chức năng, Ma trận CRUD 7x18 liên kết Use Cases và Thực thể CSDL, Danh mục 41 Quy tắc nghiệp vụ (Business Rules), Ma trận truy vết Traceability FR-UC.
     - Soạn thảo Kịch bản bảo vệ đồ án chi tiết và bộ câu hỏi phản biện chuyên sâu (18-functional-model-presentation.md).
     - Thiết kế toàn bộ Slide thuyết trình báo cáo trước hội đồng và điều phối các phiên tổng duyệt Dry Run.
  2. **Phân tích & Đặc tả chi tiết Nghiệp vụ UC07 (Kiểm kê Kho hàng & Báo cáo Thống kê)**:
     - *Khởi tạo đợt kiểm kê & Chốt số dư*: Mở đợt kiểm kê định kỳ/đột xuất, thành lập ban kiểm kê, chụp ảnh chốt tồn sổ sách (Stock Snapshot) và tạm khóa giao dịch xuất/nhập đối với phạm vi kiểm kê.
     - *Ghi nhận kiểm đếm thực tế*: Nhân viên kiểm đếm hiện vật thực tế tại từng ô/kệ và nhập số lượng đếm thực tế vào hệ thống.
     - *Tự động đối soát & Tính toán sai lệch*: Hệ thống tự động so khớp `ChenhLech = SL_ThucTe - SL_SoSach`; phân loại: Khớp, Thừa (thực tế > sổ sách), Thiếu (thực tế < sổ sách); yêu cầu biên bản giải trình nguyên nhân chênh lệch.
     - *Tự động sinh phiếu điều chỉnh cân bằng kho*: Khi Quản lý kho duyệt kết quả kiểm kê, hệ thống tự động sinh phiếu nhập cân đối (nếu thừa) hoặc phiếu xuất cân đối (nếu thiếu), cập nhật lại tồn kho chính thức theo số thực tế và mở khóa giao dịch.
     - *Kết xuất hệ thống Báo cáo Thống kê tổng hợp*:
       * Báo cáo Kết quả Kiểm kê và Sai lệch kho.
       * Báo cáo Cân đối Xuất - Nhập - Tồn (XNT) toàn cơ quan theo kỳ.
       * Báo cáo Thống kê Tình hình Cấp phát và Tiêu hao vật tư theo từng Phòng ban.
       * Hỗ trợ xuất dữ liệu ra định dạng Excel và PDF chuẩn mẫu in.
  3. **Hoàn thiện trọn gói 06 Artifacts kỹ thuật cho UC07**: Hoàn thiện trọn gói 6 artifacts bao gồm Use Case Specifications, Activity Diagram, System Sequence Diagram (SSD), Design Sequence Diagram (4 tầng), UI Prototype, và Test Cases cho ca sử dụng `UC07`.
  4. **Kiểm toán Cân bằng Mô hình Toàn diện (Traceability Audit)**: Thực hiện kiểm tra chéo từng mắt xích: System Request $\rightarrow$ Use Case $\rightarrow$ Activity $\rightarrow$ DCD $\rightarrow$ Database $\rightarrow$ UI, đảm bảo không có bất kỳ mâu thuẫn hay lỗ hổng nào trong đồ án.

---
*Bản kế hoạch phân công nhiệm vụ chuẩn hóa này có hiệu lực áp dụng xuyên suốt đồ án IT3120 của Nhóm 8. Mỗi thành viên chịu trách nhiệm trọn gói trước Giảng viên và Nhóm về chất lượng ca sử dụng cũng như các hạng mục được giao.*
