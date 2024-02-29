use GONCACOMPANY
go

--ODEV3

--gorev1 : AyHesapla ad�nda, ald��� DATETIME cinsinden de�erin �zerinden ka� ay ge�ti�ini hesaplayan ve bu de�eri geri d�nd�ren bir fonksiyon olu�turunuz. Ard�ndan, Employees tablosundaki her bir �al��an i�in i�e ba�lama tarihinden bu yana ka� ay ge�ti�ini, bu fonksiyonu kullanarak listeleyiniz.
create function fn_AyHesapla(@zaman datetime)
returns int
as
begin
declare @gecenZaman int
set @gecenZaman = ( (year(getdate())-year(@zaman))*12)+(month(getdate())-month(@zaman) )
return @gecenZaman
end

--select dbo.fn_AyHesapla ('02-05-1991') --ay,g�n,yil olarak aliyor

--
select concat(e.FirstName, ' ' ,e.LastName) [AD SOYAD] , dbo.fn_AyHesapla(e.HireDate) [KAC AY CALISTI] from Employees as e



--gorev2: �ki tarih aras�ndaki fark� alan ve bu fark� g�n olarak d�nd�ren bir fonksiyon yaz�n�z. Daha sonra orders tablosundaki her sat�r i�in OrderDate ile ShippedDate aras�ndaki g�n say�s�n�, bu fonksiyonu kullanarak listeleyiniz.

create function fn_IkiTarihArasiFark(@zaman1 datetime, @zaman2 datetime)
returns int
as
begin
declare @gecenZaman int
set @gecenZaman = cast(@zaman1 as int) - cast(@zaman2 as int)
return @gecenZaman
end


select o.OrderID, o.OrderDate, o.ShippedDate, dbo.fn_IkiTarihArasiFark (o.ShippedDate,o.OrderDate) [GONDERIM GUN SAYISI] from Orders as o



--gorev3: Employees tablosundan firstname�leri, d��ar�dan g�nderilen harf ile ba�layanlar� tablo olarak d�nd�ren fonksiyon yaz�n�z. Ard�ndan bu fonksiyonu kullanarak A ile ba�layanlar� listeleyiniz.

create function fn_HarfeGoreListele(@harf nchar(1))
returns table
as
return
select * from Employees as e
where e.FirstName like concat(@harf , '%')


select * from dbo.fn_HarfeGoreListele('A')

select * from Employees



--gorev4: Order details tablosundaki unitprice�lar�n k�rp�lm�� ortalamas�n� hesaplayan stored procedure yaz�n�z. (K�rp�lm�� ortalama: En k���k ve en b�y�k de�erler dahil edilmeden hesaplanan aritmetik ortalamad�r.

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

