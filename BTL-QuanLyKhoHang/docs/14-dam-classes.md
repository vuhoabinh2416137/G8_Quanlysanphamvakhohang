# 14 - Thiết kế Các Lớp Truy cập Dữ liệu (Data Access Management - DAM / DAO)

## Cơ sở Thiết kế và Mẫu kiến trúc

Theo giáo trình **IT3120 - Thiết kế Lưu trữ Cố định (ThietKeLuuTruCoDinh)** và mã nguồn mẫu của bộ môn (`demo/dam` và `demo/dao`):
- **Lớp DAM (Data Access Management)**:
  - Đóng gói toàn bộ câu lệnh SQL và logic tương tác JDBC (Java Database Connectivity) với hệ CSDL bên dưới.
  - Ngăn ngừa việc mã nguồn nghiệp vụ (Service / Domain) bị phụ thuộc vào câu lệnh SQL hoặc cú pháp riêng của từng hệ quản trị CSDL.
  - Sử dụng cơ chế truyền `DataSource` vào hàm khởi tạo (Constructor Injection) nhằm tối ưu hóa việc tái sử dụng kết nối (Connection Pooling).
  - Sử dụng Java 8+ `Stream<T>` và `Spliterator` để đọc dữ liệu dạng luồng mượt mà, tự động đóng kết nối thông qua phương thức `onClose()` và `mutedClose()`.

---

## Cấu trúc Lớp DAM Cơ sở (`AbstractDAM<T, ID>`)

```java
public abstract class AbstractDAM<T, ID> {
    protected final DataSource dataSource;

    public AbstractDAM(DataSource dataSource) {
        this.dataSource = dataSource;
    }

    protected Connection getConnection() throws SQLException {
        return dataSource.getConnection();
    }

    protected void mutedClose(Connection c, Statement s, ResultSet r) {
        try { if (r != null) r.close(); } catch (SQLException ignored) {}
        try { if (s != null) s.close(); } catch (SQLException ignored) {}
        try { if (c != null) c.close(); } catch (SQLException ignored) {}
    }

    public abstract Stream<T> getAll() throws Exception;
    public abstract Optional<T> getById(ID id) throws Exception;
    public abstract boolean add(T entity) throws Exception;
    public abstract boolean update(T entity) throws Exception;
    public abstract boolean delete(T entity) throws Exception;
    protected abstract T createEntity(ResultSet rs) throws SQLException;
}
```

---

## Minh họa Cài đặt Thực tế: `SanPhamDAM`

Lớp `SanPhamDAM` quản lý lưu trữ cho thực thể `SanPham`:

```java
public class SanPhamDAM extends AbstractDAM<SanPham, String> {

    public SanPhamDAM(DataSource dataSource) {
        super(dataSource);
    }

    @Override
    public Stream<SanPham> getAll() throws Exception {
        Connection conn = getConnection();
        PreparedStatement stmt = conn.prepareStatement("SELECT * FROM san_pham");
        ResultSet rs = stmt.executeQuery();
        return StreamSupport.stream(new Spliterators.AbstractSpliterator<SanPham>(Long.MAX_VALUE, Spliterator.ORDERED) {
            @Override
            public boolean tryAdvance(Consumer<? super SanPham> action) {
                try {
                    if (!rs.next()) return false;
                    action.accept(createEntity(rs));
                    return true;
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
            }
        }, false).onClose(() -> mutedClose(conn, stmt, rs));
    }

    @Override
    public Optional<SanPham> getById(String maSP) throws Exception {
        String sql = "SELECT * FROM san_pham WHERE ma_sp = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, maSP);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return Optional.of(createEntity(rs));
                }
            }
        }
        return Optional.empty();
    }

    @Override
    public boolean add(SanPham sp) throws Exception {
        String sql = "INSERT INTO san_pham (ma_sp, ten_sp, don_vi_tinh, gia_nhap_chuan, gia_ban_niem_yet, nguong_ton_kho, hinh_anh_url, trang_thai, ma_danh_muc) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sp.getMaSP());
            stmt.setString(2, sp.getTenSP());
            stmt.setString(3, sp.getDonViTinh());
            stmt.setDouble(4, sp.getGiaNhap());
            stmt.setDouble(5, sp.getGiaBan());
            stmt.setInt(6, sp.getNguongTonKho());
            stmt.setString(7, sp.getHinhAnh());
            stmt.setString(8, sp.getTrangThai().name());
            stmt.setString(9, sp.getMaDanhMuc());
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean update(SanPham sp) throws Exception {
        String sql = "UPDATE san_pham SET ten_sp=?, don_vi_tinh=?, gia_nhap_chuan=?, gia_ban_niem_yet=?, nguong_ton_kho=?, trang_thai=? WHERE ma_sp=?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sp.getTenSP());
            stmt.setString(2, sp.getDonViTinh());
            stmt.setDouble(3, sp.getGiaNhap());
            stmt.setDouble(4, sp.getGiaBan());
            stmt.setInt(5, sp.getNguongTonKho());
            stmt.setString(6, sp.getTrangThai().name());
            stmt.setString(7, sp.getMaSP());
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    public boolean delete(SanPham sp) throws Exception {
        String sql = "DELETE FROM san_pham WHERE ma_sp = ?";
        try (Connection conn = getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, sp.getMaSP());
            return stmt.executeUpdate() > 0;
        }
    }

    @Override
    protected SanPham createEntity(ResultSet rs) throws SQLException {
        SanPham sp = new SanPham();
        sp.setMaSP(rs.getString("ma_sp"));
        sp.setTenSP(rs.getString("ten_sp"));
        sp.setDonViTinh(rs.getString("don_vi_tinh"));
        sp.setGiaNhap(rs.getDouble("gia_nhap_chuan"));
        sp.setGiaBan(rs.getDouble("gia_ban_niem_yet"));
        sp.setNguongTonKho(rs.getInt("nguong_ton_kho"));
        sp.setHinhAnh(rs.getString("hinh_anh_url"));
        sp.setTrangThai(TrangThaiSP.valueOf(rs.getString("trang_thai")));
        return sp;
    }
}
```

---

## Quản lý Giao dịch (Transaction Management) trong `PhieuNhapKhoDAM`

Đối với các thực thể có quan hệ Hợp thành mạnh (`Composition`) như `PhieuNhapKho` và `MucNhap`, lớp DAM kích hoạt Transaction (`setAutoCommit(false)`) để đảm bảo tính trọn vẹn:

```java
public boolean savePhieuNhapVaChiTiet(PhieuNhapKho pnk) throws Exception {
    Connection conn = getConnection();
    try {
        conn.setAutoCommit(false); // Bắt đầu Transaction
        
        // 1. Thêm bản ghi cha: phieu_nhap_kho
        insertPhieuNhapHeader(pnk, conn);

        // 2. Thêm các bản ghi con: muc_nhap_kho
        for (MucNhap mn : pnk.getDsMucNhap()) {
            insertMucNhapDetail(pnk.getMaPhieu(), mn, conn);
        }

        conn.commit(); // Thành công -> Commit
        return true;
    } catch (Exception e) {
        conn.rollback(); // Lỗi -> Rollback
        throw e;
    } finally {
        conn.setAutoCommit(true);
        conn.close();
    }
}
```

---

## File nguồn PlantUML
Sơ đồ PlantUML hoàn chỉnh: [dam-classes.puml](../plantuml/dam-classes.puml).
Render đồ họa:
```bash
java -jar plantuml.jar plantuml/dam-classes.puml -o ../diagrams/
```
