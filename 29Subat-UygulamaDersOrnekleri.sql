--29subat uygulama ders ornekleri

--gorev1: employees tablosunda yasadigi sehirler null olmayan calisanlarin ad, soyad ve gorevlerini listeleyen bir SP yazip, kullaniniz.
create procedure SehriNullOlmayan
as
begin
select e.FirstName, e.LastName, e.Title from Employees as e
where e.City is not null
end
 

 --kullanma
 exec SehriNullOlmayan



--gorev2: t�m kategori isimleriyle, bu kategorilere ait olan urunlerin adlar�n�
--listeleyen bir SP yazip kullaniniz.
create procedure KategoriUrunListe
as
begin
select c.CategoryName, p.ProductName from Categories as c
inner join Products as p on p.CategoryID=c.CategoryID
end


--kullanimi
exec KategoriUrunListe


--gorev3: kategori ID'sini parametre olarak alan ve kategori ID'si bu ID'ye esit olan urunlerin adlar�n� ve kategorilerini listeleyen bir SP yazip kullan�n�n�z.
create procedure sp_ParametreKategoriUrunListele(
@categori int
)
as
begin
select c.CategoryName, p.ProductName from Categories as c
inner join Products as p on p.CategoryID=c.CategoryID
where @categori=c.CategoryID
end

--kullanimi
exec sp_ParametreKategoriUrunListele 5




--gorev4: 2adet parametre alan bir SP yazin. Bir parametresi categoriID, di�eri ise productID olsun.
--Bu SP, categoriID'si parametre olarak gonderilen kategoriID'ye esit olan, pruductID'si de parametre olarak gonderilen productID'den buyuk olan urunlerin
--urunID, urunAd ve categori adlar�n� listeleyiniz. Bu SP'yi kullaniniz.
create procedure KategoriUrun2Parametreli(
@categoriID int,
@productID int
)
as
begin
select p.ProductID, p.ProductName, c.CategoryName from Categories as c
inner join Products as p on p.CategoryID=c.CategoryID
where @categoriID=c.CategoryID
and p.ProductID>@productID
end

--kullanimi
exec KategoriUrun2Parametreli 1,5


--gorev5: view nedir, kisaca yaziniz
--sorgumuzu kayit alt�na almak icin kullaniriz.


--gorev6: TerritoryDescription'�nda "san"  gecenlerin TerriortyDescription, RegionDescription'larini listeleyen bir view olusturup cagiriniz.
create view vw_TD_SANGecenler
as
select * from Territories as t
where t.TerritoryDescription like '%SAN%'

--kullanimi
select * from vw_TD_SANGecenler


--gorev7: Union ve UnionAll nedir? Aralarindaki fark nedir? bir ornekle gosteriniz.

--birden fazla sonu� k�mesini birle�tirmemiz gerekti�inde UNION veya UNION ALL i�lemleri kullan�l�r.

--UNION ALL ifadesinin UNION ifadesinden fark�, UNION ALL ile tekrarl� kay�tlar filtrelenmez. 

select 


--G�REV8: Index nedir? K�saca a��klay�n�z.
 --Indeks, verilerin indeksleme alan�na g�re s�ralanm�� ve tablo halini alm�� �eklidir. 


--G�REV9: Candidate key ile super key nedir? Farklar� nedir?
--bir sat�r� ay�rabilen t�m anahtarlar�n birle�imi super key k�mesi ve bu k�menin her bir elaman� super keydir.
--Candidate key demek primary key olabilecek bir key demektir.
--Primary key �zelli�ini sa�layan s�t�n veya s�tunlar�n olu�turdu�u k�me candidate key k�mesidir.



--G�REV10: Parametre olarak 3 adet say� alan ve bunlar�n toplam�n� yazan SP yaz�n�z.
create procedure UC_Parametreli_ToplamBul(
@sayi1 int,
@sayi2 int,
@sayi3 int
)
as
begin
declare @sonuc int
set @sonuc=(@sayi1+@sayi2+@sayi3)
print @sonuc
end

--kullanimi
exec UC_Parametreli_ToplamBul 5,10,15


--G�REV11: Parametre olarak 3 adet say� alan ve bunlar�n ortalamas�n� yazan SP yaz�n�z.
create procedure UC_Parametreli_OrtalamaBul(
@sayi1 int,
@sayi2 int,
@sayi3 int
)
as
begin
declare @sonuc int
set @sonuc=(@sayi1+@sayi2+@sayi3)/3
print @sonuc
end

--kullanimi
exec UC_Parametreli_OrtalamaBul 5,10,15


--G�REV12: A�a��daki sorguyu yaz�p �al��t�r�n�z. Having ile where'in kullan�ld��� yerleri inceleyiniz. Birbirleri yerlerine yaz�labilir mi?

select OrderId, Sum(UnitPrice * Quantity*(1-Discount)) as ToplamTutar
from [Order Details]
where OrderID between 10500 and 11000
group by OrderId
having Sum(UnitPrice * Quantity*(1-Discount)) between 2500 and 3500
order by 2 desc

--yerleri degismis hali -- CALISMIYOR
select OrderId, Sum(UnitPrice * Quantity*(1-Discount)) as ToplamTutar
from [Order Details]
where Sum(UnitPrice * Quantity*(1-Discount)) between 2500 and 3500
group by OrderId
having OrderID between 10500 and 11000
order by 2 desc

--where'deki filtreyi having'e aliyoruz
select OrderId, Sum(UnitPrice * Quantity*(1-Discount)) as ToplamTutar
from [Order Details]
group by OrderId
having Sum(UnitPrice * Quantity*(1-Discount)) between 2500 and 3500
and OrderID between 10500 and 11000
order by 2 desc


--having sorgusu group by'dan sonra calisir
--2500-3000 araliginda olmas� gibi bir sorguyu having icinde yazmaliyiz.
--where'deki filtreyi having'e alabiliyoruz, ancak having'deki filtreyi where'e alamiyoruz.


--G�REV13: SP(stored procedure) ve Function aras�ndaki farklar nelerdir?

--fonksiyonlar her zaman geriye bir deger dondurur, procedure'lar ise dondurebilir, ya da dondurmez.
--fonksiyonlarda try-catch yapisi kullanilamaz
--fonksiyonlari select'de kullanabiliriz, ancak fonksiyonlarda update,set,delete kullanilamaz
--fonksiyonlar print ifadesini desteklemez.


