USE GONCACOMPANY
GO


--URUNLER TABLOSUNDA STOGUNA GORE URUNUN TOPLAM FIYATI 1000 BR UZERINDE OLAN SIPARISI DURDURULMUS, 
--URUN TEDARIKCISI UK,SPAIN,GERMANY OLANLARIN TOPLAM URUN ADETINI VEREN SORGU

SELECT (P.UnitPrice * P.UnitsInStock) FROM DBO.Products AS P
JOIN dbo.Suppliers AS S ON S.SupplierID=P.SupplierID
WHERE P.Discontinued = 1
AND (P.UnitPrice*P.UnitsInStock) > 1000
AND S.Country IN ('UK','Spain','Germany')


use mytestDB
select * from Faturalar --faturalar view


-- view kurma

--create view [viewIsmý] as .... //ilgili sql sorgularý

--ornek UrunKategori
create view UrunKategori as
select u.UrunAdi,k.KategoriAdi from Urunler as u inner join Kategoriler as k on u.KategoriID=k.KategoriID

select * from UrunKategori


--personellerin ad soyad ve yas bilgileri icin bir view

CREATE VIEW PersonelBilgisi AS
SELECT p.Adi,p.Soyadi,YEAR(GETDATE()) - YEAR(p.DogumTarihi) AS Yas
FROM Personeller AS p;
GO

select *  from PersonelBilgisi



--urun ismi ile birlikte hangi üründen kaç adet satýlmýþtýr view ile göster

CREATE VIEW SatilanUrunAdetleri AS
SELECT sd.UrunAdi, COUNT(sd.UrunID) AS SatilanAdet
FROM [Satis Detaylari] JOIN Urunler as sd ON sd.UrunID = Urunler.UrunID
GROUP BY Urunler.UrunAdi;

select * from SatilanUrunAdetleri




-----------------------------------------------------------

create database fkTest
go
USE fkTest


CREATE TABLE Kategori (
kategoriID int PRIMARY KEY,
kategoriAdi nvarchar(30) NOT NULL
)
GO

CREATE TABLE Blog (
blogID int  PRIMARY KEY IDENTITY(200,3),
content varchar(300) NOT NULL,
FK_KID int default -1,
CONSTRAINT FK_BLOG_KATEGORI_n1  FOREIGN KEY(FK_KID) REFERENCES Kategori(kategoriID)
ON DELETE SET DEFAULT
ON UPDATE CASCADE
)
GO

--ornek ekleyelim

insert  Kategori values (-1,'Belirtilmemis Kategori')







