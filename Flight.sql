create database flight;
use flight;

create table flights(
flno int,
ffrom varchar(15) not null,
tto varchar(15) not null,
distance int,
departs timestamp,
arrives timestamp,
primary key(flno));

alter table flights
add price int not null;
desc flights;

create table aircraft(
aid int,
aname varchar(10),
cruisingrange int,
primary key (aid));
desc aircraft;

create table employees(
eid int,
ename varchar(15),
salary int,
primary key(eid));
desc employees;

create table certified(
eid int not null,
aid int not null,
primary key(eid,aid),
foreign key(eid) references employees(eid),
foreign key(aid) references aircraft(aid));
desc certified;

insert into flights values(101,'Bangalore','Delhi',2500,'2005-05-13 07:15:31','2005-05-13 17:15:31',5000);
insert into flights values(102,'Bangalore','Lucknow',3000,'2005-05-13 07:15:31','2005-05-13 11:15:31',6000);
insert into flights values(103,'Lucknow','Delhi',500,'2005-05-13 12:15:31','2005-05-13 17:15:31',3000);
insert into flights values(107,'Bangalore','Frankfurt',8000,'2005-05-13  07:15:31','2005-05-13 22:15:31',60000);
insert into flights values(104,'Bangalore','Frankfurt',8500,'2005-05-13 07:15:31','2005-05-13 23:15:31',75000);
insert into flights values(105,'Kolkata','Delhi',3400,'2005-05-13 07:15:31','2005-05-13 09:15:31',7000);
commit;
select * from flights;

insert into aircraft values(101,'747',3000);
insert into aircraft values(102,'Boeing',900);
insert into aircraft values(103,'647',800);
insert into aircraft values(104,'Dreamliner',10000);
insert into aircraft values(105,'Boeing',3500);
insert into aircraft values(106,'707',1500);
insert into aircraft values(107,'Dream',120000);
commit;
select * from aircraft;

insert into employees values(701,'A',50000);
insert into employees values(702,'B',100000);
insert into employees values(703,'C',150000);
insert into employees values(704,'D',90000);
insert into employees values(705,'E',40000);
insert into employees values(706,'F',60000);
insert into employees values(707,'G',90000);
commit;
select * from employees;

insert into certified values(701,101);
insert into certified values(701,102);
insert into certified values(701,106);
insert into certified values(701,105);
insert into certified values(702,104);
insert into certified values(703,104);
insert into certified values(704,104);
insert into certified values(702,107);
insert into certified values(703,107);
insert into certified values(704,107);
insert into certified values(702,101);
insert into certified values(703,105);
insert into certified values(704,105);
insert into certified values(705,103);
commit;
select * from certified;

#Query1
select distinct a.aname
from aircraft a 
where a.aid in( select c.aid 
                from certified c, employees e
                where c.eid=e.eid and
                not exists(select * from employees e1 where e1.eid=e.eid and e1.salary<80000));

#Query2
select c.eid,max(a.cruisingrange)
from certified c, aircraft a
where c.aid=a.aid
group by c.eid
having count(*)>3;

#Query3
select distinct e.ename
from employees e where e.salary<(select min(f.price) from flights f where f.ffrom='Bangalore' and f.tto='Frankfurt');

#Query4
select c.aid,avg(e.salary) 
from certified c,employees e
where c.aid in(select aid from aircraft where cruisingrange>1000)
and e.eid=c.eid
group by c.aid;

#Query5
select distinct e.ename
from employees e, certified c, aircraft a
where e.eid=c.eid 
and c.aid=a.aid
and a.aname like 'Boeing%';

#Query6
select a.aid
from aircraft a where a.cruisingrange>(select min(f.distance) from flights f where f.ffrom='Bangalore' and f.tto='Frankfurt');

#Query7
select  f.departs
from flights f
where f.flno in ( ( select f0.flno
from flights f0
where f0.ffrom = 'Bangalore' and f0.tto = 'Delhi'
and extract(hour from f0.arrives) < 18 )
union
(select f0.flno
 from flights f0, flights f1
 where f0.ffrom = 'Bangalore' and f0.tto <> 'Delhi'
 and f0.tto = f1.ffrom and f1.tto = 'Delhi'
 and f1.departs > f0.arrives
 and extract(hour from f1.arrives) < 18)
 union
(select f0.flno
 from flights f0, flights f1, flights f2
 where f0.ffrom = 'Bangalore'
 and f0.tto = f1.ffrom
 and f1.tto = f2.ffrom
 and f2.tto = 'Delhi'
 and f0.tto <> 'Delhi'
 and f1.tto <> 'Delhi'
 and f1.departs > f0.arrives
 and f2.departs > f1.arrives
 and extract(hour from f2.arrives) < 18));