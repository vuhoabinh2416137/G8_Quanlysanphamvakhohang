-- =============================================================================
-- DỮ LIỆU MẪU KIỂM THỬ (SEED DATA) - warehouse_db
-- Hệ thống Quản lý Kho hàng và Vật tư Nội bộ Tổ chức (IT3120 - BTL OOSAD)
-- Phạm vi: Quản lý vật tư, Nhập/Xuất kho nội bộ, Yêu cầu cấp phát, Kiểm kê
-- Lưu ý: Dữ liệu quản lý nội bộ tổ chức - KHÔNG CÓ MUA BÁN THƯƠNG MẠI
-- =============================================================================

USE warehouse_db;

-- 1. Danh mục vật tư
INSERT INTO danh_muc (ma_danh_muc, ten_danh_muc, mo_ta, ma_danh_muc_cha) VALUES
('DM-TBTH', 'Thiết bị tin học & Văn phòng', 'Máy tính để bàn, máy in, máy quét, thiết bị mạng', NULL),
('DM-VTTH', 'Vật tư tiêu hao', 'Mực in, cáp kết nối, linh kiện phụ trợ', NULL),
('DM-GIAY', 'Giấy in & Văn phòng phẩm', 'Giấy A4, sổ sách, bút ký, kẹp tài liệu', 'DM-VTTH'),
('DM-PHUKIEN', 'Phụ kiện máy tính', 'Bàn phím, chuột quang, tai nghe chuyên dụng', 'DM-TBTH');

-- 2. Vật tư / Thiết bị
INSERT INTO san_pham (ma_sp, ten_sp, don_vi_tinh, quy_cach, nguong_ton_kho, hinh_anh_url, trang_thai, ma_danh_muc) VALUES
('VT-DELL-OPT', 'Máy tính để bàn Dell OptiPlex', 'Bộ', 'Core i5, 16GB RAM, 512GB SSD kèm màn hình 24 inch', 5, 'https://cdn.example.com/optiplex.jpg', 'DANG_SU_DUNG', 'DM-TBTH'),
('VT-CANON-2900', 'Máy in Laser Canon LBP 2900', 'Chiếc', 'Khổ A4, độ phân giải 2400x600 dpi, kết nối USB', 3, 'https://cdn.example.com/canon2900.jpg', 'DANG_SU_DUNG', 'DM-TBTH'),
('VT-GIAY-A4', 'Giấy in văn phòng Double A A4', 'Ram', 'Định lượng 70gsm, 500 tờ/ram, sản xuất Thái Lan', 20, 'https://cdn.example.com/giaya4.jpg', 'DANG_SU_DUNG', 'DM-GIAY'),
('VT-MUC-IN', 'Hộp mực in Laser Cartridge', 'Hộp', 'Tương thích Canon 2900 / HP 1020, dung lượng 2000 trang', 10, 'https://cdn.example.com/mucin.jpg', 'DANG_SU_DUNG', 'DM-VTTH'),
('VT-LOGI-M331', 'Chuột quang không dây Logitech M331', 'Chiếc', 'Kết nối Silent Wireless 2.4GHz, pin AA', 15, 'https://cdn.example.com/m331.jpg', 'DANG_SU_DUNG', 'DM-PHUKIEN');

-- 3. Phòng ban / Đơn vị nội bộ
INSERT INTO phong_ban (ma_phong_ban, ten_phong_ban, dien_thoai, dia_diem, mo_ta, trang_thai) VALUES
('PB-HCTH', 'Phòng Hành chính - Tổng hợp', '024-3869-1001', 'Tầng 2, Tòa nhà A1', 'Quản lý hành chính, hậu cần và cơ sở vật chất', 'HOAT_DONG'),
('PB-KHTC', 'Phòng Kế hoạch - Tài chính', '024-3869-1002', 'Tầng 3, Tòa nhà A1', 'Quản lý tài chính, ngân sách và kế hoạch phân bổ', 'HOAT_DONG'),
('PB-CNTT', 'Phòng Công nghệ Thông tin & Kỹ thuật', '024-3869-1003', 'Tầng 4, Tòa nhà B1', 'Quản trị hệ thống hạ tầng CNTT và phần mềm', 'HOAT_DONG'),
('PB-QLKH', 'Phòng Đào tạo & Quản lý Khoa học', '024-3869-1004', 'Tầng 2, Tòa nhà B1', 'Điều phối giảng dạy, nghiên cứu và phát triển', 'HOAT_DONG');

-- 4. Nhân viên & Tài khoản
INSERT INTO nhan_vien (ma_nv, ho_ten, ngay_sinh, gioi_tinh, dia_chi, dien_thoai, email, chuc_vu, ma_phong_ban, trang_thai) VALUES
('NV001', 'Nguyễn Văn An', '1990-05-15', 'Nam', 'Hà Nội', '0911223344', 'admin@organization.vn', 'Quản trị viên hệ thống', 'PB-CNTT', 'DANG_LAM_VIEC'),
('NV002', 'Trần Thị Khánh Linh', '1995-08-20', 'Nữ', 'Hà Nội', '0988776655', 'linh.tt@organization.vn', 'Quản lý kho', 'PB-HCTH', 'DANG_LAM_VIEC'),
('NV003', 'Lê Hoàng Long', '1998-11-10', 'Nam', 'Hà Nội', '0977665544', 'long.lh@organization.vn', 'Thủ kho / NV kho', 'PB-HCTH', 'DANG_LAM_VIEC'),
('NV004', 'Phạm Minh Tuấn', '1994-02-14', 'Nam', 'Hà Nội', '0966554433', 'tuan.pm@organization.vn', 'Đại diện Phòng ban CNTT', 'PB-CNTT', 'DANG_LAM_VIEC');

INSERT INTO tai_khoan (ten_dang_nhap, mat_khau_hash, ma_nv, trang_thai) VALUES
('admin', '.Fq4.wB2Ff4ZkL5u6pQWzJjK7q9L0m1N2O3P', 'NV001', 'HOAT_DONG'),
('linh.warehouse', '.Fq4.wB2Ff4ZkL5u6pQWzJjK7q9L0m1N2O3P', 'NV002', 'HOAT_DONG'),
('long.staff', '.Fq4.wB2Ff4ZkL5u6pQWzJjK7q9L0m1N2O3P', 'NV003', 'HOAT_DONG'),
('tuan.dept', '.Fq4.wB2Ff4ZkL5u6pQWzJjK7q9L0m1N2O3P', 'NV004', 'HOAT_DONG');

INSERT INTO vai_tro (ma_vai_tro, ten_vai_tro, mo_ta) VALUES
('ROLE_ADMIN', 'Quản trị hệ thống', 'Toàn quyền cấu hình bảo mật, tài khoản và xem mọi dữ liệu'),
('ROLE_WAREHOUSE_MGR', 'Quản lý kho', 'Phê duyệt cấp phát vật tư, điều chuyển, tổ chức kiểm kê và báo cáo'),
('ROLE_WAREHOUSE_STAFF', 'Thủ kho / NV kho', 'Thực hiện xuất/nhập kho nội bộ, bàn giao vật tư và kiểm đếm'),
('ROLE_DEPT_STAFF', 'Đại diện Phòng ban', 'Lập phiếu yêu cầu cấp phát vật tư, theo dõi và ký nhận bàn giao');

INSERT INTO tai_khoan_vai_tro (ten_dang_nhap, ma_vai_tro) VALUES
('admin', 'ROLE_ADMIN'),
('linh.warehouse', 'ROLE_WAREHOUSE_MGR'),
('long.staff', 'ROLE_WAREHOUSE_STAFF'),
('tuan.dept', 'ROLE_DEPT_STAFF');

-- 5. Kho hàng & Vị trí
INSERT INTO kho (ma_kho, ten_kho, dia_chi, so_dien_thoai, ma_quan_ly) VALUES
('KHO-HN-01', 'Kho Vật tư Tổng', 'Số 1 Đại Cồ Việt, Hai Bà Trưng, Hà Nội', '024-3869-1234', 'NV002'),
('KHO-HN-02', 'Kho Thiết bị Dự phòng', 'Cầu Giấy, Hà Nội', '024-3869-5678', 'NV002');

INSERT INTO vi_tri_kho (ma_vi_tri, ma_kho, khu_vuc, ke, tang) VALUES
('VT-HN-A1-1', 'KHO-HN-01', 'Khu A - Thiết bị CNTT', 'Kệ 01', 'Tầng 1'),
('VT-HN-A1-2', 'KHO-HN-01', 'Khu A - Thiết bị CNTT', 'Kệ 01', 'Tầng 2'),
('VT-HN-B2-1', 'KHO-HN-01', 'Khu B - Văn phòng phẩm', 'Kệ 02', 'Tầng 1');

-- 6. Tồn kho khởi tạo
INSERT INTO ton_kho (ma_kho, ma_sp, so_luong) VALUES
('KHO-HN-01', 'VT-DELL-OPT', 25),
('KHO-HN-01', 'VT-CANON-2900', 12),
('KHO-HN-01', 'VT-GIAY-A4', 85),
('KHO-HN-01', 'VT-MUC-IN', 30),
('KHO-HN-01', 'VT-LOGI-M331', 50),
('KHO-HN-02', 'VT-DELL-OPT', 10),
('KHO-HN-02', 'VT-LOGI-M331', 20);

-- 7. Phiếu yêu cầu cấp phát vật tư mẫu
INSERT INTO yeu_cau_cap_phat (ma_yeu_cau, ma_phong_ban, ma_nv_yeu_cau, ma_nv_duyet, ngay_yeu_cau, ngay_duyet, muc_dich_su_dung, trang_thai, ghi_chu) VALUES
('YCCP-2026-001', 'PB-CNTT', 'NV004', 'NV002', '2026-09-10 08:30:00', '2026-09-10 14:00:00', 'Trang bị phòng thực hành tin học mới cho năm học 2026-2027', 'DA_DUYET', 'Ưu tiên cấp phát sớm trong tuần');

INSERT INTO chi_tiet_yeu_cau (ma_yeu_cau, ma_sp, so_luong_yeu_cau, so_luong_duyet, ghi_chu) VALUES
('YCCP-2026-001', 'VT-DELL-OPT', 5, 5, 'Cấp phát máy đồng bộ'),
('YCCP-2026-001', 'VT-LOGI-M331', 5, 5, 'Chuột dự phòng đi kèm');

-- 8. Phiếu nhập kho mẫu (Tiếp nhận bàn giao vật tư phân bổ từ cấp trên)
INSERT INTO phieu_nhap_kho (ma_phieu_nhap, ma_kho, ma_nv_nhap, ly_do_nhap, ma_phong_ban_giao, ghi_chu, trang_thai) VALUES
('PNK-2026-101', 'KHO-HN-01', 'NV003', 'TIEP_NHAN_PHAN_BO', 'PB-HCTH', 'Tiếp nhận bàn giao phân bổ vật tư đợt 1 năm 2026 từ Ban Quản lý', 'DA_XAC_NHAN');

INSERT INTO muc_nhap_kho (ma_phieu_nhap, ma_sp, so_luong, ma_vi_tri, ghi_chu) VALUES
('PNK-2026-101', 'VT-DELL-OPT', 20, 'VT-HN-A1-1', 'Thiết bị mới 100% nguyên niêm phong'),
('PNK-2026-101', 'VT-LOGI-M331', 50, 'VT-HN-A1-2', 'Chuột quang không dây đóng hộp');

-- 9. Phiếu xuất kho mẫu (Xuất cấp phát cho phòng ban theo yêu cầu YCCP-2026-001)
INSERT INTO phieu_xuat_kho (ma_phieu_xuat, ma_kho, ma_nv_xuat, ma_yeu_cau, ma_phong_ban_nhan, ma_kho_nhan, ly_do_xuat, ghi_chu, trang_thai) VALUES
('PXK-2026-301', 'KHO-HN-01', 'NV003', 'YCCP-2026-001', 'PB-CNTT', NULL, 'CAP_PHAT_NOI_BO', 'Xuất cấp phát theo phiếu yêu cầu YCCP-2026-001 đã được phê duyệt', 'DA_XAC_NHAN');

INSERT INTO muc_xuat_kho (ma_phieu_xuat, ma_sp, so_luong_yeu_cau, so_luong_thuc_xuat, ghi_chu) VALUES
('PXK-2026-301', 'VT-DELL-OPT', 5, 5, 'Bàn giao 5 bộ máy tính Dell cho Phòng CNTT'),
('PXK-2026-301', 'VT-LOGI-M331', 5, 5, 'Bàn giao 5 chuột Logitech');