create database supplier;
use supplier;

create table Suppliers(
sid int,
sname varchar(20),
city varchar(20),
primary key(sid));
desc Suppliers;

create table Parts(
pid int,
pname varchar(20),
color varchar (10),
primary key(pid));
desc Parts;

create table Catalog(
sid int,
pid int,
cost real,
primary key(sid,pid),
foreign key(sid) references Suppliers(sid),
foreign key(pid) references Parts(pid));
desc Catalog;

insert into Suppliers values(10001,'Acme Widget','Bangalore');
insert into Suppliers values(10002,'Johns','Kolkata');
insert into Suppliers values(10003,'Vimal','Mumbai');
insert into Suppliers values(10004,'Reliance','Delhi');
commit;
select * from Suppliers;

insert into Parts values(20001,'Book','Red');
insert into Parts values(20002,'Pen','Red');
insert into Parts values(20003,'Pencil','Green');
insert into Parts values(20004,'Mobile','Green');
insert into Parts values(20005,'Charger','Black');
commit;
select * from Parts;

insert into Catalog values(10001,20001,10);
insert into Catalog values(10001,20002,10);
insert into Catalog values(10001,20003,30);
insert into Catalog values(10001,20004,10);
insert into Catalog values(10001,20005,10);
insert into Catalog values(10002,20001,10);
insert into Catalog values(10002,20002,20);
insert into Catalog values(10003,20003,30);
insert into Catalog values(10004,20003,40);
commit;
select * from Catalog;

#Query1
select distinct p.pname
from Parts p, Catalog c
where p.pid=c.pid;

#Query2
select s.sname
from Suppliers s
where not exists(
select p.pid from Parts p where not exists(select c.sid from Catalog c where c.sid=s.sid));

#Query3
select s.sname
from Suppliers s
where not exists(select p.pid from Parts p where p.color='Red' and not exists(select c.sid from Catalog c where c.sid=s.sid and c.pid=p.pid));
#Query4
select p.pname 
from Parts p,Catalog c,Suppliers s
where p.pid=c.pid and
c.sid=s.sid and
s.sname='Acme Widget' and not exists(select * from Catalog ca,Suppliers su where p.pid=ca.pid and ca.sid=su.sid and su.sname<>'Acme Widget');

#Query5
select distinct c.sid
from Catalog c
where c.cost>(select avg(ca.cost) from Catalog ca where ca.pid=c.pid);

#Query6
select p.pid,s.sname
from Parts p, Suppliers s, Catalog c
where
c.pid=p.pid and
c.sid=s.sid and
c.cost=(select max(ca.cost) from Catalog ca where ca.pid=p.pid);