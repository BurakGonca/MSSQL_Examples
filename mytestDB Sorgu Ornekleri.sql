use mytestDB

--% nin anlami su 'anlamsiz'


--icinde manager gecen ifade var mý
select * from Personeller where Unvan like '%Manager%'



-- like kullanimi


-- ismi A ile baslayanlar
select * from Personeller where Adi like 'A%'

--isminin son harfi e olanlar
select * from Personeller where Adi like '%e'


-- ismi h ve z arasindaki bir karakterle baslayan kisileri getirmek
select * from Personeller where Adi like '[H-Z]%'


-- _ kullanimi

-- ismi sadece 5 karakterli olan birini getir
select * from Personeller where Adi like '_____'
--5 tane _ koyduk


-- ismi sadece 5 karakterli olan ve 3. harfi n olan birini getir
select * from Personeller where Adi like '__n__'


--ismi n ile baslayip y ile biten birini getir
select * from Personeller where Adi like 'n%y'


--in kullanimi
--personel id'si 1,2,3 olanlari getir
select * from Personeller where PersonelID in (1,2,3)


--between kullanimi
--personel id'si 1,2,3,4 ve 5 olanlari getir
select * from Personeller where PersonelID between 1 and 5

-- nancy i getirdik
select * from Personeller where Adi Like 'n[abc]_c%'


select * from Personeller


select * from Urunler

--fiyati ortalama fiyatin altýnda olan ürünlerden
-- c ile baslayan ürünlerin sayisi kactir


select *
from Urunler
where BirimFiyati < (select AVG(BirimFiyati) FROM Urunler) 
AND UrunAdi LIKE 'c%' 

--sorunun cevabý "6".
select count(*) from Urunler
where UrunAdi like 'c%' and
BirimFiyati<( select avg(BirimFiyati) from Urunler )

