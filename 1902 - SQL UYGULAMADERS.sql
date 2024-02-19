create database TestDB
use TestDB

create table Test2(
 id int primary key identity(1,1),
 isim nvarchar(30) not null,
 cinsiyet nvarchar(10),
 yas int,
 soyad nvarchar(40) default 'bilinmiyor',
 KayýtZamani date default getdate(),
 constraint YasveCinsiyetKontrol check (yas >=18 and cinsiyet='Erkek')
)
 
 select  * from Test2

 insert Test2(isim,yas,cinsiyet)
 values ('Burak',33,'Erkek')


 create table Product(
  id int primary key identity(100,1),
  UrunAdi nvarchar(40) not null,
  CIDFK int foreign key references Category(CID)
  )

  create table Category(
 CID int primary key identity(1,1),
 KatehgoriAdi nvarchar(40) not null
 )

 select * from Product

 insert Category values ('c1')
 insert Product values ('p1',1)

 select * from Category

 select KatehgoriAdi from Category where CID = (select p.CIDFK from Product as p where p.id = 101)

 ----------------------------------------

use Northwind

select sum (u.HedefStokDuzeyi) from Urunler as u where (u.KategoriID =1)
go



select * from Kategoriler


--Beverages kategorisindeki KategoriID donder, Urunler icindeki UrunID donder.
--Beverages kategorisindeki Satis Detaylari.
select * from [Satis Detaylari] where UrunID in
(select  UrunID from Urunler where KategoriID =
(select KategoriID from Kategoriler where KategoriAdi = 'Beverages'))



--Beverages kategorisindeki urun satmis personellerin isimleri tablosu
select Adi from  Personeller where PersonelID not in
(select distinct s.MusteriID from Satislar as s where s.SatisID in
(select sd.SatisID from [Satis Detaylari] as sd where sd.UrunID in
(select UrunID from Urunler where KategoriID=
(select KategoriID from Kategoriler where KategoriAdi = 'Bevegares'))))

select * from Kategoriler

 ----------------------------------------



use TestDB

create table Personel(
 id int primary key identity (1,1),
 adi nvarchar(25)
 )

 -- foreign key referans verme
 create table PersonelDetay(
  PersonelFK int unique not null,
  bilgi nvarchar(30),
  constraint Personel_PersonelDetay_FK foreign key (PersonelFK) references Personel(id)
  )
  go

  select * from PersonelDetay




  --bir ogretmen bir sinifa giriyor,
  --bir sinifta birden cok ogrenci olabilir,
  --her ogrencinin tek bir sinifi vardir,

  --bu bilgilere gore ogrenci, sinif, ogretmen tablolarini iliskileri ile birlikte kurunuz.


create database OkulDB


use  OkulDB
go

create table Ogretmen(
ogretmenID int primary key identity(1,1),
ad nvarchar(20) not null,
soyad nvarchar(20) not null,
brans nvarchar(20) not null
)
go

create table Ogrenci(
ogrenciID int primary key identity (1,1),
ad nvarchar(20) not null,
soyad nvarchar(20) not null,
okuduguKitapSayisi int,
SinifFK int,
constraint fk_ogrenci_sinif_1_n foreign key (SinifFK) references Sinif (sinifId)
)
go

create table Sinif(
sinifId int unique not null,
ad nvarchar(20)
constraint fk_Ogretmen_Sinif_1_1 foreign key (sinifID) references Ogretmen(ogretmenID)
)
go

select * from Sinif
select * from Ogrenci
select * from Ogretmen


insert Sinif 
values(1,'Derslik1')

insert Ogretmen (ad,soyad,brans)
values('Burak','Gonca','Matematik')

insert Ogrenci (ad,soyad,SinifFK)
values('Ogrenci1','Soyad1',1)

insert Ogrenci (ad,soyad,SinifFK)
values('Ogrenci2','Soyad2',2)

insert Ogrenci (ad,soyad,SinifFK)
values('Ogrenci3','Soyad3',1)
