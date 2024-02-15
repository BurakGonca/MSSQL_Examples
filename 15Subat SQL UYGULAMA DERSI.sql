--
/* 
asdadaghfhgfhfg
sdfsjdjljlg
cfsf sdfsfds
*/


use GONCASIRKETTURKCEDB
--select * from [tabloadi]    ----tablodaki t�m klonlar� getirir

select * from Personeller


select p.Adi+' '+p.SoyAdi  from Personeller p


--bir personelin unvan ekini isminin ba��na ekleyerek getir
--ve bulundu�u �lke ve �ehrin posta kodunu �ehir bilgisini alias ile g�ster birle�tirip iki kolon

select
(p.UnvanEki +' '+ p.Adi+' '+ p.SoyAdi) [UNVAN ISIM],
(p.Ulke + ' '+ p.Sehir) [ULKE SEH�R]
from Personeller as p





---- personeller tablosunda �nvan eki ms olan kullanicilarin isimlerini getir

select
p.Adi [ms] 
from Personeller as p
where p.UnvanEki='MS.' or p.UnvanEki='Dr.'


select GETDATE();

select Year(GETDATE());

-- yasi 70'dan b�y�k olan personelleri listele
-- USA de yasayanl�ar

select
p.Adi  + ' ' + p.Soyadi [AD SOYAD],
p.DogumTarihi [DOGUMYILI],
p.Ulke [ULKE]
from Personeller as p
where Year(GETDATE()) -Year(p.DogumTarihi) > 70 and p.Ulke='USA'
order by p.Adi


---t�m personellerin ya��n� ya� isimli bir kolonda g�steriniz
--ad ve soy ad birle�tirip isim adli bir kolonda yazs�n

select
p.Adi  + ' ' + p.Soyadi [AD SOYAD],
Year(GETDATE()) -Year(p.DogumTarihi) [YAS]
from Personeller as p
order by p.Adi


--id si 2,3,5 ve 9 olan personellerin isimleri getir

select * from Personeller

select
p.Adi  + ' ' + p.Soyadi [AD SOYAD]
from Personeller as p
where p.PersonelID in (2,3,9)
order by p.Adi

-------- TABLO EKLEME -----------

use GONCASIRKETTURKCEDB
go
create table TestTablo(
 
	
	 Id int primary key,
	 UserName nvarchar(30),
	 Price int 
)

-----TABLOYA DATA EKLEME-----
insert TestTablo values (1,'Burak',80)
insert testTablo values(2,'hasan',123)
insert testTablo values(3,'ali',250)
insert testTablo values(4,'veli',60)
insert testTablo values(5,'ay�e',55)
insert testTablo values(6,'mehmet',135)


select *from TestTablo


delete from TestTablo --D�KKAT DATALARI KALICI S�LER

delete from TestTablo where UserName='Hasan' -- spesifik olarak hasan� sildi





--id si 3ten buyuk ve maas� 100'den buyuk herkesi sil

delete from TestTablo where Id>3 and Price>100

insert TestTablo values(7,'gonca',300)







-------------------

use GONCASIRKETTURKCEDB
go
create table TestTablo2(
 
	
	 Id int primary key,
	 UserName nvarchar(30) not null,
	 Salary int, 
	 BirthDate date
)

insert TestTablo2 values (1,'Burak',1005,'1991.05.25')
insert TestTablo2 values (2,'Gonca',2500,'1976.04.25')
insert TestTablo2 values (3,'Goncaa',800,'1963.05.25')
insert TestTablo2 values (4,'Burakk',975,'1997.05.25')
insert TestTablo2 values (5,'Deneme1',1350,'1997.05.25')
insert TestTablo2 values (6,'Deneme2',2560,'1992.05.25')
insert TestTablo2 values (7,'Deneme3',785,'1956.05.25')
insert TestTablo2 values (8,'Deneme4',980,'1945.05.25')
insert TestTablo2 values (9,'Deneme5',1250,'1974.05.25')


select *from TestTablo2


--kullanicilarin yasini yazd�r
--ya�� 30'dan b�y�k olanlari g�sterin
--ya�� 40'dan b�y�k olanlari silin
--maa�� 1000'den fazla olanlarin isimlerini yazdirin


select
t2.UserName [AD],
Year(GETDATE()) - Year(t2.BirthDate) [YAS]
from TestTablo2 as t2
--where p.PersonelID in (2,3,9)
order by t2.Id

-------------------------

select
t2.UserName [AD],
Year(GETDATE()) - Year(t2.BirthDate) [YAS]
from TestTablo2 as t2
where Year(GETDATE()) - Year(t2.BirthDate) >30
order by t2.Id

-------------------------------


delete from TestTablo2 where Year(GETDATE()) - Year(BirthDate) >40


select * from TestTablo2

---------------------------------


select
t2.UserName [AD],
Year(GETDATE()) - Year(t2.BirthDate) [YAS],
t2.Salary [MAAS]
from TestTablo2 as t2
where t2.Salary>1000
order by t2.Id


---------------------------------
--birim fiyatlari 10'dan buyuk olanlarin isimlerini ve fiyatlarini yazdir

select
u.UrunAdi [URUN ADI],
u.BirimFiyati [F�YAT]
from Urunler as u
where u.BirimFiyati>10
order by u.BirimFiyati ASC --DESC tersi


select * from Urunler


---------------------------------
--birim fiyat, en buyuk olan�n isimini ve fiyatini yazdir

select
top(1)
u.UrunAdi,u.BirimFiyati 
from Urunler as u
where u.BirimFiyati>10
order by u.BirimFiyati
desc --en kucuk icin asc


--------------------------------------------


select Count(*) from Urunler --TABLODAKI URUN SAYISI

--------------------------------------------

select Count(*) from Urunler as u where u.BirimFiyati>100  --100'den buyuklerin sayisi

--------------------------------------------

select Sum(u.HedefStokDuzeyi) from Urunler as u where u.BirimFiyati>100 
-- fiyat� 100'den b�y�k olanlarin stokd�zeyi toplamlari


--------------------------------------------

select avg(u.HedefStokDuzeyi) from Urunler as u --average/ortalama 40





---hedefstokduzeyi ortalaman�n alt�nda olanlar�n  urunleri listele

select
u.UrunID [ID],
u.UrunAdi,
u.HedefStokDuzeyi
from Urunler as u
where u.HedefStokDuzeyi<(select avg(u.HedefStokDuzeyi) from Urunler as u)


---personeller tablosunda yasi ortalama yastan k�c�k olan personellerin id'lerini topla


select
SUM(p.PersonelID) [IDLER TOPLAMI]
from Personeller as p
where Year(GETDATE()) - Year(p.DogumTarihi)
<
(select avg(Year(GETDATE()) - Year(p.DogumTarihi)) from Personeller as p)


