
use DivivuExpress
go

CREATE TABLE taiKhoan (
    taiKhoan_id INT IDENTITY(1,1) PRIMARY KEY,
    tenTaiKhoan VARCHAR(100) NOT NULL UNIQUE,
    matKhau VARCHAR(100) NOT NULL,
    tenHienThi NVARCHAR(100),
    type TINYINT NOT NULL DEFAULT 3 CHECK (type IN (0, 1, 2, 3))
);
--type 0: ADMIN, 1: Staff ,2: Driver, 3: khách hàng




CREATE TABLE Profile (
    profile_id INT IDENTITY(1,1) PRIMARY KEY,
    taiKhoan_id INT NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    soDienThoai VARCHAR(15) NOT NULL,
    diaChi VARCHAR(255),
    soDienThoaiKhanCap VARCHAR(15),
	-- Khóa ngoại
    FOREIGN KEY (taiKhoan_id) REFERENCES taiKhoan(taiKhoan_id) ON DELETE CASCADE
);




CREATE TABLE xeTai (
    xeTai_id INT IDENTITY(1,1) PRIMARY KEY,
    bienSoXe VARCHAR(20) NOT NULL,
    hangXe VARCHAR(50) NOT NULL,
    taiTrong DECIMAL(10,2) NOT NULL,
    trangThai TINYINT NOT NULL DEFAULT 0 CHECK (trangThai IN (0, 1, 2))
);
--type 0: Sẵn sàng, 1: Bận, 2: Bảo dưỡng




CREATE TABLE taiXe (
    taiXe_id INT IDENTITY(1,1) PRIMARY KEY,
    tenTaiXe VARCHAR(100) NOT NULL,
    soDienThoai VARCHAR(15) NOT NULL,
    soDienThoaiKhanCap VARCHAR(15),
    email VARCHAR(100) NOT NULL UNIQUE,
    trangThai TINYINT NOT NULL CHECK (trangThai IN (0, 1)),
    thoiDiemLamViecTruoc DATETIME
);






CREATE TABLE nhanVien (
    nhanVien_id INT IDENTITY(1,1) PRIMARY KEY,
    tenNhanVien VARCHAR(255) NOT NULL,
    soDienThoai VARCHAR(15) NOT NULL,
    soDienThoaiKhanCap VARCHAR(15),
    email VARCHAR(100) NOT NULL UNIQUE,
    diaChi VARCHAR(255),
    chucVu VARCHAR(50),  -- Ví dụ: tài xế, quản lý, nhân viên hỗ trợ
    trangThai TINYINT NOT NULL CHECK (trangThai IN (0, 1, 2)),  -- 1: Đang làm việc, 0: Không còn làm việc
    ngayBatDau DATE NOT NULL,
    taiKhoan_id INT,  -- FK nếu nhân viên có tài khoản, NULL nếu không có
    FOREIGN KEY (taiKhoan_id) REFERENCES taiKhoan(taiKhoan_id)
);






CREATE TABLE bookings (
    booking_id INT IDENTITY(1,1) PRIMARY KEY,
    xeTai_id INT NOT NULL,
    taiXe_id INT NOT NULL,
    khachHang_id INT NOT NULL,
    ngayDat DATE NOT NULL,
    ngayBatDau DATE NOT NULL,
    ngayKetThuc DATE NOT NULL,
    trangThai TINYINT NOT NULL DEFAULT 0 CHECK (trangThai IN (0, 1, 2, 3)), -- 0: Chờ xác nhận, 1: Đã xác nhận, 2: Đã hoàn thành, 3: Đã hủy
    nhanVien_id INT,
	-- Khóa ngoại
    FOREIGN KEY (xeTai_id) REFERENCES xeTai(xeTai_id),
    FOREIGN KEY (taiXe_id) REFERENCES taiXe(taiXe_id),
    FOREIGN KEY (khachHang_id) REFERENCES taiKhoan(taiKhoan_id),
    FOREIGN KEY (nhanVien_id) REFERENCES nhanVien(nhanVien_id)  -- Liên kết tới bảng nhanVien
);





CREATE TABLE chiTietBooking (
    chiTiet_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    diaDiem VARCHAR(255) NOT NULL,
    diemDen VARCHAR(255) NOT NULL,
    khoangCach FLOAT,  
    thoiGian FLOAT,    
	-- Khóa ngoại
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);




CREATE TABLE hoaDon (
    hoaDon_id INT IDENTITY(1,1) PRIMARY KEY,  -- Mã hóa đơn duy nhất
    booking_id INT NOT NULL,  -- Liên kết với bảng bookings
    soTien DECIMAL(10, 2),  -- Số tiền cần thanh toán
    ngayThanhToan DATE,  -- Ngày thanh toán (có thể để NULL nếu chưa thanh toán)
    phuongThuc VARCHAR(50),  -- Phương thức thanh toán (nếu có)
    trangThaiThanhToan TINYINT NOT NULL DEFAULT 0 CHECK (trangThaiThanhToan IN (0, 1, 2)),  -- Trạng thái thanh toán. 0: Chưa thanh toán, 1: Đã thanh toán, 2: Đã thanh toán 1 phần
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id)
);



CREATE TABLE phieuThu (
    phieuThu_id INT IDENTITY(1,1) PRIMARY KEY,
    ngayThu DATE NOT NULL,
    soTien DECIMAL(10, 2) NOT NULL,
    lyDo VARCHAR(255),
    nhanVien_id INT,
    hoaDon_id INT,  -- Liên kết với hóa đơn
    FOREIGN KEY (nhanVien_id) REFERENCES nhanVien(nhanVien_id),
    FOREIGN KEY (hoaDon_id) REFERENCES hoaDon(hoaDon_id)  -- Khóa ngoại liên kết với bảng hoaDon
);



CREATE TABLE phieuChi (
    phieuChi_id INT IDENTITY(1,1) PRIMARY KEY,
    ngayChi DATE NOT NULL,
    soTien DECIMAL(10, 2) NOT NULL,
    lyDo VARCHAR(255),
    nhanVien_id INT,
    FOREIGN KEY (nhanVien_id) REFERENCES nhanVien(nhanVien_id)
);



CREATE TABLE baoDuong (
    baoDuong_id INT IDENTITY(1,1) PRIMARY KEY,
    xeTai_id INT NOT NULL,
    ngayBaoDuong DATE NOT NULL,
    moTa VARCHAR(255),
    phieuChi_id INT NOT NULL,  -- Liên kết với phiếu chi
    nhanVien_id INT,  -- Nhân viên thực hiện bảo dưỡng
    FOREIGN KEY (xeTai_id) REFERENCES xeTai(xeTai_id),
    FOREIGN KEY (nhanVien_id) REFERENCES nhanVien(nhanVien_id),
    FOREIGN KEY (phieuChi_id) REFERENCES phieuChi(phieuChi_id)  -- Liên kết với bảng phieuChi
);



CREATE TABLE lichSuXe (
    lichSu_id INT IDENTITY(1,1) PRIMARY KEY,
    xeTai_id INT NOT NULL,
    taiXe_id INT NOT NULL,
    ngayBatDau DATE NOT NULL,
    ngayKetThuc DATE NOT NULL,
    quangDuong FLOAT,  -- Tổng quãng đường đã đi
    FOREIGN KEY (xeTai_id) REFERENCES xeTai(xeTai_id),
    FOREIGN KEY (taiXe_id) REFERENCES taiXe(taiXe_id)
);



CREATE TABLE banners (
  banner_id INT IDENTITY(1,1) PRIMARY KEY,  -- Tạo khóa chính với ID tự động tăng
  moTa TEXT NULL,  -- TEXT thay vì LONGTEXT
  tenBanner NVARCHAR(255) NULL,  -- NVARCHAR hỗ trợ Unicode
  trangThai TINYINT NOT NULL CHECK (trangThai IN (0, 1, 2, 3)),  -- 1: Đang hiển thị, 0: Không hiển thị
  image nvarchar(500) NULL,
  createdAt DATETIME NOT NULL DEFAULT GETDATE(),  -- Lấy ngày giờ hiện tại
  updatedAt DATETIME NOT NULL DEFAULT GETDATE(),  -- Tự động cập nhật ngày
);


CREATE TABLE News (
  news_id INT IDENTITY(1,1) PRIMARY KEY,  -- Mã tin tức tự động tăng
  tieuDe NVARCHAR(255) NOT NULL,  -- Tiêu đề tin tức
  noiDung TEXT NOT NULL,  -- Nội dung tin tức
  image NVARCHAR(500) NULL,  -- Đường dẫn hình ảnh minh họa
  trangThai TINYINT NOT NULL CHECK (trangThai IN (0, 1, 2, 3)),  -- Trạng thái tin tức (1: Đang hiển thị, 0: Không hiển thị)
  tacGia_id INT NOT NULL,  -- ID của tác giả (liên kết với bảng taiKhoan)
  createdAt DATETIME NOT NULL DEFAULT GETDATE(),  -- Ngày tạo tin tức
  updatedAt DATETIME NOT NULL DEFAULT GETDATE(),  -- Ngày cập nhật tin tức
  
  -- Khóa ngoại liên kết với bảng tác giả hoặc người dùng
  FOREIGN KEY (tacGia_id) REFERENCES taiKhoan(taiKhoan_id)
);


CREATE TABLE CuocTroChuyen (
  cuocTroChuyen_id INT IDENTITY(1,1) PRIMARY KEY,  -- Mã cuộc trò chuyện tự động tăng
  taiKhoan1_id INT NOT NULL,  -- Tài khoản người thứ nhất
  taiKhoan2_id INT NOT NULL,  -- Tài khoản người thứ hai
  ngayTao DATETIME NOT NULL DEFAULT GETDATE(),  -- Thời gian bắt đầu cuộc trò chuyện
  FOREIGN KEY (taiKhoan1_id) REFERENCES taiKhoan(taiKhoan_id),  -- Liên kết với bảng tài khoản
  FOREIGN KEY (taiKhoan2_id) REFERENCES taiKhoan(taiKhoan_id)   -- Liên kết với bảng tài khoản
);



CREATE TABLE TinNhan (
  tinNhan_id INT IDENTITY(1,1) PRIMARY KEY,  -- Mã tin nhắn tự động tăng
  cuocTroChuyen_id INT NOT NULL,  -- Mã cuộc trò chuyện
  nguoiGui_id INT NOT NULL,  -- Mã người gửi tin nhắn
  noiDung NVARCHAR(MAX) NOT NULL,  -- Nội dung tin nhắn
  ngayGui DATETIME NOT NULL DEFAULT GETDATE(),  -- Thời gian gửi tin nhắn
  FOREIGN KEY (cuocTroChuyen_id) REFERENCES CuocTroChuyen(cuocTroChuyen_id),  -- Liên kết với bảng cuộc trò chuyện
  FOREIGN KEY (nguoiGui_id) REFERENCES taiKhoan(taiKhoan_id)  -- Liên kết với bảng tài khoản
);

go

CREATE PROCEDURE sp_taKhoan_get_by_str
    @str NVARCHAR(100)
AS
BEGIN
    SELECT * 
    FROM taiKhoan
    WHERE 
        CAST(taiKhoan_id AS NVARCHAR(100)) = @str  -- Chuyển taiKhoan_id sang chuỗi để so sánh
        OR tenTaiKhoan = @str
        OR tenHienThi = @str
        OR CAST(type AS NVARCHAR(100)) = @str;
END;

go

CREATE PROCEDURE sp_get_all_taKhoan
AS
BEGIN
    SELECT * 
    FROM taiKhoan
END;

