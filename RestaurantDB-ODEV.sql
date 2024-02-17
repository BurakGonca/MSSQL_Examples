CREATE DATABASE RESTAURANTDB
go

use RESTAURANTDB

CREATE TABLE CALISANLAR (
  ADI nvarchar(25) NOT NULL,
  SOYADI nvarchar(25) NOT NULL,
  DOGUMTARIHI date NOT NULL,
  GOREVI nvarchar(50) NOT NULL,
  OLUSTURMAZAMANI datetime NOT NULL default GETDATE(),
  DUZENLEMEZAMANI datetime NULL,
  VERSIYON int NOT NULL,
  DURUMU bit NOT NULL --( 1 aktif, 0 pasif)
)

CREATE TABLE GOREVLER(
  ADI nvarchar(25) NOT NULL,
  ACIKLAMA nvarchar(100) NULL,
  OLUSTURMAZAMANI datetime NOT NULL default GETDATE(),
  DUZENLEMEZAMANI datetime NULL,
  VERSIYON int NOT NULL,
  DURUMU bit NOT NULL --(1 aktif, 0 pasif)
)

CREATE TABLE URUNLER(
  ADI nvarchar(25) NOT NULL,
  KATEGORIADI nvarchar(25) NOT NULL,
  ACIKLAMA nvarchar(100) NULL,
  MIKTAR decimal(7,2) NOT NULL, --(virgülden sonra 2 hassasiyetli)
  MIKTARTIPI nvarchar(10) NOT NULL,
  OLUSTURMAZAMANI datetime NOT NULL default GETDATE(),
  DUZENLEMEZAMANI datetime NULL,
  VERSIYON int NOT NULL,
  DURUMU bit NOT NULL --(1 aktif, 0 pasif)
)

CREATE TABLE MENU(
  ADI nvarchar(25) NOT NULL,
  KATEGORIADI nvarchar(25) NOT NULL,
  ACIKLAMA nvarchar(100) NULL,
  KALORISI int NOT NULL,
  SERVISSURESI int NOT NULL,
  FIYATI decimal(10,2) NOT NULL,
  OLUSTURMAZAMANI datetime NOT NULL default GETDATE(),
  DUZENLEMEZAMANI datetime NULL,
  VERSIYON int NOT NULL,
  DURUMU bit NOT NULL --(1 aktif, 0 pasif)
)

CREATE TABLE RECETETABLOSU(
  ADI nvarchar(25) NOT NULL,
  URUNADI nvarchar(25) NOT NULL,
  MIKTAR decimal(7,2) NOT NULL, --(virgülden sonra 2 hassasiyetli)
  MIKTARTIPI nvarchar(10) NOT NULL,
  OLUSTURMAZAMANI datetime NOT NULL default GETDATE(),
  DUZENLEMEZAMANI datetime NULL,
  VERSIYON int NOT NULL,
  DURUMU bit NOT NULL --(1 aktif, 0 pasif)
)

-- calisanlar tablosuna veri ekleme
insert into CALISANLAR (ADI,SOYADI,DOGUMTARIHI,GOREVI,VERSIYON,DURUMU)
values('Calisan1','Soyadi1','1997-02-17','Garson',25,0)

insert into CALISANLAR (ADI,SOYADI,DOGUMTARIHI,GOREVI,VERSIYON,DURUMU)
values('Calisan2','Soyadi2','1979-03-30','Asci',12,1)

insert into CALISANLAR (ADI,SOYADI,DOGUMTARIHI,GOREVI,VERSIYON,DURUMU)
values('Calisan3','Soyadi3','1982-06-25','Komi',4,0)

insert into CALISANLAR (ADI,SOYADI,DOGUMTARIHI,GOREVI,VERSIYON,DURUMU)
values('Calisan4','Soyadi4','2001-12-05','Kasiyer',1,1)

insert into CALISANLAR (ADI,SOYADI,DOGUMTARIHI,GOREVI,VERSIYON,DURUMU)
values('Calisan5','Soyadi5','1956-09-28','Garson',18,1)

select * from CALISANLAR

-- gorevler tablosuna veri ekleme
insert into GOREVLER(ADI,ACIKLAMA,VERSIYON,DURUMU)
values ('Asci','Yemek pisirir',12,0)

insert into GOREVLER(ADI,ACIKLAMA,VERSIYON,DURUMU)
values ('Garson',NULL,5,1)

insert into GOREVLER(ADI,ACIKLAMA,VERSIYON,DURUMU)
values ('Komi','Garsona yardim eder',3,0)

insert into GOREVLER (ADI,ACIKLAMA,VERSIYON,DURUMU)
values ('Kasiyer','Kasa islemleri yapar',7,1)

select * from GOREVLER

-- urunler tablosuna veri ekleme
insert into URUNLER(ADI,KATEGORIADI,ACIKLAMA,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Adana','Kebap','Acili bir kebap cesididir',250.50,'Gram',12,1)

insert into URUNLER(ADI,KATEGORIADI,ACIKLAMA,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Urfa','Kebap',NULL,250,'Gram',11,0)

insert into URUNLER(ADI,KATEGORIADI,ACIKLAMA,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Izgara Tavuk','Beyaz Et','Tavuk pirzoladan yapilir',300.80,'Gram',4,0)

insert into URUNLER(ADI,KATEGORIADI,ACIKLAMA,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Patlýcanli Kebap','Kebap','Patlican ve kiymanin muhtesem uyumu ',350,'Gram',14,0)

insert into URUNLER(ADI,KATEGORIADI,ACIKLAMA,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Cay','Icecek',NULL,3,'Adet',7,0)

insert into URUNLER(ADI,KATEGORIADI,ACIKLAMA,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Karisik Kebap','Kebap','Tüm kebap cesitleri karistirilir',475.50,'Gram',3,1)

select * from URUNLER

-- menu tablosuna veri ekleme
insert into MENU(ADI,KATEGORIADI,ACIKLAMA,KALORISI,SERVISSURESI,FIYATI,VERSIYON,DURUMU)
values ('Izgara Tavuk','Beyaz Et','Tavuk pirzoladan yapilir',300,15,200,12,0)

insert into MENU(ADI,KATEGORIADI,ACIKLAMA,KALORISI,SERVISSURESI,FIYATI,VERSIYON,DURUMU)
values ('Adana Kebap','Kirmizi Et',NULL,400,20,350,9,1)

insert into MENU(ADI,KATEGORIADI,ACIKLAMA,KALORISI,SERVISSURESI,FIYATI,VERSIYON,DURUMU)
values ('Izgara Levrek','Beyaz Et','Olta Levreginden Yapilir',350,17,450,1,0)

insert into MENU(ADI,KATEGORIADI,ACIKLAMA,KALORISI,SERVISSURESI,FIYATI,VERSIYON,DURUMU)
values ('Misket Kofte','Sulu Yemek',NULL,250,30,250,3,0)

insert into MENU(ADI,KATEGORIADI,ACIKLAMA,KALORISI,SERVISSURESI,FIYATI,VERSIYON,DURUMU)
values ('Türk Kahvesi','Sicak Icecek','Kumda Türk Kahvesi Ikrami',50,7,0,8,1)

insert into MENU(ADI,KATEGORIADI,ACIKLAMA,KALORISI,SERVISSURESI,FIYATI,VERSIYON,DURUMU)
values ('Ayran','Soguk Icecek',NULL,30,3,70,11,0)

insert into MENU(ADI,KATEGORIADI,ACIKLAMA,KALORISI,SERVISSURESI,FIYATI,VERSIYON,DURUMU)
values ('Karisik Kebap','Ana Yemek','Tüm kebap cesitleri karistirilir',500,45,600,6,1)

select * from MENU


-- recete tablosuna veri ekleme
insert into RECETETABLOSU(ADI,URUNADI,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Izgara Levrek','Balik',3,'adet',2,0)

insert into RECETETABLOSU(ADI,URUNADI,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Türk Kahvesi','Kahve',7,'adet',8,1)

insert into RECETETABLOSU(ADI,URUNADI,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Adana Kebap','Kebap',350.80,'gram',12,0)

insert into RECETETABLOSU(ADI,URUNADI,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Patlicanli Kebap','KEbap',750.4,'gram',8,1)

insert into RECETETABLOSU(ADI,URUNADI,MIKTAR,MIKTARTIPI,VERSIYON,DURUMU)
values ('Ayran','Sutas',7,'adet',1,1)

select * from RECETETABLOSU