-- =============================================================================
-- DỮ LIỆU MẪU KIỂM THỬ (SEED DATA) - warehouse_db
-- Hệ thống Quản lý Sản phẩm và Kho hàng (IT3120 - BTL OOSAD)
-- =============================================================================

USE warehouse_db;

-- 1. Danh mục sản phẩm
INSERT INTO danh_muc (ma_danh_muc, ten_danh_muc, mo_ta, ma_danh_muc_cha) VALUES
('DM-DIENTHOAI', 'Điện thoại thông minh', 'Các dòng điện thoại di động cao cấp và tầm trung', NULL),
('DM-MAYTINH', 'Máy tính & Laptop', 'Laptop văn phòng, gaming và máy trạm', NULL),
('DM-PHUKIEN', 'Phụ kiện công nghệ', 'Tai nghe, cáp sạc, ốp lưng, chuột, bàn phím', NULL),
('DM-TAINGHE', 'Tai nghe không dây', 'Tai nghe TWS Bluetooth', 'DM-PHUKIEN');

-- 2. Sản phẩm
INSERT INTO san_pham (ma_sp, ten_sp, don_vi_tinh, gia_nhap_chuan, gia_ban_niem_yet, nguong_ton_kho, hinh_anh_url, trang_thai, ma_danh_muc) VALUES
('SP-SAM-S24U', 'Samsung Galaxy S24 Ultra 512GB', 'Chiếc', 25000000, 31990000, 5, 'https://cdn.example.com/s24u.jpg', 'DANG_KINH_DOANH', 'DM-DIENTHOAI'),
('SP-APP-IP16P', 'iPhone 16 Pro Max 256GB', 'Chiếc', 29000000, 34990000, 5, 'https://cdn.example.com/ip16pm.jpg', 'DANG_KINH_DOANH', 'DM-DIENTHOAI'),
('SP-SAM-BUDS3', 'Tai nghe Galaxy Buds 3 Pro', 'Bộ', 5000000, 6490000, 10, 'https://cdn.example.com/buds3.jpg', 'DANG_KINH_DOANH', 'DM-TAINGHE'),
('SP-LOGI-MX3S', 'Chuột Logitech MX Master 3S', 'Chiếc', 1800000, 2490000, 8, 'https://cdn.example.com/mx3s.jpg', 'DANG_KINH_DOANH', 'DM-PHUKIEN'),
('SP-DELL-P24', 'Màn hình Dell UltraSharp U2424H', 'Chiếc', 4800000, 6200000, 4, 'https://cdn.example.com/u2424h.jpg', 'DANG_KINH_DOANH', 'DM-MAYTINH');

-- 3. Nhân viên & Tài khoản
INSERT INTO nhan_vien (ma_nv, ho_ten, ngay_sinh, gioi_tinh, dia_chi, dien_thoai, email, chuc_vu, trang_thai) VALUES
('NV001', 'Nguyễn Văn An', '1990-05-15', 'Nam', 'Hà Nội', '0911223344', 'admin@warehouse.com', 'Quản trị viên', 'DANG_LAM_VIEC'),
('NV002', 'Trần Thị Khánh Linh', '1995-08-20', 'Nữ', 'Hà Nội', '0988776655', 'linh.tt@warehouse.com', 'Quản lý kho', 'DANG_LAM_VIEC'),
('NV003', 'Lê Hoàng Long', '1998-11-10', 'Nam', 'Hà Nội', '0977665544', 'long.lh@warehouse.com', 'Nhân viên kho', 'DANG_LAM_VIEC'),
('NV004', 'Phạm Minh Tuấn', '1994-02-14', 'Nam', 'Hà Nội', '0966554433', 'tuan.pm@warehouse.com', 'Nhân viên mua hàng', 'DANG_LAM_VIEC'),
('NV005', 'Nguyễn Văn Bình', '1996-09-30', 'Nam', 'Hà Nội', '0912345678', 'binh.nv@warehouse.com', 'Nhân viên bán hàng', 'DANG_LAM_VIEC');

INSERT INTO tai_khoan (ten_dang_nhap, mat_khau_hash, ma_nv, trang_thai) VALUES
('admin', '.Fq4.wB2Ff4ZkL5u6pQWzJjK7q9L0m1N2O3P', 'NV001', 'HOAT_DONG'),
('linh.warehouse', '.Fq4.wB2Ff4ZkL5u6pQWzJjK7q9L0m1N2O3P', 'NV002', 'HOAT_DONG'),
('long.staff', '.Fq4.wB2Ff4ZkL5u6pQWzJjK7q9L0m1N2O3P', 'NV003', 'HOAT_DONG'),
('tuan.purchasing', '.Fq4.wB2Ff4ZkL5u6pQWzJjK7q9L0m1N2O3P', 'NV004', 'HOAT_DONG'),
('binh.sales', '.Fq4.wB2Ff4ZkL5u6pQWzJjK7q9L0m1N2O3P', 'NV005', 'HOAT_DONG');

INSERT INTO vai_tro (ma_vai_tro, ten_vai_tro, mo_ta) VALUES
('ROLE_ADMIN', 'Quản trị hệ thống', 'Toàn quyền cấu hình và xem mọi dữ liệu'),
('ROLE_WAREHOUSE_MGR', 'Quản lý kho', 'Duyệt đơn mua, quản lý kiểm kê và báo cáo tồn kho'),
('ROLE_WAREHOUSE_STAFF', 'Thủ kho / NV kho', 'Thực hiện nhập kho, xuất kho và kiểm đếm'),
('ROLE_PURCHASING', 'Nhân viên Mua hàng', 'Tạo PO và làm việc với Nhà cung cấp'),
('ROLE_SALES', 'Nhân viên Bán hàng', 'Tạo đơn bán hàng và quản lý khách hàng');

INSERT INTO tai_khoan_vai_tro (ten_dang_nhap, ma_vai_tro) VALUES
('admin', 'ROLE_ADMIN'),
('linh.warehouse', 'ROLE_WAREHOUSE_MGR'),
('long.staff', 'ROLE_WAREHOUSE_STAFF'),
('tuan.purchasing', 'ROLE_PURCHASING'),
('binh.sales', 'ROLE_SALES');

-- 4. Kho hàng & Vị trí
INSERT INTO kho (ma_kho, ten_kho, dia_chi, so_dien_thoai, ma_quan_ly) VALUES
('KHO-HN-01', 'Kho Tổng Hà Nội', 'Số 1 Đại Cồ Việt, Hai Bà Trưng, Hà Nội', '024-3869-1234', 'NV002'),
('KHO-SG-01', 'Kho Chi nhánh TP.HCM', 'Quận 1, TP. Hồ Chí Minh', '028-3900-5678', 'NV002');

INSERT INTO vi_tri_kho (ma_vi_tri, ma_kho, khu_vuc, ke, tang) VALUES
('VT-HN-A1-1', 'KHO-HN-01', 'Khu A - Điện thoại', 'Kệ 01', 'Tầng 1'),
('VT-HN-A1-2', 'KHO-HN-01', 'Khu A - Điện thoại', 'Kệ 01', 'Tầng 2'),
('VT-HN-B2-1', 'KHO-HN-01', 'Khu B - Phụ kiện', 'Kệ 02', 'Tầng 1');

-- 5. Tồn kho khởi tạo
INSERT INTO ton_kho (ma_kho, ma_sp, so_luong) VALUES
('KHO-HN-01', 'SP-SAM-S24U', 35),
('KHO-HN-01', 'SP-APP-IP16P', 20),
('KHO-HN-01', 'SP-SAM-BUDS3', 80),
('KHO-HN-01', 'SP-LOGI-MX3S', 45),
('KHO-HN-01', 'SP-DELL-P24', 12),
('KHO-SG-01', 'SP-SAM-S24U', 15),
('KHO-SG-01', 'SP-APP-IP16P', 10);

-- 6. Nhà cung cấp & Khách hàng
INSERT INTO nha_cung_cap (ma_ncc, ten_ncc, dia_chi, dien_thoai, email, nguoi_dai_dien, trang_thai) VALUES
('NCC-SS-01', 'Công ty TNHH Samsung Electronics VN', 'KCN Yên Phong, Bắc Ninh', '0222-3869-999', 'contact@samsung.com.vn', 'Mr. Park', 'HOAT_DONG'),
('NCC-AP-01', 'Apple Vietnam LLC', 'Quận 1, TP.HCM', '028-3829-1111', 'b2b@apple.com', 'Ms. Lê Mai', 'HOAT_DONG');

INSERT INTO khach_hang (ma_kh, ten_kh, loai_kh, dia_chi, dien_thoai, email, ma_so_thue) VALUES
('KH-DN-088', 'Tập đoàn Công nghiệp - Viễn thông Quân đội (Viettel)', 'DOANH_NGHIEP', 'Lô D26 Khu đô thị mới Cầu Giấy, Hà Nội', '024-6255-6789', 'procurement@viettel.com.vn', '0100109106'),
('KH-CN-001', 'Hoàng Văn Cường', 'CA_NHAN', 'Đống Đa, Hà Nội', '0904123456', 'cuong.hv@gmail.com', NULL);

-- 7. Đơn mua hàng mẫu (PO)
INSERT INTO don_mua_hang (ma_don_mua, ma_ncc, ma_kho_nhan, ma_nv_tao, ma_nv_duyet, ngay_giao_du_kien, tong_gia_tri, trang_thai, ghi_chu) VALUES
('PO-2026-001', 'NCC-SS-01', 'KHO-HN-01', 'NV004', 'NV002', '2026-09-14', 750000000, 'DA_NHAN_HANG', 'Nhập đợt 1 tháng 9/2026');

INSERT INTO muc_mua_hang (ma_don_mua, ma_sp, so_luong, don_gia_mua, thanh_tien) VALUES
('PO-2026-001', 'SP-SAM-S24U', 20, 25000000, 500000000),
('PO-2026-001', 'SP-SAM-BUDS3', 50, 5000000, 250000000);

-- 8. Phiếu nhập kho mẫu
INSERT INTO phieu_nhap_kho (ma_phieu_nhap, ma_kho, ma_nv_nhap, ma_don_mua, ly_do_nhap, tong_gia_tri, ghi_chu, trang_thai) VALUES
('PNK-2026-101', 'KHO-HN-01', 'NV003', 'PO-2026-001', 'TU_NHA_CUNG_CAP', 750000000, 'Nhập đủ hàng theo PO-2026-001', 'DA_XAC_NHAN');

INSERT INTO muc_nhap_kho (ma_phieu_nhap, ma_sp, so_luong, don_gia_nhap, thanh_tien) VALUES
('PNK-2026-101', 'SP-SAM-S24U', 20, 25000000, 500000000),
('PNK-2026-101', 'SP-SAM-BUDS3', 50, 5000000, 250000000);

-- 9. Đơn bán hàng mẫu
INSERT INTO don_ban_hang (ma_don_ban, ma_kh, ma_kho_xuat, ma_nv_ban, tong_tien_hang, thue_vat, giam_gia, tong_thanh_toan, phuong_thuc_tt, trang_thai, ghi_chu) VALUES
('SO-2026-555', 'KH-DN-088', 'KHO-HN-01', 'NV005', 191940000, 19194000, 5000000, 206134000, 'CHUYEN_KHOAN_NGAN_HANG', 'DA_XAC_NHAN', 'Giao Viettel Cầu Giấy');

INSERT INTO muc_ban_hang (ma_don_ban, ma_sp, so_luong, don_gia_ban, thanh_tien) VALUES
('SO-2026-555', 'SP-SAM-S24U', 6, 31990000, 191940000);

-- 10. Phiếu xuất kho mẫu
INSERT INTO phieu_xuat_kho (ma_phieu_xuat, ma_kho, ma_nv_xuat, ma_don_ban, ly_do_xuat, tong_gia_tri, ghi_chu, trang_thai) VALUES
('PXK-2026-303', 'KHO-HN-01', 'NV003', 'SO-2026-555', 'BAN_HANG', 191940000, 'Xuất giao Viettel theo SO-2026-555', 'DA_XAC_NHAN');

INSERT INTO muc_xuat_kho (ma_phieu_xuat, ma_sp, so_luong_yeu_cau, so_luong_thuc_xuat, don_gia_xuat, thanh_tien) VALUES
('PXK-2026-303', 'SP-SAM-S24U', 6, 6, 31990000, 191940000);
