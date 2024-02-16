/*
c# class => EFCORE => db tablo donusecek

-database olusturma
-tablo olusturma
-tablo ismi degistirme
-tabloya kolon ekleme
-tablodan kolon silme

*/


create database TestTB
go
use TestTB
go
create table MyUsers(

--[kolon adý] [veri tipi] [ekstra nitelikler]

  ID int primary key  identity(1,1),
  UserName nvarchar(25) not null,
  UserPassword nvarchar(20) not null,
  Salary decimal (16,2), --virgülden sonra 2hane hassasiyetle veri saklayacak
  BirthDay date

)

-- 7 kayit ekle
-- maasi en kücük olan personeli sil
-- ortalama maasi hesapla
-- id'si 2 olan personelin bilgileri guncelle


insert into MyUsers
values ('Test1','123456789',17002,'1970-12-25')

insert into MyUsers
values ('Test2','987654321',18500.50,'1995-12-25')

insert into MyUsers
values ('Test3','123698720',23500.80,'1965-12-25')

insert into MyUsers
values ('Test4','123456789',34300.50,'1988-12-25')

insert into MyUsers
values ('Test5','789654321',84500.50,'1998-12-25')

insert into MyUsers
values ('Test6','653698720',17822.80,'1956-12-25')

insert into MyUsers
values ('Test7','433456789',32000.50,'1973-12-25')


  select * from MyUsers


delete from dbo.MyUsers
where ID = (
    select top 1 ID
    from MyUsers
    order by Salary ASC
)


  select
  AVG(u.Salary)
    from MyUsers as u


UPDATE MyUsers
set 
	UserName='Burak',
	BirthDay='1991-05-02'
where ID=2





--ALTER fonksiyonu

alter table MyUsers add YeniKolon int --yeni kolon ekledi

select * from MyUsers

alter table MyUsers drop column YeniKolon --belirttigimiz kolonu sildi


--salary deki tüm verileri yenikolona ekleme

update MyUsers set YeniKolon = Salary

update MyUsers set YeniKolon= Salary*2 --2katini gonderdik



--kolon ismi degistirme

 exec sp_rename 'MyUsers.YeniKolon', 'updateYeniKolon','COLUMN'


  select * from MyUsers

  alter table MyUsers add YeniKolon2 int

  alter table MyUsers
  alter column YeniKolon2 decimal(16,0)


  --databesi kalici silme
drop database --[database ismi] 


--yeni tablo olusturma
create table DenemeTablo(
  metinselVeri nvarchar(30)

)

--yeni tabloya yeni veri ekledik
insert DenemeTablo values('sdafksdhs')

  select * from DenemeTablo


  --veri eklerken kosul koyma
  --CHECK islemi

  create table TestTable(
  Age int check (Age>=18)
    )
  go

  insert TestTable values(19)
  insert TestTable values(20)
  insert TestTable values(17) -- 17yi atmadi

  select * from TestTable


  --var olan bir tablonun bir kolonuna check eklemek

  alter table MyUsers add check (salary<=17002) --bundan sonra asgari ücretten düsük maasla eleman calistirilmayacak! 


   select * from MyUsers


  insert into MyUsers
values ('Test8','789654321',16500,'1998-12-25')

--eklemedi



  alter table MyUsers add constraint kontrol1 check (salary>=517002) 

  
-- check constraint silme

alter table MyUsers drop constraint kontrol1



/*
- yeni bir tablo olustur
- icinde id int pk olsun otomatik artýsli
- name nvarchar 30
- tabloyu olustur
- daha sonra alter ile buna kolon ekle
- ekledigin kolon ismi category türü metinsel
- price alani ekle int olsun
- check constraint ekle kod ile price>100
- tablo ismi degistir
- yeni isimli tabloya 5 adet veri ekle
- yeni kolon ekle int price2 isimli olsun
- orijinal price kolonundaki verileri price2 isimli kolona 3 katý olacak þekilde aktar.

*/

create table Practic(
  ID int primary key  identity(1,1),
  Ad nvarchar(30)
)
  
  
alter table Practic add Category nvarchar(25) 
alter table Practic add Price int 


alter table Practic add check (Price>100) 

exec sp_rename 'Practic', 'Practic2'


select * from Practic2
go

insert into Practic2
values ('Elma','Meyve',105)

insert into Practic2
values ('Armut','Meyve',120)

insert into Practic2
values ('Pýrasa','Sebze',130)

insert into Practic2
values ('Cilek','Meyve',150)

insert into Practic2
values ('Parol','Saglik',180)

insert into Practic2
values ('Nohut','Bakliyat',200)

select * from Practic2
go

alter table Practic2 add Price2 int 



update Practic2 set Price2= Price*2 
go

select * from Practic2
go




