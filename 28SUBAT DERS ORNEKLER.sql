use GONCACOMPANYDB
go

--calisanlarin unvani, adi, soyadi, dogum tarihi, sehri, ülke
--bilgilerini istenilen basliklar ile getiren sql sorgusu yazin
select e.Title [UNVAN], e.FirstName [AD], e.LastName [SOYAD],
e.BirthDate [DOGUM TARIHI], e.City [SEHIR], e.Country[ULKE]
from Employees as e

--30 yil önce ise baslamis calisanlari listeleyin
select e.Title [UNVAN], e.FirstName [AD], e.LastName [SOYAD],
e.BirthDate [DOGUM TARIHI], e.City [SEHIR], e.Country[ULKE], (e.HireDate) [ISE BASLAMA TARIHI]
from Employees as e
where   year(GETDATE()) - year(e.HireDate)  = 30

--30 yil once ve usa da yasayanlar
select e.Title [UNVAN], e.FirstName [AD], e.LastName [SOYAD],
e.BirthDate [DOGUM TARIHI], e.City [SEHIR], e.Country[ULKE], (e.HireDate) [ISE BASLAMA TARIHI]
from Employees as e
where   year(GETDATE()) - year(e.HireDate)  = 30
and e.Country = 'USA'

--calisma yili 30-40 arasi ve ulkesi usa olanlar
select e.Title [UNVAN], e.FirstName [AD], e.LastName [SOYAD],
e.BirthDate [DOGUM TARIHI], e.City [SEHIR], e.Country[ULKE], (e.HireDate) [ISE BASLAMA TARIHI]
from Employees as e
where  30 <= year(GETDATE()) - year(e.HireDate)   
and  abs(year(e.HireDate) - year(GETDATE())) <= 40
and e.Country = 'USA'

-- ayni zamanda yasi 75'ten kucuk olanlar
select e.Title [UNVAN], e.FirstName [AD], e.LastName [SOYAD],
e.BirthDate [DOGUM TARIHI], e.City [SEHIR], e.Country[ULKE], (e.HireDate) [ISE BASLAMA TARIHI]
from Employees as e
where  year(GETDATE()) - year(e.BirthDate) < 75 
and 30 <= year(GETDATE()) - year(e.HireDate)   
and  abs(year(e.HireDate) - year(GETDATE())) <= 40
and e.Country = 'USA'

--30-40 yil once ise baslamis usa da calisan, yasi 75den kucuk olan calisanlarin ilgilendigi siparislerden
-- siparis tarihi, siparis id, kargo sehri ve kargo ulkesini ek kolon olarak ekleyin
select e.Title [UNVAN], e.FirstName [AD], e.LastName [SOYAD],
e.BirthDate [DOGUM TARIHI], e.City [SEHIR], e.Country[ULKE], (e.HireDate) [ISE BASLAMA TARIHI],
o.OrderID [SIPARIS ID], o.ShipCity [KARGO SEHRI], o.ShipCountry [KARGO ULKESI]
from Employees as e
inner join Orders as o on o.EmployeeID=e.EmployeeID
where  30 <= year(GETDATE()) - year(e.HireDate)   
and  abs(year(e.HireDate) - year(GETDATE())) <= 40
and year(GETDATE()) - year(e.BirthDate) < 75
and e.Country = 'USA'

--en sona ek olarak bu calisanlarin kac adet siparisi var yeni kolon ekleyerek
select count(o.OrderID)[SIPARIS SAYISI]
from Employees as e
inner join Orders as o on o.EmployeeID=e.EmployeeID
where  30 <= year(GETDATE()) - year(e.HireDate)   
and  abs(year(e.HireDate) - year(GETDATE())) <= 40
and year(GETDATE()) - year(e.BirthDate) < 75
and e.Country = 'USA'
group by e.EmployeeID


--ek olarak calisanlarin satýs sayilarini ulkelere gore ac - kacini hangi ulkeye yapmis
select e.EmployeeID ,count(o.OrderID)[SIPARIS SAYISI],
o.ShipCountry
from Employees as e
inner join Orders as o on o.EmployeeID=e.EmployeeID
where  30 <= year(GETDATE()) - year(e.HireDate)   
and  abs(year(e.HireDate) - year(GETDATE())) <= 40
and year(GETDATE()) - year(e.BirthDate) < 75
and e.Country = 'USA'
group by e.EmployeeID, o.ShipCountry

--ek olarak bu ulkeler arasinda siparis sayisi 10 dan fazla olan
select e.EmployeeID ,count(o.OrderID)[SIPARIS SAYISI],
o.ShipCountry
from Employees as e
inner join Orders as o on o.EmployeeID=e.EmployeeID
where  30 <= year(GETDATE()) - year(e.HireDate)   
and  abs(year(e.HireDate) - year(GETDATE())) <= 40
and year(GETDATE()) - year(e.BirthDate) < 75
and e.Country = 'USA'
group by e.EmployeeID, o.ShipCountry
having count(o.OrderID)>10

--en son sorguya ek olarak bu siparislerim musterilerin ýd'si
select e.EmployeeID [CALISANID] ,count(o.OrderID)[SIPARIS SAYISI],
o.ShipCountry [KARGO ULKESI], c.Country [MUSTERI ULKE], c.City [MUSTERI SEHRI]
from Employees as e
inner join Orders as o on o.EmployeeID=e.EmployeeID
inner join Customers as c on c.CustomerID=o.CustomerID
where year(GETDATE()) - year(e.HireDate) between 30 and 40
and year(GETDATE()) - year(e.BirthDate) < 75
and e.Country = 'USA'
group by e.EmployeeID, o.ShipCountry, c.Country, c.City
having count(o.OrderID)>5


--bir personelin satýslardan yapmýs oldugu toplam geliri, satýs adetleri ile birlikte listeleyin
-- ve listelerken personelin yapmýs oldugu satýsýn, tum ortalama satýsýn uzerýndeki olanlarý gosterin.
select e.EmployeeID [PERSONELID],
count(o.OrderID) [SATIS ADETI],
sum(od.UnitPrice*od.Quantity) [TOPLAM GELIR]
from Employees as e
inner join Orders as o on e.EmployeeID=o.EmployeeID
inner join [Order Details] as od on o.OrderID = od.OrderID
group by e.EmployeeID
having COUNT(o.OrderID) >  (select count(o.EmployeeID)/( select COUNT(*) from dbo.Employees as e  where e.EmployeeID in (select distinct EmployeeID from Orders ) ) from dbo.Orders as o )  



-----------------------------------UYGULAMA DERS ORNEKLERI-----------------------------------



-- Fonksiyonlar ile store procudure arasýndaki fark arastirin

--kartezyen carpim 
select * from Territories t, Region r


--gorev1 birim fiyati ortalamasinin uzerinde olan urunleri listeleyin
select p.ProductID, p.ProductName from Products as p
where p.UnitPrice > (select avg(p.UnitPrice) from Products as p )


--gorev2 maksimum fiyata sahip olan urunun adý ve birim fiyatini getiriniz
select p.ProductName , p.UnitPrice from Products as p
where p.UnitPrice = (select max(p.UnitPrice) from Products as p )


--gorev3 urunler tablosundaki urunlerden SATILAN urunlerý listeleyiniz
select distinct  (p.ProductName) ,p.UnitPrice from Products as p
inner join [Order Details] as od on p.ProductID=od.ProductID
where p.ProductID is not null

--gorev4 urunler tablosundaki urunlerden SATILMAYAN urunlerý listeleyiniz
select distinct (od.ProductID) , p.ProductName, p.UnitPrice from Products as p
right join [Order Details] as od on p.ProductID=od.ProductID
where od.ProductID is null
 

--gorev5 kargo sirketlerinin kargo sirket kodu ve sirket adi bilgileriyle,toplam tasidiklari siparis sayisini listeleyiniz
select s.CompanyName ,count(o.OrderID) [TASINAN SIPARIS SAYISI] from Shippers as s
inner join Orders as o on o.ShipVia = s.ShipperID
group by s.CompanyName


--gorev6 birezilya'dan siparis veren (orada yasayan) musterilerin verdigi en yuksek siparis tutarýný getiriniz --brazil
select top(1) c.ContactName, c.Country, max(od.UnitPrice * od.Quantity * (1-Discount)) [EN YUKSEK SIPARIS TUTARI]
from Orders as o
inner join Customers as c on o.CustomerID=c.CustomerID
inner join [Order Details] as od on od.OrderID = od.OrderID
where c.Country='Brazil'
group by c.ContactName , c.Country 
order by max(od.UnitPrice * od.Quantity * (1-Discount))
desc
go


--gorev7 urunlerin adini, kategori adini, birim fiyatini ve %18 kdv'li fiyatini hesaplayip listeleyiniz (fonksiyon yazmadan)
select p.ProductName, c.CategoryName , p.UnitPrice, (p.UnitPrice*1.18) [%18 KDV'LI FIYAT]  from Products as p
inner join Categories as c on c.CategoryID=p.CategoryID


--gorev8 , gorev7 deki sorgunun fonksiyonu yaziniz
create function fncKDVHesapla(@tutar decimal(6,2))
returns decimal(6,2)
as
begin
declare @kdvliToplam decimal(6,2)
set @kdvliToplam = (@tutar*1.18)
return @kdvliToplam
end

--fonksiyonla sorgusu
select p.ProductName, c.CategoryName , p.UnitPrice, (select dbo.fncKDVHesapla(p.UnitPrice)) [%18 KDV'LI FIYAT]  from Products as p
inner join Categories as c on c.CategoryID=p.CategoryID



--gorev9 yazdiginiz fonksiyondaki kdv oranini %20 olarak güncelleyiniz
alter function fncKDVHesapla(@tutar decimal(6,2))
returns decimal(6,2)
as
begin
declare @kdvliToplam decimal(6,2)
set @kdvliToplam = (@tutar*1.20)
return @kdvliToplam
end

--%20'li sorgu
select p.ProductName, c.CategoryName , p.UnitPrice, (select dbo.fncKDVHesapla(p.UnitPrice)) [%20 KDV'LI FIYAT]  from Products as p
inner join Categories as c on c.CategoryID=p.CategoryID


--gorev10 KDVHesapla2 adinda baþka bir fonksiyon yaziniz, içerisine 2 adet parametre alsin.
--1.si yine fiyat 2.si ise kategoriID'si olsun.
--Beverages kategorisi icin %18 olacak, diger kategoriler icin %20 olacak.
--sonra bu fonskiyonu kullanarak products tablosu ile categories tablosunu inner join yaparak productName, categoryName, unitPrice ve KDV'li fiyat kolonlarýný listeleyiniz.




--gorev11 1adet fonksiyon yaziniz, bu fonksiyon parametre olarak 1 karakter almalidir
--(nchar(1) alabilir) . Calisanlardan adý, fonksiyona gonderilen parametre ile baslayanlarin tüm bilgileri getirilmelidir.. Orn: Parametre olarak 'A' gonderdik o zaman adi A ile baslayanlarin tüm bilgilerini getirecek. Sonra bu fonksiyonu istediginiz bir karakter ile cagirip test ediniz.

