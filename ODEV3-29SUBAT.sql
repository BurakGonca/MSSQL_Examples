use GONCACOMPANY
go

--ODEV3

--gorev1 : AyHesapla adýnda, aldýðý DATETIME cinsinden deðerin üzerinden kaç ay geçtiðini hesaplayan ve bu deðeri geri döndüren bir fonksiyon oluþturunuz. Ardýndan, Employees tablosundaki her bir çalýþan için iþe baþlama tarihinden bu yana kaç ay geçtiðini, bu fonksiyonu kullanarak listeleyiniz.
create function fn_AyHesapla(@zaman datetime)
returns int
as
begin
declare @gecenZaman int
set @gecenZaman = ( (year(getdate())-year(@zaman))*12)+(month(getdate())-month(@zaman) )
return @gecenZaman
end

--select dbo.fn_AyHesapla ('02-05-1991') --ay,gün,yil olarak aliyor

--
select concat(e.FirstName, ' ' ,e.LastName) [AD SOYAD] , dbo.fn_AyHesapla(e.HireDate) [KAC AY CALISTI] from Employees as e



--gorev2: Ýki tarih arasýndaki farký alan ve bu farký gün olarak döndüren bir fonksiyon yazýnýz. Daha sonra orders tablosundaki her satýr için OrderDate ile ShippedDate arasýndaki gün sayýsýný, bu fonksiyonu kullanarak listeleyiniz.

create function fn_IkiTarihArasiFark(@zaman1 datetime, @zaman2 datetime)
returns int
as
begin
declare @gecenZaman int
set @gecenZaman = cast(@zaman1 as int) - cast(@zaman2 as int)
return @gecenZaman
end


select o.OrderID, o.OrderDate, o.ShippedDate, dbo.fn_IkiTarihArasiFark (o.ShippedDate,o.OrderDate) [GONDERIM GUN SAYISI] from Orders as o



--gorev3: Employees tablosundan firstname’leri, dýþarýdan gönderilen harf ile baþlayanlarý tablo olarak döndüren fonksiyon yazýnýz. Ardýndan bu fonksiyonu kullanarak A ile baþlayanlarý listeleyiniz.

create function fn_HarfeGoreListele(@harf nchar(1))
returns table
as
return
select * from Employees as e
where e.FirstName like concat(@harf , '%')


select * from dbo.fn_HarfeGoreListele('A')

select * from Employees



--gorev4: Order details tablosundaki unitprice’larýn kýrpýlmýþ ortalamasýný hesaplayan stored procedure yazýnýz. (Kýrpýlmýþ ortalama: En küçük ve en büyük deðerler dahil edilmeden hesaplanan aritmetik ortalamadýr.

create procedure sp_KirpilmisOrtalamaBul
as
begin
declare @MinFiyat decimal(10, 2), @MaxFiyat decimal(10, 2), @ortalama decimal(10, 2)
select @MinFiyat = min(od.UnitPrice), @MaxFiyat = max(od.UnitPrice)
from [Order Details] as od
select @ortalama = avg(od.UnitPrice) from [Order Details] as od
where @MinFiyat < od.UnitPrice and od.UnitPrice < @MaxFiyat
print concat('Kirpilmis Ortalama: ', @ortalama)
end



exec sp_KirpilmisOrtalamaBul

