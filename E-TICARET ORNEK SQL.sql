
--ORNEK SORU

-- E-TICARET

/*

bir sanal alýþveriþ sitesi için geliþtirilen veri tabanýnda
ürünler, kategoriler, tedarikçi firmalar, müþteriler ve sipariþler varlýk kümelerini,
bu kümeler arasýndaki iliþki kümelerini (iliþki türlerini de belirterek)
ve size göre bu kümelerin sahip olmasý gerekli nitelikleri de gösterecek þekilde
varlýk iliþki modeli çizelgesini oluþturunuz.

daha sonra sql server kodu kullanarak bu iliþkilere sahip tablolarý oluþturunuz.
bu tablolara 1 view ekleyin ve viewin içeriðini siz belirleyiniz.

*/

Create Database ETICARETDB
Go

Use ETICARETDB

-- Kategoriler tablosu
CREATE TABLE Kategoriler (
    KategoriID INT PRIMARY KEY,
    KategoriAdi NVARCHAR(50)
)
GO

-- Tedarikciler tablosu
CREATE TABLE Tedarikciler (
    TedarikciID INT PRIMARY KEY,
    TedarikciAdi NVARCHAR(100),
    Telefon NVARCHAR(15),
    Adres NVARCHAR(200)
)
GO


-- Müþteriler tablosu
CREATE TABLE Musteriler (
    MusteriID INT PRIMARY KEY,
    Ad NVARCHAR(50),
    Soyad NVARCHAR(50),
    Telefon NVARCHAR(15),
    Email NVARCHAR(100)
)
GO

-- Müþteri bilgilerini içeren view
CREATE VIEW MusteriBilgileri
AS
SELECT MusteriID, Ad, Soyad, Email
FROM Musteriler
GO

-- Sipariþler tablosu
CREATE TABLE Siparisler (
    SiparisID INT PRIMARY KEY,
    MusteriID INT FOREIGN KEY REFERENCES Musteriler(MusteriID),
    SiparisTarihi DATE,
    TeslimTarihi DATE,
    ToplamTutar DECIMAL(10,2)
)
GO

-- Ürünler tablosu
CREATE TABLE Urunler (
    UrunID INT PRIMARY KEY,
    UrunAdi NVARCHAR(100),
    KategoriID INT FOREIGN KEY REFERENCES Kategoriler(KategoriID),
    TedarikciID INT FOREIGN KEY REFERENCES Tedarikciler(TedarikciID),
    Fiyat DECIMAL(10,2),
    StokMiktari INT
)
GO