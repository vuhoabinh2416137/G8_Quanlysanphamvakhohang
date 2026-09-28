-- =============================================================================
-- SCHEMA CSDL (DDL) - warehouse_db
-- Hệ thống Quản lý Kho hàng và Vật tư Nội bộ Tổ chức (IT3120 - BTL OOSAD)
-- Phạm vi: Quản lý vật tư, Nhập/Xuất kho nội bộ, Yêu cầu cấp phát, Kiểm kê, Phòng ban
-- Lưu ý: Quản lý phục vụ nội bộ tổ chức - HOÀN TOÀN KHÔNG CÓ NGHIỆP VỤ MUA BÁN THƯƠNG MẠI
-- =============================================================================

-- Xoá cơ sở dữ liệu cũ (nếu có) và khởi tạo
DROP DATABASE IF EXISTS warehouse_db;
CREATE DATABASE warehouse_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE warehouse_db;

-- 1. Bảng Danh mục vật tư (Phân cấp đệ quy)
CREATE TABLE danh_muc (
    ma_danh_muc VARCHAR(30) PRIMARY KEY,
    ten_danh_muc VARCHAR(150) NOT NULL,
    mo_ta TEXT,
    ma_danh_muc_cha VARCHAR(30),
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_danhmuc_cha FOREIGN KEY (ma_danh_muc_cha) REFERENCES danh_muc(ma_danh_muc)
);

-- 2. Bảng Vật tư / Thiết bị (Không có giá mua thương mại)
CREATE TABLE san_pham (
    ma_sp VARCHAR(30) PRIMARY KEY,
    ten_sp VARCHAR(255) NOT NULL,
    don_vi_tinh VARCHAR(30) NOT NULL,
    quy_cach TEXT,
    nguong_ton_kho INT NOT NULL DEFAULT 10,
    hinh_anh_url VARCHAR(500),
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'DANG_SU_DUNG',
    ma_danh_muc VARCHAR(30),
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_sp_danhmuc FOREIGN KEY (ma_danh_muc) REFERENCES danh_muc(ma_danh_muc)
);

-- 3. Bảng Phòng ban / Đơn vị nội bộ
CREATE TABLE phong_ban (
    ma_phong_ban VARCHAR(30) PRIMARY KEY,
    ten_phong_ban VARCHAR(150) NOT NULL,
    dien_thoai VARCHAR(20),
    dia_diem VARCHAR(255),
    mo_ta TEXT,
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'HOAT_DONG'
);

-- 4. Bảng Nhân viên
CREATE TABLE nhan_vien (
    ma_nv VARCHAR(30) PRIMARY KEY,
    ho_ten VARCHAR(100) NOT NULL,
    ngay_sinh DATE,
    gioi_tinh VARCHAR(10),
    dia_chi VARCHAR(255),
    dien_thoai VARCHAR(20) NOT NULL,
    email VARCHAR(100) NOT NULL,
    chuc_vu VARCHAR(50) NOT NULL,
    ma_phong_ban VARCHAR(30),
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'DANG_LAM_VIEC',
    ngay_vao_lam TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_nv_phongban FOREIGN KEY (ma_phong_ban) REFERENCES phong_ban(ma_phong_ban)
);

-- 5. Bảng Tài khoản, Vai trò, Quyền (RBAC)
CREATE TABLE tai_khoan (
    ten_dang_nhap VARCHAR(50) PRIMARY KEY,
    mat_khau_hash VARCHAR(255) NOT NULL,
    ma_nv VARCHAR(30) NOT NULL UNIQUE,
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'HOAT_DONG',
    lan_dang_nhap_cuoi TIMESTAMP,
    CONSTRAINT fk_tk_nv FOREIGN KEY (ma_nv) REFERENCES nhan_vien(ma_nv)
);

CREATE TABLE vai_tro (
    ma_vai_tro VARCHAR(30) PRIMARY KEY,
    ten_vai_tro VARCHAR(100) NOT NULL,
    mo_ta VARCHAR(255)
);

CREATE TABLE tai_khoan_vai_tro (
    ten_dang_nhap VARCHAR(50) NOT NULL,
    ma_vai_tro VARCHAR(30) NOT NULL,
    PRIMARY KEY (ten_dang_nhap, ma_vai_tro),
    CONSTRAINT fk_tkvt_tk FOREIGN KEY (ten_dang_nhap) REFERENCES tai_khoan(ten_dang_nhap),
    CONSTRAINT fk_tkvt_vt FOREIGN KEY (ma_vai_tro) REFERENCES vai_tro(ma_vai_tro)
);

-- 6. Bảng Kho & Vị trí kho
CREATE TABLE kho (
    ma_kho VARCHAR(30) PRIMARY KEY,
    ten_kho VARCHAR(150) NOT NULL,
    dia_chi VARCHAR(255) NOT NULL,
    so_dien_thoai VARCHAR(20),
    ma_quan_ly VARCHAR(30),
    ngay_tao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_kho_quanly FOREIGN KEY (ma_quan_ly) REFERENCES nhan_vien(ma_nv)
);

CREATE TABLE vi_tri_kho (
    ma_vi_tri VARCHAR(30) PRIMARY KEY,
    ma_kho VARCHAR(30) NOT NULL,
    khu_vuc VARCHAR(50) NOT NULL,
    ke VARCHAR(50) NOT NULL,
    tang VARCHAR(50) NOT NULL,
    CONSTRAINT fk_vitri_kho FOREIGN KEY (ma_kho) REFERENCES kho(ma_kho) ON DELETE CASCADE
);

-- 7. Bảng Tồn kho (Ánh xạ Nhiều-Nhiều giữa Kho và Vật tư)
CREATE TABLE ton_kho (
    ma_kho VARCHAR(30) NOT NULL,
    ma_sp VARCHAR(30) NOT NULL,
    so_luong INT NOT NULL DEFAULT 0,
    ngay_cap_nhat TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (ma_kho, ma_sp),
    CONSTRAINT fk_tonkho_kho FOREIGN KEY (ma_kho) REFERENCES kho(ma_kho),
    CONSTRAINT fk_tonkho_sanpham FOREIGN KEY (ma_sp) REFERENCES san_pham(ma_sp)
);

-- 8. Bảng Phiếu yêu cầu cấp phát vật tư nội bộ
CREATE TABLE yeu_cau_cap_phat (
    ma_yeu_cau VARCHAR(30) PRIMARY KEY,
    ma_phong_ban VARCHAR(30) NOT NULL,
    ma_nv_yeu_cau VARCHAR(30) NOT NULL,
    ma_nv_duyet VARCHAR(30),
    ngay_yeu_cau TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_duyet TIMESTAMP NULL,
    muc_dich_su_dung VARCHAR(255) NOT NULL,
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'CHO_DUYET',
    ly_do_tu_choi TEXT,
    ghi_chu TEXT,
    CONSTRAINT fk_yccp_phongban FOREIGN KEY (ma_phong_ban) REFERENCES phong_ban(ma_phong_ban),
    CONSTRAINT fk_yccp_nvyeucau FOREIGN KEY (ma_nv_yeu_cau) REFERENCES nhan_vien(ma_nv),
    CONSTRAINT fk_yccp_nvduyet FOREIGN KEY (ma_nv_duyet) REFERENCES nhan_vien(ma_nv)
);

-- 9. Bảng Chi tiết yêu cầu cấp phát
CREATE TABLE chi_tiet_yeu_cau (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ma_yeu_cau VARCHAR(30) NOT NULL,
    ma_sp VARCHAR(30) NOT NULL,
    so_luong_yeu_cau INT NOT NULL,
    so_luong_duyet INT DEFAULT 0,
    ghi_chu TEXT,
    CONSTRAINT fk_ctyc_yeucau FOREIGN KEY (ma_yeu_cau) REFERENCES yeu_cau_cap_phat(ma_yeu_cau) ON DELETE CASCADE,
    CONSTRAINT fk_ctyc_sp FOREIGN KEY (ma_sp) REFERENCES san_pham(ma_sp)
);

-- 10. Bảng Phiếu nhập kho nội bộ & Chi tiết
CREATE TABLE phieu_nhap_kho (
    ma_phieu_nhap VARCHAR(30) PRIMARY KEY,
    ma_kho VARCHAR(30) NOT NULL,
    ma_nv_nhap VARCHAR(30) NOT NULL,
    ly_do_nhap VARCHAR(50) NOT NULL,
    ma_phong_ban_giao VARCHAR(30),
    ngay_nhap TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ghi_chu TEXT,
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'DA_XAC_NHAN',
    CONSTRAINT fk_pnk_kho FOREIGN KEY (ma_kho) REFERENCES kho(ma_kho),
    CONSTRAINT fk_pnk_nv FOREIGN KEY (ma_nv_nhap) REFERENCES nhan_vien(ma_nv),
    CONSTRAINT fk_pnk_pbgiao FOREIGN KEY (ma_phong_ban_giao) REFERENCES phong_ban(ma_phong_ban)
);

CREATE TABLE muc_nhap_kho (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ma_phieu_nhap VARCHAR(30) NOT NULL,
    ma_sp VARCHAR(30) NOT NULL,
    so_luong INT NOT NULL,
    ma_vi_tri VARCHAR(30),
    ghi_chu TEXT,
    CONSTRAINT fk_muc_pnk_phieu FOREIGN KEY (ma_phieu_nhap) REFERENCES phieu_nhap_kho(ma_phieu_nhap) ON DELETE CASCADE,
    CONSTRAINT fk_muc_pnk_sp FOREIGN KEY (ma_sp) REFERENCES san_pham(ma_sp),
    CONSTRAINT fk_muc_pnk_vitri FOREIGN KEY (ma_vi_tri) REFERENCES vi_tri_kho(ma_vi_tri)
);

-- 11. Bảng Phiếu xuất kho nội bộ & Chi tiết (Cấp phát phòng ban, Chuyển kho, Hủy/thanh lý, Cân đối kiểm kê)
CREATE TABLE phieu_xuat_kho (
    ma_phieu_xuat VARCHAR(30) PRIMARY KEY,
    ma_kho VARCHAR(30) NOT NULL,
    ma_nv_xuat VARCHAR(30) NOT NULL,
    ma_yeu_cau VARCHAR(30),
    ma_phong_ban_nhan VARCHAR(30),
    ma_kho_nhan VARCHAR(30),
    ly_do_xuat VARCHAR(50) NOT NULL,
    ngay_xuat TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ghi_chu TEXT,
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'DA_XAC_NHAN',
    CONSTRAINT fk_pxk_kho FOREIGN KEY (ma_kho) REFERENCES kho(ma_kho),
    CONSTRAINT fk_pxk_nv FOREIGN KEY (ma_nv_xuat) REFERENCES nhan_vien(ma_nv),
    CONSTRAINT fk_pxk_yeucau FOREIGN KEY (ma_yeu_cau) REFERENCES yeu_cau_cap_phat(ma_yeu_cau),
    CONSTRAINT fk_pxk_pbnhan FOREIGN KEY (ma_phong_ban_nhan) REFERENCES phong_ban(ma_phong_ban),
    CONSTRAINT fk_pxk_khonhan FOREIGN KEY (ma_kho_nhan) REFERENCES kho(ma_kho)
);

CREATE TABLE muc_xuat_kho (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ma_phieu_xuat VARCHAR(30) NOT NULL,
    ma_sp VARCHAR(30) NOT NULL,
    so_luong_yeu_cau INT NOT NULL,
    so_luong_thuc_xuat INT NOT NULL,
    ghi_chu TEXT,
    CONSTRAINT fk_muc_pxk_phieu FOREIGN KEY (ma_phieu_xuat) REFERENCES phieu_xuat_kho(ma_phieu_xuat) ON DELETE CASCADE,
    CONSTRAINT fk_muc_pxk_sp FOREIGN KEY (ma_sp) REFERENCES san_pham(ma_sp)
);

-- 12. Bảng Kiểm kê kho
CREATE TABLE phien_kiem_ke (
    ma_phien VARCHAR(30) PRIMARY KEY,
    ma_kho VARCHAR(30) NOT NULL,
    ma_nv_kiem_ke VARCHAR(30) NOT NULL,
    ngay_bat_dau TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ngay_hoan_tat TIMESTAMP NULL,
    pham_vi VARCHAR(100),
    trang_thai VARCHAR(30) NOT NULL DEFAULT 'DANG_THUC_HIEN',
    ghi_chu TEXT,
    CONSTRAINT fk_pkk_kho FOREIGN KEY (ma_kho) REFERENCES kho(ma_kho),
    CONSTRAINT fk_pkk_nv FOREIGN KEY (ma_nv_kiem_ke) REFERENCES nhan_vien(ma_nv)
);

CREATE TABLE muc_kiem_ke (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ma_phien VARCHAR(30) NOT NULL,
    ma_sp VARCHAR(30) NOT NULL,
    so_luong_so_sach INT NOT NULL,
    so_luong_thuc_te INT NOT NULL,
    chenh_lech INT NOT NULL,
    ly_do_chenh_lech TEXT,
    CONSTRAINT fk_muc_pkk_phien FOREIGN KEY (ma_phien) REFERENCES phien_kiem_ke(ma_phien) ON DELETE CASCADE,
    CONSTRAINT fk_muc_pkk_sp FOREIGN KEY (ma_sp) REFERENCES san_pham(ma_sp)
);

-- =============================================================================
-- CHỈ MỤC TỐI ƯU HOÁ TRUY VẤN (INDEXES)
-- =============================================================================
CREATE INDEX idx_sanpham_danhmuc ON san_pham(ma_danh_muc);
CREATE INDEX idx_sanpham_trangthai ON san_pham(trang_thai);
CREATE INDEX idx_tonkho_soluong ON ton_kho(so_luong);
CREATE INDEX idx_yeucau_trangthai ON yeu_cau_cap_phat(trang_thai);
CREATE INDEX idx_yeucau_phongban ON yeu_cau_cap_phat(ma_phong_ban);
CREATE INDEX idx_pnk_ngaynhap ON phieu_nhap_kho(ngay_nhap);
CREATE INDEX idx_pxk_ngayxuat ON phieu_xuat_kho(ngay_xuat);
CREATE INDEX idx_pxk_phongban ON phieu_xuat_kho(ma_phong_ban_nhan);