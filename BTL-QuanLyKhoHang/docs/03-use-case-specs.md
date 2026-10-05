# 03 - Đặc tả Chi tiết 07 Ca sử dụng Cốt lõi (Use Case Specifications)

> **Quy định của Giảng viên**: **Không tính ca sử dụng Đăng nhập/Đăng xuất**. Hệ thống có đúng **07 Ca sử dụng nghiệp vụ cốt lõi**, phân công cân bằng **1 Thành viên = 1 Ca sử dụng trọn gói (Owner)**.

---

## Danh Mục Tổng Thể 07 Ca Sử Dụng & Phân Công Thành Viên

| Mã UC | Tên Ca Sử Dụng | Phân hệ BFD | Tác nhân chính | Phân loại | Điểm UUCW | Thành viên phụ trách (Owner) |
|:---:|:---|:---|:---|:---:|:---:|:---|
| **UC01** | **Quản trị Người dùng & Phân quyền RBAC** | F1. Quản trị & Bảo mật | Quản trị viên (Admin) | Average (6 trans.) | 10 | **Vũ Hòa Bình** *(TV1)* |
| **UC02** | **Quản lý Danh mục & Hồ sơ Vật tư, Thiết bị** | F2. Danh mục & Vật tư | Quản lý kho | Complex (8 trans.) | 15 | **Nguyễn Trung Ngân** *(TV4)* |
| **UC03** | **Lập & Theo dõi Yêu cầu Cấp phát Vật tư** | F3. Yêu cầu & Cấp phát | Đại diện Phòng ban | Complex (9 trans.) | 15 | **Lý Công Hiếu** *(TV2)* |
| **UC04** | **Thẩm định & Phê duyệt Yêu cầu Cấp phát** | F3. Yêu cầu & Cấp phát | Quản lý kho | Average (6 trans.) | 10 | **Phạm Duy Hiếu** *(TV3)* |
| **UC05** | **Quản lý Nhập kho & Điều chuyển Vật tư** | F4. Vận hành Kho vận | Thủ kho / NV Kho | Complex (10 trans.)| 15 | **Hoàng Trọng Đức Anh** *(TV5)* |
| **UC06** | **Quản lý Xuất kho & Bàn giao Cấp phát** | F4. Vận hành Kho vận | Thủ kho / NV Kho | Complex (10 trans.)| 15 | **Đỗ Duy Đức** *(TV6)* |
| **UC07** | **Kiểm kê Kho hàng & Báo cáo Thống kê** | F5. Kiểm kê & Báo cáo | Quản lý kho | Complex (12 trans.)| 15 | **Thành viên 7** *(TV7)* |

---

## UC01: Quản Trị Người Dùng & Phân Quyền RBAC

### Thông tin tổng quan
| Mục | Nội dung |
|:---|:---|
| **Tên ca sử dụng** | Quản Trị Người Dùng & Phân Quyền RBAC |
| **Mã UC** | UC01 |
| **Tác nhân chính** | Quản trị viên (Admin) |
| **Người phụ trách (Owner)** | **Vũ Hòa Bình (TV1)** |
| **Mô tả** | Quản trị viên quản lý danh mục nhân viên cơ quan, cấp phát tài khoản hệ thống, gán/thu hồi vai trò theo mô hình RBAC và cấu hình phân quyền truy cập chức năng |
| **Độ phức tạp** | Average (6 transactions) — 10 UUCW |
| **Tiền điều kiện** | Quản trị viên đã đăng nhập thành công với quyền `ROLE_ADMIN` |
| **Hậu điều kiện** | Hồ sơ nhân sự, tài khoản và ma trận quyền hạn được lưu vào CSDL; ghi nhật ký kiểm toán (Audit Log) |

### Luồng sự kiện chính (Main Flow)
1. Admin truy cập phân hệ "Quản trị người dùng & Phân quyền".
2. Hệ thống hiển thị danh sách nhân viên, tài khoản liên kết và vai trò tương ứng.
3. Admin chọn thao tác: Thêm nhân viên mới, Cấp tài khoản, hoặc Cập nhật vai trò.
4. Khi gán vai trò: Admin chọn tài khoản và gán một hoặc nhiều vai trò (`ROLE_ADMIN`, `ROLE_WAREHOUSE_MGR`, `ROLE_DEPT_STAFF`, `ROLE_WAREHOUSE_STAFF`).
5. Hệ thống kiểm tra hợp lệ dữ liệu (định dạng email, trùng lặp mã nhân viên/CCCD).
6. Admin xác nhận lưu thay đổi phân quyền.
7. Hệ thống cập nhật bảng `taikhoan`, `vaitro_taikhoan`, sinh mã hash mật khẩu (bcrypt).
8. Hệ thống ghi nhật ký kiểm toán (`AuditLog`) và gửi email thông báo thông tin tài khoản cho nhân viên.

---

## UC02: Quản Lý Danh Mục & Hồ Sơ Vật Tư, Thiết Bị

### Thông tin tổng quan
| Mục | Nội dung |
|:---|:---|
| **Tên ca sử dụng** | Quản Lý Danh Mục & Hồ Sơ Vật Tư, Thiết Bị |
| **Mã UC** | UC02 |
| **Tác nhân chính** | Quản lý kho (Warehouse Manager) |
| **Người phụ trách (Owner)** | **Nguyễn Trung Ngân (TV4)** |
| **Mô tả** | Quản lý kho tạo mới và quản trị cây danh mục phân cấp (nhóm/loại), hồ sơ thông số kỹ thuật, đơn vị tính, ngưỡng định mức tồn an toàn tối thiểu và bộ lọc tìm kiếm tra cứu |
| **Độ phức tạp** | Complex (8 transactions) — 15 UUCW |
| **Tiền điều kiện** | Quản lý kho đã đăng nhập với quyền `ROLE_WAREHOUSE_MGR` |
| **Hậu điều kiện** | Thông tin danh mục và vật tư lưu vào CSDL; thiết lập sẵn ngưỡng cảnh báo tồn cho từng kho |

### Luồng sự kiện chính (Main Flow)
1. Quản lý kho mở giao diện "Quản lý Danh mục & Vật tư".
2. Hệ thống hiển thị cây danh mục phân cấp và lưới dữ liệu danh sách vật tư hiện hành.
3. Quản lý kho chọn thêm mới hoặc chỉnh sửa hồ sơ vật tư: nhập mã vật tư (duy nhất), tên, quy cách kỹ thuật, ĐVT, nhóm danh mục cha.
4. Quản lý kho cấu hình ngưỡng tồn an toàn tối thiểu (`NguongToiThieu >= 0`) phục vụ cảnh báo tự động.
5. Hệ thống kiểm tra ràng buộc nghiệp vụ (BR04: Mã duy nhất, BR11: Không tạo vòng lặp danh mục).
6. Quản lý kho xác nhận lưu thông tin.
7. Hệ thống lưu vào bảng `danhmucvattu`, `vattu`, cập nhật cấu trúc tìm kiếm chỉ mục (Index).
8. Hệ thống thông báo cập nhật danh mục thành công.

---

## UC03: Lập & Theo Dõi Yêu Cầu Cấp Phát Vật Tư

### Thông tin tổng quan
| Mục | Nội dung |
|:---|:---|
| **Tên ca sử dụng** | Lập & Theo Dõi Yêu Cầu Cấp Phát Vật Tư |
| **Mã UC** | UC03 |
| **Tác nhân chính** | Đại diện Phòng ban (Department Staff) |
| **Người phụ trách (Owner)** | **Lý Công Hiếu (TV2)** |
| **Mô tả** | Cán bộ đại diện phòng ban tạo phiếu đề nghị cấp phát vật tư/thiết bị theo nhu cầu công tác, đối chiếu định mức kỳ và theo dõi tiến độ phê duyệt |
| **Độ phức tạp** | Complex (9 transactions) — 15 UUCW |
| **Tiền điều kiện** | Cán bộ phòng ban đã đăng nhập; tài khoản gắn với phòng ban hợp lệ |
| **Hậu điều kiện** | Phiếu yêu cầu lưu ở trạng thái `CHO_DUYET`; gửi thông báo cho Quản lý kho |

### Luồng sự kiện chính (Main Flow)
1. Đại diện phòng ban chọn "Tạo phiếu yêu cầu cấp phát vật tư".
2. Hệ thống hiển thị biểu mẫu yêu cầu với mã phiếu tự sinh (`YC-YYYYMMDD-XXX`), ngày tạo và thông tin phòng ban.
3. Đại diện phòng ban nhập mục đích sử dụng (trang bị mới, sửa chữa, định kỳ) và ngày cần nhận.
4. Đại diện phòng ban thêm các dòng vật tư: chọn vật tư từ danh mục, nhập số lượng yêu cầu (`> 0`).
5. Hệ thống tự động kiểm tra định mức kỳ còn lại của phòng ban đối với từng loại vật tư.
6. Hệ thống hiển thị cảnh báo nếu số lượng yêu cầu vượt hạn mức định mức.
7. Đại diện phòng ban xác nhận gửi phiếu yêu cầu.
8. Hệ thống lưu vào `yeucaucapphat` và `chitietyeucau` với trạng thái `CHO_DUYET`.
9. Hệ thống gửi email thông báo và hiển thị thông báo Dashboard cho Quản lý kho.

---

## UC04: Thẩm Định & Phê Duyệt Yêu Cầu Cấp Phát

### Thông tin tổng quan
| Mục | Nội dung |
|:---|:---|
| **Tên ca sử dụng** | Thẩm Định & Phê Duyệt Yêu Cầu Cấp Phát |
| **Mã UC** | UC04 |
| **Tác nhân chính** | Quản lý kho (Warehouse Manager) |
| **Người phụ trách (Owner)** | **Phạm Duy Hiếu (TV3)** |
| **Mô tả** | Quản lý kho thẩm định tính hợp lý về định mức sử dụng, đối soát tồn kho khả dụng để phê duyệt toàn phần / một phần hoặc từ chối yêu cầu cấp phát của phòng ban |
| **Độ phức tạp** | Average (6 transactions) — 10 UUCW |
| **Tiền điều kiện** | Có phiếu yêu cầu cấp phát đang ở trạng thái `CHO_DUYET` |
| **Hậu điều kiện** | Phiếu yêu cầu chuyển sang `DA_DUYET` hoặc `TU_CHOI`; thông báo email gửi đi; sinh lệnh xuất kho |

### Luồng sự kiện chính (Main Flow)
1. Quản lý kho mở danh sách "Yêu cầu cấp phát chờ duyệt".
2. Hệ thống hiển thị danh sách các phiếu `CHO_DUYET`, sắp xếp theo thời gian và mức độ ưu tiên.
3. Quản lý kho chọn 1 phiếu yêu cầu để xem xét thẩm định.
4. Hệ thống hiển thị chi tiết: phòng ban đề xuất, mục đích sử dụng, số lượng yêu cầu, tồn kho khả dụng thực tế.
5. Quản lý kho xác nhận số lượng duyệt cấp phát cho từng mục (cho phép duyệt đủ hoặc duyệt một phần).
6. Quản lý kho bấm "Phê duyệt" (hoặc "Từ chối" kèm lý do bắt buộc).
7. Hệ thống cập nhật trạng thái phiếu thành `DA_DUYET`, lưu vết thời gian và người duyệt vào `lichsuduyet`.
8. Hệ thống gửi email thông báo kết quả cho phòng ban và tự động gửi lệnh xuất kho cấp phát đến Dashboard của Thủ kho.

---

## UC05: Quản Lý Nhập Kho & Điều Chuyển Vật Tư

### Thông tin tổng quan
| Mục | Nội dung |
|:---|:---|
| **Tên ca sử dụng** | Quản Lý Nhập Kho & Điều Chuyển Vật Tư |
| **Mã UC** | UC05 |
| **Tác nhân chính** | Thủ kho / Nhân viên kho (Warehouse Staff) |
| **Người phụ trách (Owner)** | **Hoàng Trọng Đức Anh (TV5)** |
| **Mô tả** | Thủ kho tiếp nhận vật tư phân bổ từ cấp trên, thu hồi hoàn nhập từ phòng ban, hoặc điều chuyển giữa các kho nội bộ; kiểm đếm thực tế, chỉ định vị trí kệ và ghi tăng tồn kho |
| **Độ phức tạp** | Complex (10 transactions) — 15 UUCW |
| **Tiền điều kiện** | Thủ kho đã đăng nhập; có vật tư thực tế và biên bản bàn giao/lệnh điều chuyển |
| **Hậu điều kiện** | Phiếu nhập kho lưu trạng thái `DA_XAC_NHAN`; tồn kho tăng nguyên tử; cập nhật lịch sử thẻ kho |

### Luồng sự kiện chính (Main Flow)
1. Thủ kho chọn "Tạo phiếu nhập kho nội bộ" (hoặc tiếp nhận lệnh điều chuyển kho).
2. Hệ thống sinh mã phiếu (`PNK-YYYYMMDD-XXX`), gán thời điểm hiện tại và thủ kho tiếp nhận.
3. Thủ kho chọn kho nhận, lý do nhập (`PHAN_BO_CAP_TREN`, `HOAN_NHAP_PHONG_BAN`, `CHUYEN_KHO_DEN`).
4. Thủ kho thêm từng mục vật tư: chọn mã VT, nhập số lượng thực nhận, chỉ định vị trí Dãy Kệ - Tầng - Ô.
5. Hệ thống kiểm tra tính hợp lệ dữ liệu (số lượng `> 0`, vật tư ở trạng thái lưu hành).
6. Trường hợp điều chuyển: Hệ thống tự động đối chiếu số lượng xuất từ kho nguồn và số lượng nhập tại kho đích.
7. Thủ kho xác nhận lưu và ký biên bản tiếp nhận vật tư.
8. Hệ thống thực hiện Transaction ACID: Lưu `phieunhapkho`, `mucnhapkho`, tăng `TonKho += soLuongThucNhan`.
9. Hệ thống cập nhật thẻ kho (Stock Card) và hiển thị thông báo thành công.

---

## UC06: Quản Lý Xuất Kho & Bàn Giao Cấp Phát

### Thông tin tổng quan
| Mục | Nội dung |
|:---|:---|
| **Tên ca sử dụng** | Quản Lý Xuất Kho & Bàn Giao Cấp Phát |
| **Mã UC** | UC06 |
| **Tác nhân chính** | Thủ kho / Nhân viên kho (Warehouse Staff) |
| **Người phụ trách (Owner)** | **Đỗ Duy Đức (TV6)** |
| **Mô tả** | Thủ kho lập phiếu xuất kho căn cứ theo yêu cầu đã duyệt, kiểm tra chống xuất âm và khóa kiểm kê, bàn giao hiện vật, ký biên bản 2 bên, trừ tồn kho và phát cảnh báo tồn thấp |
| **Độ phức tạp** | Complex (10 transactions) — 15 UUCW |
| **Tiền điều kiện** | Có lệnh yêu cầu cấp phát `DA_DUYET` (hoặc lệnh xuất điều chuyển); tồn kho khả dụng đủ |
| **Hậu điều kiện** | Phiếu xuất kho lưu trữ; tồn kho giảm nguyên tử; yêu cầu cấp phát chuyển `HOAN_THANH`; cảnh báo nếu tồn thấp |

### Luồng sự kiện chính (Main Flow)
1. Thủ kho mở danh sách lệnh xuất cấp phát, chọn phiếu yêu cầu đã duyệt (`DA_DUYET`).
2. Hệ thống kế thừa toàn bộ thông tin: phòng ban nhận, danh mục vật tư và số lượng được duyệt cấp phát.
3. Hệ thống kiểm tra số lượng tồn kho khả dụng (`soLuongXuat <= TonKho.soLuong`) và kiểm tra vật tư có bị khóa kiểm kê không.
4. Thủ kho xuất kho hàng thực tế tại các vị trí kệ kho được chỉ định.
5. Cán bộ phòng ban nhận hàng kiểm đếm quy cách thực tế và hai bên tiến hành ký nhận biên bản bàn giao.
6. Thủ kho xác nhận hoàn tất xuất kho trên hệ thống.
7. Hệ thống lưu `phieuxuatkho`, `mucxuatkho`, cập nhật giảm `TonKho -= soLuongXuat`, chuyển trạng thái yêu cầu sang `HOAN_THANH`.
8. Hệ thống kiểm tra ngưỡng an toàn: Nếu `TonKho <= NguongToiThieu` $\rightarrow$ Tự động kích hoạt thông báo cảnh báo đỏ trên Dashboard và gửi email cảnh báo đến Quản lý kho.

---

## UC07: Kiểm Kê Kho Hàng & Báo Cáo Thống Kê Tổng Hợp

### Thông tin tổng quan
| Mục | Nội dung |
|:---|:---|
| **Tên ca sử dụng** | Kiểm Kê Kho Hàng & Báo Cáo Thống Kê Tổng Hợp |
| **Mã UC** | UC07 |
| **Tác nhân chính** | Quản lý kho (Warehouse Manager) |
| **Người phụ trách (Owner)** | **Thành viên 7 (TV7)** |
| **Mô tả** | Tổ chức đợt kiểm kê hiện vật định kỳ/đột xuất, chốt số liệu sổ sách, tạm khóa giao dịch, tính toán sai lệch thực tế, giải trình lý do và tự sinh phiếu cân bằng kho; đồng thời kết xuất báo cáo XNT và tình hình cấp phát |
| **Độ phức tạp** | Complex (12 transactions) — 15 UUCW |
| **Tiền điều kiện** | Quản lý kho lên kế hoạch kiểm kê; các thủ kho đã sẵn sàng kiểm đếm |
| **Hậu điều kiện** | Tồn kho được điều chỉnh khớp thực tế; biên bản kiểm kê và các báo cáo thống kê kỳ được kết xuất lưu trữ |

### Luồng sự kiện chính (Main Flow)
1. Quản lý kho khởi tạo đợt kiểm kê: chọn kho kiểm kê, thời điểm bắt đầu và thành phần hội đồng.
2. Hệ thống chụp ảnh chốt tồn sổ sách (Stock Snapshot) và tạm khóa xuất/nhập phạm vi kiểm kê.
3. Nhân viên kho kiểm đếm hiện vật thực tế tại từng ô/kệ và nhập số lượng đếm thực tế vào hệ thống.
4. Hệ thống tính toán đối soát sai lệch: `ChenhLech = SL_ThucTe - SL_SoSach` (Thừa/Thiếu/Khớp).
5. Quản lý kho yêu cầu giải trình nguyên nhân đối với các dòng vật tư phát sinh chênh lệch.
6. Quản lý kho phê duyệt kết quả kiểm kê.
7. Hệ thống tự động sinh phiếu điều chỉnh cân bằng: phiếu nhập cân đối (nếu thừa) hoặc phiếu xuất cân đối (nếu thiếu), cập nhật tồn kho chính thức theo số thực tế và mở khóa giao dịch.
8. Quản lý kho kết xuất bộ Báo cáo Thống kê kỳ: Báo cáo Kiểm kê sai lệch, Báo cáo Cân đối Xuất - Nhập - Tồn toàn cơ quan, Báo cáo Thống kê Cấp phát theo từng Phòng ban ra định dạng Excel/PDF.
