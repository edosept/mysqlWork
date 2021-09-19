SET SQL_SAFE_UPDATES = 0;

use seller;
show tables;

select * from person;

update person
set address = 'Jalan Mint', City = 'TGR'
where personid = 1;

update person
set FirstName = 'Otong', LastName = 'Surotong'
where personid = 2;

-- note database pelanggan tidak ada
-- select * from Pelanggan;
-- delete from Pelanggan where usia = 28;
-- delete from Pelanggan where kota = 'Jakarta';
