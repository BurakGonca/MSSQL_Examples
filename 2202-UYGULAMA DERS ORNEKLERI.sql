USE Northwind
GO

SELECT YEAR(GETDATE()) -- SUAN KI YILI VERIR
SELECT MONTH(GETDATE()) --SUAN KI AYI VERIR

SELECT ISDATE('12.2.2022') --TRUE ANLAMINDA 1 DONDURUR

SELECT RAND() -- RANDOM DEGER VERIR - (0,1 ARALIGINDA)

SELECT RAND()*10 --RANDOM OLARAK (0,10 ARALIGINDA VERIR)

SELECT FLOOR(RAND()*10) -- ASAGI YUVARLAR

SELECT LEN(P.Adi),Adi FROM Personeller AS P -- PERSONELLERIN ADLARINDAKI HARF SAYISI

SELECT Adi FROM Personeller AS P WHERE LEN(P.Adi)>6

SELECT CONCAT(Adi , ' ' , SoyAdi) [PERSONEL] FROM Personeller --AD SOYAD BILGISINI DONDURUR

SELECT SUBSTRING(Adi,1,3) FROM Personeller --ADLARIN 1,2,3. HARFINI DONDURUR



--1 no lu PERSONELIN YAPTIGI SATISLARDAN SEVK ADRESLERININ UZUNLUGU 20'DEN BUYUK OLAN SATISLARIN SATIS ADRESLERINI - SEVK ADINI - PERSONEL ADINI YAZDIRIN

SELECT S.SevkAdi, P.Adi, P.PersonelID, S.SevkAdresi   FROM Satislar AS S JOIN Personeller AS P
ON S.PersonelID=P.PersonelID
WHERE LEN(S.SevkAdresi)>20 AND P.PersonelID =1


SELECT FLOOR(SQRT(65)) --KAREKOKU ASAGI YUVARLADI


-- 2 NO'LU PERSONELIN YAPMIS OLDUGU SATISLARDAN TEK TEK ELDE ETTIGI KAZANCLARIN KARE KOKUNUN KUPUNU
-- SATIS ID VE PERSONEL ISMI ILE EKRANA YAZDIR

SELECT POWER(SQRT((SD.Miktar*SD.BirimFiyati)), 3) [KAZANC] , S.SatisID , P.Adi FROM Satislar AS S
JOIN Personeller AS P ON S.PersonelID = P.PersonelID
JOIN [Satis Detaylari] AS SD ON S.SatisID = SD.SatisID
WHERE  P.PersonelID=2


SELECT * FROM [Satis Detaylari]


-- HANGI KATEGORIDEN KAC ADET URUN VAR , KATEGORI ID , URUN ADET OLACAK SEKILDE YAZDIR

SELECT U.KategoriID , COUNT(*) FROM Urunler AS U
GROUP BY U.KategoriID


--FAKS NUMARASI NULL OLMAYAN TEDARIKCILERDEN ALINMIS URUNLER NELERDIR

SELECT U.UrunAdi, T.TedarikciID, T.Faks FROM Urunler AS U
INNER JOIN Tedarikciler AS T ON U.TedarikciID =T.TedarikciID
WHERE T.Faks IS NOT NULL


-- 1997 YILINDAN SONRA NANCY'NIN SATIS YAPTIGI FIRMALARIN ISIMLERI NELERDIR

SELECT M.MusteriAdi FROM Musteriler AS M
INNER JOIN Satislar AS S ON M.MusteriID = S.MusteriID
INNER JOIN Personeller AS P ON P.PersonelID = S.PersonelID
WHERE P.Adi = 'Nancy' AND YEAR(S.SatisTarihi)>1997



-- LTD OLAN SIRKETLERDE ALINMIS SEAFOOD KATEGORISINDEKI URUNLERIN TOPLAM SATIS TUTARI GOSTER
SELECT SUM(U.BirimFiyati*U.HedefStokDuzeyi) FROM Urunler AS U
INNER JOIN Tedarikciler AS T ON U.TedarikciID=T.TedarikciID
INNER JOIN Kategoriler AS K ON K.KategoriID = U.KategoriID
WHERE T.SirketAdi LIKE '%Ltd%' AND K.KategoriAdi ='SeafOod' 



-- HANGI PERSONEL ( AD SOYAD ILE BIRLIKTE ) TOPLAM KAC ADETLIK SATIS YAPMISTIR
--  SATIS ADETI>100 VE PERSONELIN ISMININ BAS HARFI M OLANLARI LISTELEYINIZ

SELECT CONCAT(P.Adi , ' ' , P.SoyAdi) [PERSONEL] , COUNT(*) FROM Personeller AS P
INNER JOIN Satislar AS S ON P.PersonelID=S.PersonelID
WHERE P.Adi LIKE 'M%'
GROUP BY CONCAT(P.Adi , ' ' , P.SoyAdi)
HAVING COUNT(*)>100




-- EN COK SATIS YAPAN PERSONELIN ADI

select top(1) p.Adi +' '+ p.SoyAdi, count(*) as c from Personeller as p 
inner join Satislar as s on p.PersonelID=s.PersonelID 
group by p.Adi +' '+ p.SoyAdi
order by c DESC


-------------------------------------------------------------------------------



USE Northwind
GO

SELECT * FROM URUNLER

SELECT SUM(HedefStokDuzeyi) FROM Urunler -- URUNLER STOK TOPLAMI
SELECT COUNT(*) FROM Urunler WHERE KategoriID=1 --KATEGORISI 1 OLAN KAC ADET URUNUMUZ VAR
SELECT AVG(HedefStokDuzeyi) FROM Urunler WHERE	KategoriID=1 -- KATEGORISI 1 OLAN URUNLERIN ADET ORTALAMASI

SELECT MIN(HedefStokDuzeyi) FROM Urunler WHERE KategoriID=1
SELECT MAX(HedefStokDuzeyi) FROM Urunler WHERE KategoriID=1

SELECT MAX(BirimFiyati*Miktar) FROM [Satis Detaylari] AS SD -- EN YUKSEK CIROLU SATIS
SELECT MIN(BirimFiyati*Miktar) FROM [Satis Detaylari] AS SD -- EN DUSUK CIROLU SATIS


SELECT U.UrunAdi , K.KategoriAdi FROM Urunler AS U INNER JOIN Kategoriler AS K ON U.KategoriID = K.KategoriID

SELECT U.UrunAdi , K.KategoriAdi FROM Urunler AS U INNER JOIN Kategoriler AS K ON U.KategoriID = K.KategoriID
WHERE K.KategoriAdi = 'Produce'




--URUNADI - TEDARIKCIADI - TEDARIKCI TEL NO- KATEGORIADI - BILGILERINI GETIR
SELECT U.UrunAdi , K.KategoriAdi, T.SirketAdi, T.Telefon FROM Urunler AS U
INNER JOIN Kategoriler AS K ON U.KategoriID = K.KategoriID
INNER JOIN Tedarikciler AS T ON U.TedarikciID = T.TedarikciID


SELECT * FROM Personeller

--PERSONELADI - AMIRADI(BAGLICALISTIGIKISI) BILGILERI GETIR

SELECT CALISAN.Adi[PERSONEL], US.Adi [AMIR] FROM Personeller AS CALISAN
INNER JOIN Personeller AS US ON CALISAN.BagliCalistigiKisi = US.PersonelID


-- EN UST DUZEY YONETICI - BAGLI CALISTIGI KISI YOK
SELECT * FROM Personeller WHERE BagliCalistigiKisi IS NULL


--BOLGE VE BOLGEDE BULUNAN SEHIR ADLARINI GETIR
SELECT B.BolgeTanimi,BO.TerritoryTanimi  FROM Bolge AS B
INNER JOIN Bolgeler AS BO ON B.BolgeID = BO.BolgeID


-- HANGI KATEGORIDE KAC ADET URUN (HEDEFSTOKDUZEYI) VAR GETIR
SELECT COUNT(*), U.KategoriID FROM Urunler AS U GROUP BY KategoriID


-- PERSONELLERIN YAPMIS OLDUGU SATIS ADETLERINI GOSTER - PERSONELID VE PERSONELSATISTOPLAMI
SELECT PersonelID [PERSONEL] ,COUNT(*) [SATISTOPLAMI] FROM Satislar GROUP BY PersonelID


-- PERSONELLERIN YAPMIS OLDUGU SATIS ADETLERINI GOSTER - PERSONELAD VE PERSONELSATISTOPLAMI
SELECT P.Adi [ADI] ,COUNT(*) [SATISTOPLAMI] FROM Personeller AS P
INNER JOIN Satislar AS SD ON SD.PersonelID = P.PersonelID
GROUP BY P.Adi
GO

--PERSONEL ID SI 5'TEN BUYUK OLAN PERSONELLERIN SATIS ADETLERI GOSTER - PERSONEL VE PERSONELSATIS TOPLAMI
SELECT P.Adi [ADI] ,COUNT(*) [SATISTOPLAMI] FROM Personeller AS P
INNER JOIN Satislar AS SD ON SD.PersonelID = P.PersonelID WHERE P.PersonelID>5
GROUP BY P.Adi
GO

--PERSONEL ID SI 5'TEN BUYUK OLAN PERSONELLERIN SATIS ADETLERI GOSTER - PERSONEL VE PERSONELSATIS TOPLAMI
-- SATIS TOPLAMI 50'DEN BUYUK OLANLAR
SELECT P.Adi [ADI] ,COUNT(*) [SATISTOPLAMI] FROM Personeller AS P
INNER JOIN Satislar AS SD ON SD.PersonelID = P.PersonelID WHERE P.PersonelID>5
GROUP BY P.Adi
HAVING COUNT(*) >50  --HAVING GROUP BY'DAN SONRA YAZILIR, WHERE ONCE YAZILIR
GO




--KATEGORI ADI VE URUN ADETLERINI GOSTER
-- SART > KATEGORI �d >5 VE O KATEGORIDEKI URUN ADET BILGISI>10 OLANLARI GOSTERINIZ
SELECT K.KategoriAdi [KATEGORI] ,COUNT(*) [URUNADET] FROM Kategoriler AS K
INNER JOIN Urunler AS U ON K.KategoriID = U.KategoriID WHERE K.KategoriID>5
GROUP BY K.KategoriAdi
HAVING COUNT(*) >10  
GO








