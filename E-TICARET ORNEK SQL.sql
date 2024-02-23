
--ORNEK SORU

-- E-TICARET

/*

bir sanal al��veri� sitesi i�in geli�tirilen veri taban�nda
�r�nler, kategoriler, tedarik�i firmalar, m��teriler ve sipari�ler varl�k k�melerini,
bu k�meler aras�ndaki ili�ki k�melerini (ili�ki t�rlerini de belirterek)
ve size g�re bu k�melerin sahip olmas� gerekli nitelikleri de g�sterecek �ekilde
varl�k ili�ki modeli �izelgesini olu�turunuz.

daha sonra sql server kodu kullanarak bu ili�kilere sahip tablolar� olu�turunuz.
bu tablolara 1 view ekleyin ve viewin i�eri�ini siz belirleyiniz.

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


-- M��teriler tablosu
CREATE TABLE Musteriler (
    MusteriID INT PRIMARY KEY,
    Ad NVARCHAR(50),
    Soyad NVARCHAR(50),
    Telefon NVARCHAR(15),
    Email NVARCHAR(100)
)
GO

-- M��teri bilgilerini i�eren view
CREATE VIEW MusteriBilgileri
AS
SELECT MusteriID, Ad, Soyad, Email
FROM Musteriler
GO

-- Sipari�ler tablosu
CREATE TABLE Siparisler (
    SiparisID INT PRIMARY KEY,
    MusteriID INT FOREIGN KEY REFERENCES Musteriler(MusteriID),
    SiparisTarihi DATE,
    TeslimTarihi DATE,
    ToplamTutar DECIMAL(10,2)
)
GO

-- �r�nler tablosu
CREATE TABLE Urunler (
    UrunID INT PRIMARY KEY,
    UrunAdi NVARCHAR(100),
    KategoriID INT FOREIGN KEY REFERENCES Kategoriler(KategoriID),
    TedarikciID INT FOREIGN KEY REFERENCES Tedarikciler(TedarikciID),
    Fiyat DECIMAL(10,2),
    StokMiktari INT
)
GO