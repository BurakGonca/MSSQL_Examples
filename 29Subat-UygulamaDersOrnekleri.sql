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



--gorev2: tüm kategori isimleriyle, bu kategorilere ait olan urunlerin adlarýný
--listeleyen bir SP yazip kullaniniz.
create procedure KategoriUrunListe
as
begin
select c.CategoryName, p.ProductName from Categories as c
inner join Products as p on p.CategoryID=c.CategoryID
end


--kullanimi
exec KategoriUrunListe


--gorev3: kategori ID'sini parametre olarak alan ve kategori ID'si bu ID'ye esit olan urunlerin adlarýný ve kategorilerini listeleyen bir SP yazip kullanýnýnýz.
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




--gorev4: 2adet parametre alan bir SP yazin. Bir parametresi categoriID, diðeri ise productID olsun.
--Bu SP, categoriID'si parametre olarak gonderilen kategoriID'ye esit olan, pruductID'si de parametre olarak gonderilen productID'den buyuk olan urunlerin
--urunID, urunAd ve categori adlarýný listeleyiniz. Bu SP'yi kullaniniz.
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
--sorgumuzu kayit altýna almak icin kullaniriz.


--gorev6: TerritoryDescription'ýnda "san"  gecenlerin TerriortyDescription, RegionDescription'larini listeleyen bir view olusturup cagiriniz.
create view vw_TD_SANGecenler
as
select * from Territories as t
where t.TerritoryDescription like '%SAN%'

--kullanimi
select * from vw_TD_SANGecenler


--gorev7: Union ve UnionAll nedir? Aralarindaki fark nedir? bir ornekle gosteriniz.

--birden fazla sonuç kümesini birleþtirmemiz gerektiðinde UNION veya UNION ALL iþlemleri kullanýlýr.

--UNION ALL ifadesinin UNION ifadesinden farký, UNION ALL ile tekrarlý kayýtlar filtrelenmez. 

select 


--GÖREV8: Index nedir? Kýsaca açýklayýnýz.
 --Indeks, verilerin indeksleme alanýna göre sýralanmýþ ve tablo halini almýþ þeklidir. 


--GÖREV9: Candidate key ile super key nedir? Farklarý nedir?
--bir satýrý ayýrabilen tüm anahtarlarýn birleþimi super key kümesi ve bu kümenin her bir elamaný super keydir.
--Candidate key demek primary key olabilecek bir key demektir.
--Primary key özelliðini saðlayan sütün veya sütunlarýn oluþturduðu küme candidate key kümesidir.



--GÖREV10: Parametre olarak 3 adet sayý alan ve bunlarýn toplamýný yazan SP yazýnýz.
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


--GÖREV11: Parametre olarak 3 adet sayý alan ve bunlarýn ortalamasýný yazan SP yazýnýz.
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


--GÖREV12: Aþaðýdaki sorguyu yazýp çalýþtýrýnýz. Having ile where'in kullanýldýðý yerleri inceleyiniz. Birbirleri yerlerine yazýlabilir mi?

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
--2500-3000 araliginda olmasý gibi bir sorguyu having icinde yazmaliyiz.
--where'deki filtreyi having'e alabiliyoruz, ancak having'deki filtreyi where'e alamiyoruz.


--GÖREV13: SP(stored procedure) ve Function arasýndaki farklar nelerdir?

--fonksiyonlar her zaman geriye bir deger dondurur, procedure'lar ise dondurebilir, ya da dondurmez.
--fonksiyonlarda try-catch yapisi kullanilamaz
--fonksiyonlari select'de kullanabiliriz, ancak fonksiyonlarda update,set,delete kullanilamaz
--fonksiyonlar print ifadesini desteklemez.


