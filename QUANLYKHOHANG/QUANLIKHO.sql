use master
go
if exists(select name from sysdatabases where name='QUANLYKHOHANG')
drop Database QUANLYKHOHANG
go
Create Database QUANLYKHOHANG
go
use QUANLYKHOHANG
go


/*==============================================================*/
/* Table: KHACH_HANG                                            */
/*==============================================================*/
create table KHACH_HANG 
(
   MAKH                char(10)                       not null,
   TEN_KH               nvarchar(50)                    null,
   DIACHI_KH            Nvarchar(50)                    null,
   GIOITINH_KH          Nvarchar(5)                    null,
   SDT_KH               VARCHAR(12)                        null,
   EMAIL_KH             varchar(50)                    null,
   FAX                  VARCHAR(12)                        null,
   constraint PK_KHACH_HANG primary key (MAKH)
)
go
/*==============================================================*/
/* Table: KHO_HANG                                              */
/*==============================================================*/
create table KHO_HANG 
(
   MAKHO                char(10)                       not null,
   TENKHO               NVARchar(50)                       null,
   DIACHI_KHO           NVARchar(50)                       null,
   GHICHU_KHO           NVARchar(50)                       null,
   constraint PK_KHO_HANG primary key (MAKHO)
)
go

/*==============================================================*/
/* Table: NHAN_VIEN                                             */
/*==============================================================*/
create table NHAN_VIEN 
(
   MANV                 char(10)                       not null,
   TEN_NV               nvarchar(50)                  null,
   EMAIL_NV             varchar(50)                   null,
   NGSINH_NV            date                           null,
   GIOITINH_NV          nvarchar(10)                    null,
   SDT_NV               VARCHAR(12)                        null,
   CHUCVU_NV            nvarchar(50)                    null,
   DIACHI_NV            nvarchar(50)                    null,
   LUONG_NV             FLOAT                        null,
   BOPHAN_NV            nvarchar(50)                    null,
   constraint PK_NHAN_VIEN primary key (MANV)
)
GO
/*==============================================================*/
/* Table: NHA_CUNG_CAP                                          */
/*==============================================================*/
create table NHA_CUNG_CAP 
(
   MA_NCC               char(10)                       not null,
   TEN_NCC              nvarchar(50)                    null,
   DIACHI_NCC           nvarchar(50)                    null,
   constraint PK_NHA_CUNG_CAP primary key (MA_NCC)
)
GO

/*==============================================================*/
/* Table: PHIEU_NHAP_HANG                                       */
/*==============================================================*/
create table PHIEU_NHAP_HANG 
(   
	MAPHIEU_NH           char(10)                       not null,
   NGAY_NH              date                           null,
   TONGSOLUONG_NH           INT                        null,
   TONGTIEN_NH          FLOAT                        null,
   MANV                 char(10)                       null,
   constraint PK_PHIEU_NHAP_HANG primary key (MAPHIEU_NH)
)
GO

/*==============================================================*/
/* Table: PHIEU_XUAT_HANG                                       */
/*==============================================================*/
create table PHIEU_XUAT_HANG 
(  
	MAPH_XH              char(10)                       not null,
   NGAY_XH              date                           null,
   TONGSOLUONG_XH           INT                        null,
   TONGTIEN_XH          FLOAT                        null,
   MAKH                 char(10)                       null,
   MANV                 char(10)                       null,
   constraint PK_PHIEU_XUAT_HANG primary key (MAPH_XH)
)
GO

------------------- LOAI --------------------
CREATE TABLE LOAISP
(	
	MALOAI CHAR(10),
	TENLOAI NVARCHAR(50),
	PRIMARY KEY(MALOAI)
)
GO
/*==============================================================*/
/* Table: SAN_PHAM                                              */
/*==============================================================*/
create table SAN_PHAM 
(
   MA_SP                char(10)                       not null,
   MA_NCC               char(10)                       null,
   TEN_SP               nvarchar(50)                    null,
   NGAYSX               date                           null,
   HSD                  date                           null,
   SOLUONG_SP           INT                        null,
	MALOAI CHAR(10),	
   GIA                  INT                        null,
   GHICHU_SP            nvarchar(50)                    null,
   MAKHO CHAR(10),
   ANH Image ,
   constraint PK_SAN_PHAM primary key (MA_SP)
)
GO
--- CHI TIET NHAP HANG -----------
CREATE TABLE CHITIET_NH
(
	MAPHIEU_NH CHAR(10),
	MA_SP CHAR(10),
	SOLUONG INT,
	THANHTIEN FLOAT,
	PRIMARY KEY(MAPHIEU_NH,MA_SP)
)
GO

--- CHI TIET XUAT HANG ---
CREATE TABLE CHITIET_XH
(
	MAPH_XH CHAR(10),
	MA_SP CHAR(10),
	SOLUONG INT,
	THANHTIEN FLOAT,
	PRIMARY KEY(MAPH_XH,MA_SP)
)
GO
---
CREATE TABLE TAI_KHOAN
(
	TK CHAR(10) NOT NULL,
	MK CHAR(15),
	EMAIL NVARCHAR(50),
	QUYEN CHAR(10),
	PRIMARY KEY(TK)
)
GO
---------------- CONSTRAINT ---------------
ALTER TABLE CHITIET_NH
ADD
	CONSTRAINT FK_CTNH_NH FOREIGN KEY(MAPHIEU_NH) REFERENCES PHIEU_NHAP_HANG(MAPHIEU_NH)
ALTER TABLE CHITIET_NH
ADD
	CONSTRAINT FK_CTNH_SP FOREIGN KEY(MA_SP) REFERENCES SAN_PHAM(MA_SP)

ALTER TABLE CHITIET_XH
ADD
	CONSTRAINT FK_CTXH_XH FOREIGN KEY(MAPH_XH) REFERENCES PHIEU_XUAT_HANG(MAPH_XH),
	CONSTRAINT FK_CTXH_SP FOREIGN KEY(MA_SP) REFERENCES SAN_PHAM(MA_SP)


alter table SAN_PHAM
add 
	constraint FK_SP_KHO foreign key (MAKHO) references KHO_HANG (MAKHO),
	constraint FK_SP_NCC foreign key (MA_NCC) references NHA_CUNG_CAP (MA_NCC),
	constraint FK_SP_LOAI foreign key (MALOAI) references LOAISP(MALOAI)

ALTER TABLE PHIEU_NHAP_HANG
ADD	
	constraint FK_NH_NV foreign key (MANV) references NHAN_VIEN (MANV)

alter table PHIEU_XUAT_HANG
   add constraint FK_XH_NV foreign key (MANV)
      references NHAN_VIEN (MANV)

ALTER TABLE PHIEU_XUAT_HANG
ADD CONSTRAINT FK_XH_KH FOREIGN KEY(MAKH) REFERENCES KHACH_HANG(MAKH)
---insert khach Hang
insert into KHACH_HANG
values ('KH001', N'NGUYỄN MINH TUẤN',N'CỦ CHI',N'NAM','0851478532','minhtuan@gmail.com','0001'),
	   ('KH002', N'TRẦN THANH NAM',N'GIA LAI',N'NAM','0857845522','thanhnam22@gmail.com','0002'),
	   ('KH003', N'VÕ THỊ HUỲNH NHƯ',N'TRÀ VINH',N'NỮ','085147652','vothihuynhnhu.22042002@gmail.com','0003'),
	   ('KH004', N'BÙI LÊ THANH NGÂN',N'SÓC TRĂNG',N'NỮ','082684852','thanhnqan@gmail.com','0004'),
	   ('KH005', N'TRẦN MẠNH CƯỜNG',N'ĐỒNG THÁP',N'NAM','085147741','manhcuongtran@gmail.com','0005'),
	   ('KH006', N'DƯƠNG QUANG DŨNG',N'NGHỆ AN',N'NAM','085165423','dungquangwd@gmail.com','0006'),
	   ('KH007', N'NGUYỄN LÊ THẢO AN',N'LẠNG SƠN',N'NỮ','085146742','anbabe@gmail.com','0007'),
	   ('KH008', N'ĐỖ TRÍ PHÚC',N'THÁI BÌNH',N'NAM','085147451','phucdo@gmail.com','0008'),
	   ('KH009', N'TRẦN TUẤN KHANH',N'PHÚ YÊN',N'NAM','08627852','khanhtran@gmail.com','0009'),
	   ('KH010', N'TẠ THANH TRÚC',N'KHÁNH HÒA',N'NỮ','085187452','threeti@gmail.com','0010')
select * from KHACH_HANG

insert into KHO_HANG
VALUES ('K01', N'KHO LONG XUYÊN',N'AN GIANG',N'Chỉ nhận nước uống đóng chai'),
	   ('K02', N'KHO BÀ RỊA',N'BÀ RỊA - VŨNG TÀU',N'Chỉ nhận các loại hải sản'),
	   ('K03', N'KHO BẠC LIÊU',N'BẠC LIÊU',N'Nhận các đồ dùng nội thất'),
	   ('K04', N'KHO BẮC GIANG',N'BẮC GIANG',N'Chỉ nhận sữa'),
	   ('K05', N'KHO BẾN TRE',N'BẾN TRE',N'Chỉ nhận sản phẩm mỹ nghệ làm từ dừa'),
	   ('K06', N'KHO THỦ DẦU MỘT',N'BÌNH DƯƠNG',N'Nhận tất cả trái cây tươi trừ vải thiều'),
	   ('K07', N'KHO QUY NHƠN',N'BÌNH ĐỊNH',N'Chỉ nhận tinh dầu thiên nhiên'),
	   ('K08', N'KHO ĐỒNG XOÀI',N'BÌNH PHƯỚC',N'Nhận các linh kiện điện tử'),
	   ('K09', N'KHO PHAN THIẾT',N'BÌNH THUẬN',N'Chỉ nhận mỹ phẩm'),
	   ('K10', N'KHO NINH KIỀU',N'CẦN THƠ',N'Chỉ nhận rau, củ, quả tươi')
	   SELECT * FROM KHO_HANG
insert into NHA_CUNG_CAP
values ('NCC01',N'CÔNG TY NHẬP KHẨU TRÁI CÂY V-FOOD VIỆT NAM',N'HÀ NỘI'),
	   ('NCC02',N'CÔNG TY CỔ PHẦN RAU QUẢ TIỀN GIANG',N'TIỀN GIANG'),
	   ('NCC03',N'CÔNG TY CỔ PHẦN HẢI SẢN ĐÔNG LẠNH',N'BÌNH DƯƠNG'),
	   ('NCC04',N'CÔNG TY TNHH SUNTORY PEPSICO VIỆT NAM',N'HỒ CHÍ MINH'),
	   ('NCC05',N'CÔNG TY TNHH HANDMADE VIỆT NAM',N'HỒ CHÍ MINH'),
	   ('NCC06',N'CÔNG TY MỸ PHẨM ORGANIC',N'HÀ NỘI'),
	   ('NCC07',N'CÔNG TY NỘI THẤT TRUNG ĐÔNG',N'ĐÀ NẴNG'),
	   ('NCC08',N'CÔNG TY TNHH ĐIỆN TỬ ABECO VIỆT NAM',N'HÀ NỘI'),
	   ('NCC09',N'CÔNG TY TNHH NESTLE VIỆT NAM',N'HỒ CHÍ MINH'),
	   ('NCC10',N'CÔNG TY CỔ PHẦN TINH DẦU AVAN',N'HẢI PHÒNG')
 SELECT * FROM NHA_CUNG_CAP
 SET DATEFORMAT DMY
INSERT INTO NHAN_VIEN
values ('NV01', N'TRẦN HOÀI PHONG', 'hoaiphong@gmail.com','29/01/2000',N'NAM',085963258,N'Nhân viên kiểm hàng',N'CẦN THƠ',3000000,N'KIỂM HÀNG'),
	   ('NV02', N'LƯƠNG MẠNH CƯỜNG', 'manhcuong@gmail.com','20/02/2000',N'NAM',084785625,N'Nhân viên kiểm hàng',N'SÓC TRĂNG',3000000,N'KIỂM HÀNG'),
	   ('NV03', N'TRẦN XUÂN NHI', 'nhicutegird@gmail.com','12/04/2000',N'NỮ',0854796823,N'Nhân viên nhập hàng',N'HỒ CHÍ MINH',2500000,N'NHẬP HÀNG'),
	   ('NV04', N'LÊ HOÀNG TIẾN', 'hoangtienle@gmail.com','23/06/2002',N'NAM',0853214569,N'Nhân viên nhập hàng',N'TIỀN GIANG',2500000,N'NHẬP HÀNG'),
	   ('NV05', N'TRẦN ĐỨC PHÚC', 'ducphuctran@gmail.com','15/07/2001',N'NAM',0857453298,N'Nhân viên nhập hàng',N'AN GIANG',2500000,N'NHẬP HÀNG'),
	   ('NV06', N'THÁI THANH ĐÀN', 'danthai@gmail.com','06/03/2001',N'NAM',0862457896,N'Nhân viên nhập hàng',N'BẾN NGHÉ',2500000,N'NHẬP HÀNG'),
	   ('NV07', N'NGUYỄN TRẦN TRUNG QUÂN', 'quantran@gmail.com','14/02/2001',N'NAM',0859683258,N'Nhân viên xuất hàng',N'CHÂU ĐỐC',2500000,N'XUẤT HÀNG'),
	   ('NV08', N'LÊ KIM PHỤNG', 'phungkim@gmail.com','23/01/2001',N'NỮ',0781246088,N'Nhân viên xuất hàng',N'KHÁNH HÒA',2500000,N'XUẤT HÀNG'),
	   ('NV09', N'PHẠM KHÁNH AN', 'khanhan@gmail.com','26/05/2002',N'NỮ',0915789111,N'Nhân viên xuất hàng',N'YÊN BÁI',2500000,N'XUẤT HÀNG'),
	   ('NV10', N'LƯU HÀ TRINH', 'trinhha@gmail.com','28/12/2001',N'NỮ',083628787,N'Nhân viên xuất hàng',N'ĐỒNG THÁP',2500000,N'XUẤT HÀNG')
select * from NHAN_VIEN
INSERT INTO TAI_KHOAN
VALUES ('TuanNguyen','123','tuannguyen@gmail.com','Admin'),
	   ('NamTran','4568','namtranu@gmail.com','Admin'),
	   ('NhuVo','7812','nhuvo@gmail.com','Admin'),
	   ('NqanBui','3534','nganbui@gmail.com','User'),
	   ('CuongManh','4352','manhcuong@gmail.com','User'),
	   ('DungQuang','2346','dungquang@gmail.com','User'),
	   ('AnThao','3462','anthao@gmail.com','User'),
	   ('PhucDo','2452','phucdo@gmail.com','User'),
	   ('KhanhTran','2546','khanhtran@gmail.com','User'),
	   ('TrucTa','2345','tructa@gmail.com','User')
select * from TAI_KHOAN



INSERT INTO LOAISP
VALUES  ('L01',N'HẢI SẢN'),
		('L02',N'TRÁI CÂY'),
		('L03',N'NƯỚC UỐNG ĐÓNG CHAI'),
		('L04',N'ĐỒ DÙNG THỦ CÔNG'),
		('L05',N'LINH KIỆN ĐIỆN TỬ'),
		('L06',N'MỸ PHẨM'),
		('L07',N'RAU, CỦ, QUẢ'),
		('L08',N'TINH DẦU THIÊN NHIÊN'),
		('L09',N'NỘI THẤT'),
		('L10',N'SỮA')
SELECT * FROM LOAISP

SET DATEFORMAT DMY
INSERT INTO PHIEU_NHAP_HANG
VALUES  ('PN001','06/06/2020','100',NULL,'NV03'),
		('PN002','22/08/2020','150',NULL,'NV04'),
		('PN003','13/05/2021','200',NULL,'NV05'),
		('PN004','19/07/2021','200',NULL,'NV06'),
		('PN005','30/11/2021','250',NULL,'NV03'),
		('PN006','02/01/2022','220',NULL,'NV04'),
		('PN007','10/03/2022','120',NULL,'NV05'),
		('PN008','15/04/2022','150',NULL,'NV06'),
		('PN009','20/05/2022','200',NULL,'NV03'),
		('PN010','28/07/2022','250',NULL,'NV06')
SELECT * FROM PHIEU_NHAP_HANG

SET DATEFORMAT DMY
INSERT INTO PHIEU_XUAT_HANG
VALUES  ('PX001','06/07/2020','50',NULL,'KH001','NV07'),
		('PX002','22/09/2020','75',NULL,'KH002','NV08'),
		('PX003','13/06/2021','100',NULL,'KH003','NV09'),
		('PX004','19/08/2021','100',NULL,'KH004','NV10'),
		('PX005','30/12/2021','125',NULL,'KH005','NV07'),
		('PX006','02/02/2022','110',NULL,'KH006','NV08'),
		('PX007','10/04/2022','60',NULL,'KH007','NV09'),
		('PX008','15/05/2022','75',NULL,'KH008','NV10'),
		('PX009','20/06/2022','100',NULL,'KH009','NV07'),
		('PX010','28/08/2022','125',NULL,'KH010','NV10')
SELECT * FROM PHIEU_XUAT_HANG

SET DATEFORMAT DMY
INSERT INTO SAN_PHAM
VALUES  ('SP001','NCC01',N'TÁO ĐỎ','22/10/2021','22/11/2021','100','L02',20000,N'Táo đỏ bảo quản lạnh','K06',NULL),
		('SP002','NCC02',N'BÍ NGÔ','02/01/2022','02/02/2022','100','L07',15000,N'Bí ngô 1 bao 10kg','K10',NULL),
		('SP003','NCC03',N'TÔM CÀNG XANH','10/05/2022','15/05/2022','100','L01',300000,N'Tôm càng xanh loại 1','K02',NULL),
		('SP004','NCC04',N'STING','03/06/2022','03/06/2023','200','L03',10000,N'Sting đỏ 1 thùng 24 chai','K01',NULL),
		('SP005','NCC05',N'BỘ ẤM TRÀ','11/10/2022','11/10/2028','50','L04',39000,N'Bộ ấm trà làm thủ công từ dừa','K05',NULL),
		('SP006','NCC06',N'SON MERZY','15/06/2022','15/06/2023','300','L06',199000,N'Son dạng thỏi','K09',NULL),
		('SP007','NCC07',N'GƯƠNG TREO TƯỜNG','22/12/2020','22/12/2030','150','L09',59000,N'Gương có cảm biến đèn led','K03',NULL),
		('SP008','NCC08',N'BÀN PHÍM MÁY TÍNH','07/09/2022','07/09/2025','250','L05',279000,N'Bàn phím có 6 chế độ chuyển màu đèn led','K08',NULL),
		('SP009','NCC09',N'SỮA MILO','18/09/2022','18/09/2023','100','L10',159000,N'Thùng 24 lốc','K04',NULL),
		('SP010','NCC10',N'TINH DẦU SẢ CHANH','04/06/2022','04/06/2024','200','L08',150000,N'Tinh dầu nguyên chất thiên nhiên','K07',NULL)

SELECT * FROM SAN_PHAM
INSERT INTO CHITIET_NH
VALUES  ('PN001','SP001','100',NULL),
		('PN002','SP002','120',NULL),
		('PN003','SP003','150',NULL),
		('PN004','SP004','150',NULL),
		('PN005','SP005','100',NULL),
		('PN006','SP006','100',NULL),
		('PN007','SP007','200',NULL),
		('PN008','SP008','250',NULL),
		('PN009','SP009','220',NULL),
		('PN010','SP010','100',NULL)
select * from CHITIET_NH

INSERT INTO CHITIET_XH
VALUES  ('PX001','SP001','50',NULL),
		('PX002','SP002','60',NULL),
		('PX003','SP003','75',NULL),
		('PX004','SP004','75',NULL),
		('PX005','SP005','50',NULL),
		('PX006','SP006','50',NULL),
		('PX007','SP007','100',NULL),
		('PX008','SP008','125',NULL),
		('PX009','SP009','110',NULL),
		('PX010','SP010','50',NULL)
SELECT * FROM CHITIET_XH
select * from CHITIET_NH
select * from CHITIET_XH
