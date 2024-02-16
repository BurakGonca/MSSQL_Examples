/*
-Komut ile bir tane veri tabaný oluþturunuz
-Bu veri tabanina komutla iliskisi olmaksizin 2 tane tablo olusturun
-Bu tablolara DML komutlari ile data maniplasyonu yapin
  -Veri ekleme,
  -Var olan verilere de güncelleme kosullu,
  -Var olan verilerde silme kosullu,
-Olusturdugunuz tablolardan biri ya da bir kaci icin DDL komutlarini tablo icin Alter, Drop islemlerini yapiniz
  -Kolon ekleme,
  -Var olan kolon tip degistirme,
  -Var olan kolon silinmesi/kaldirilmasi
-Olusturdugunuz tablolardan biri ya da bir kaci icin DDL komutlari tablo icin Drop ve Truncate islemlerini yapiniz
  -Tabloyu tamamen kaldirmak
  -tabloyu yenilemek

*/


CREATE DATABASE OGRENCIYONETIM

USE OGRENCIYONETIM

CREATE TABLE PROFILBILGILERI(

ID INT PRIMARY KEY IDENTITY,
OGRENCINO CHAR(8) NOT NULL,
ADI NVARCHAR(25) NOT NULL,
SOYADI NVARCHAR(25) NOT NULL,
SINIFDUZEYI CHAR(2) NOT NULL,
SUBE CHAR(1) NOT NULL,

)

CREATE TABLE AKADEMIKBILGILER(

OGRENCINO CHAR(8) NOT NULL,
ADI NVARCHAR(25) NOT NULL,
SOYADI NVARCHAR(25) NOT NULL,
DONEMORTALAMASI INT NULL,
OKUDUGUKITAPSAYISI INT NULL
)

SELECT * FROM AKADEMIKBILGILER
SELECT * FROM PROFILBILGILERI

INSERT INTO PROFILBILGILERI
VALUES('1266','Burak','Gonca','11','C')
GO


INSERT INTO PROFILBILGILERI
VALUES('1365','Ali','Veli','10','D')
GO


INSERT INTO PROFILBILGILERI
VALUES('2365','Ayse','Fatma','9','K')
GO

INSERT INTO AKADEMIKBILGILER
VALUES('1266','Burak','Gonca',78,Null)
GO

INSERT INTO AKADEMIKBILGILER
VALUES('1365','Ali','Veli',90,12)
GO

INSERT INTO AKADEMIKBILGILER
VALUES('2365','Ayse','Fatma',65,7)
GO

SELECT * FROM PROFILBILGILERI
SELECT * FROM AKADEMIKBILGILER


UPDATE PROFILBILGILERI
SET OGRENCINO = '1466',
    ADI = 'Ali',
    SOYADI = 'Velioglu',
	SINIFDUZEYI = '11',
	SUBE = 'K'
WHERE ID = 3


DELETE FROM dbo.PROFILBILGILERI
WHERE ID=3


INSERT INTO PROFILBILGILERI
VALUES('2365','Ayse','Fatma','9','K')
GO


ALTER TABLE AKADEMIKBILGILER ADD VERSIYON INT NOT NULL
GO