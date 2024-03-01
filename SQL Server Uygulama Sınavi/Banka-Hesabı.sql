create database BankaDB
go

use BankaDB
go


create table Musteriler (
MusteriID int primary key identity,
MusteriNo int not null,
MusteriAd nvarchar(50) not null,
MusteriSoyAd nvarchar(50) not null
)
go


create table Subeler (
SubeID int primary key identity,
SubeNo int not null,
SubeAd nvarchar(30) not null,
)
go


create table Hesaplar (
HesapID int primary key identity,
HesapNo int not null,
MusteriID int not null,
SubeID int not null,
HesapKodu int not null,
HesapAdi nvarchar(50) not null,
foreign  key (MusteriID) references Musteriler(MusteriID),
foreign  key (SubeID) references Subeler(SubeID)
)
go


create table IslemTurleri (
IslemTuruID int primary key identity,
IslemTuru nvarchar (50) not null
)
go


create table IslemYerleri (
IslemYeriID int primary key identity,
IslemYeri nvarchar(50) not null
)
go



create table ParaTurleri (
ParaTuruID int primary key identity,
ParaTuru nvarchar(50) not null
)
go



create table Islemler (
IslemID int primary key identity,
IslemNo int not null,
HesapID int not null ,
IslemYeriID int not null,
IslemTutari decimal(10,2) not null,
ParaTuruID int not null,
IslemTuruID int not null,
Tarih date not null,
foreign  key (HesapID) references Hesaplar(HesapID),
foreign  key (IslemYeriID) references IslemYerleri(IslemYeriID),
foreign  key (ParaTuruID) references ParaTurleri(ParaTuruID),
foreign  key (IslemTuruID) references IslemTurleri(IslemTuruID)
)
go


-- Musteriler tablosuna veri ekleme
insert into Musteriler (MusteriNo, MusteriAd, MusteriSoyAd)
values
(100, 'Ali', 'Kara'),
(101, 'Ayse', 'Sari')
go


-- Subeler tablosuna veri ekleme
insert into Subeler (SubeNo, SubeAd)
values
(74, 'Bartin'),
(67, 'Zonguldak'),
(78, 'Karabuk')
go


-- Hesaplar tablosuna veri ekleme
insert into Hesaplar (HesapNo, MusteriID, SubeID, HesapKodu, HesapAdi)
values
(7410010, 1, 1, 10, 'TL Hesabi'),
(6710011, 1, 2, 11, 'Euro Hesabi'),
(7810112, 2, 3, 12, 'USD Hesabi'),
(7410110, 2, 1, 10, 'TL Hesabi')
go

-- Islem Turleri veri ekleme
insert into IslemTurleri(IslemTuru)
values
('Para Yatirma'),
('Para Cekme'),
('Fatura Odeme')
go

-- Islem Yerleri veri ekleme
insert into IslemYerleri(IslemYeri)
values
('ATM'),
('Internet'),
('Sube')
go


-- Para Turleri veri ekleme
insert into ParaTurleri(ParaTuru)
values
('TL'),
('Euro'),
('USD')
go


-- Islemler veri ekleme
insert into Islemler(IslemNo,HesapID,IslemYeriID,IslemTutari,ParaTuruID,IslemTuruID,Tarih)
values
(100001,1,1,400,1,1,'2024-01-02'),
(100002,1,1,200,1,2,'2024-01-25'),
(100003,1,2,89,1,3,'2024-01-20'),
(100025,2,3,200,2,1,'2024-01-15'),
(100058,3,1,100,3,2,'2024-02-02'),
(101005,4,3,200,1,1,'2024-01-20'),
(101048,4,2,115,1,3,'2024-01-20')
go

select * from Islemler


create view vw_HesapIslemleri as
select 
h.HesapNo [Hesap No],
m.MusteriNo [Müþteri No],
m.MusteriAd + ' ' + m.MusteriSoyAd [Müþteri],
s.SubeNo [Þube No],
s.SubeAd  [Þube],
h.HesapKodu  [Hesap Kodu],
h.HesapAdi  [Hesap],
i.IslemNo  [Ýþlem No],
iy.IslemYeri  [Ýþlem Yeri],
i.IslemTutari  [Ýþlem Tutarý],
pt.ParaTuru  [Para Türü],
it.IslemTuru  [Ýþlem Türü],
i.Tarih  [Tarih]
from Islemler i
join Hesaplar h on i.HesapID = h.HesapID
join Musteriler m on h.MusteriID = m.MusteriID
join Subeler s on h.SubeID = s.SubeID
join IslemYerleri iy on i.IslemYeriID = iy.IslemYeriID
join ParaTurleri pt on i.ParaTuruID = pt.ParaTuruID
join IslemTurleri it on i.IslemTuruID = it.IslemTuruID



select * from vw_HesapIslemleri





