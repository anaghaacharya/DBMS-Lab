create database student;
use student;

create table student(
snum int,
sname varchar(10),
major varchar(2),
lvl varchar(2),
age int,
primary key(snum));
desc student;

create table faculty(
fid int,
fname varchar(20),
deptid int,
primary key(fid));
desc faculty;

create table class(
cname varchar(20),
meets_at timestamp,
room varchar(10),
fid int,
primary key(cname),
foreign key(fid) references faculty(fid));
desc class;

create table enrolled(
snum int,
cname varchar(20),
primary key(snum,cname),
foreign key(snum) references student(snum),
foreign key(cname) references class(cname));
desc enrolled;

insert into student values(1,'Jhon','CS','Sr',19);
insert into student values(2,'Smith','CS','Jr',20);
insert into student values(3,'Jacob','CV','Sr',20);
insert into student values(4,'Tom','CS','Jr',20);
insert into student values(5,'Rahul','CS','Jr',20);
insert into student values(6,'Rita','CS','Sr',21);
commit;
select * from student;

insert into faculty values(11,'Harish',1000);
insert into faculty values(12,'MV',1000);
insert into faculty values(13,'Mira',1001);
insert into faculty values(14,'Shiva',1002);
insert into faculty values(15,'Nupur',1000);
commit;
select * from faculty;

insert into class values('class1','12/11/15 10:15:16','R1',14);
insert into class values('class10','12/11/15 10:15:16','R128',14);
insert into class values('class2','12/11/15 10:15:20','R2',12);
insert into class values('class3','12/11/15 10:15:25','R3',11);
insert into class values('class4','12/11/15 20:15:20','R4',14);
insert into class values('class5','12/11/15 20:15:20','R3',15);
insert into class values('class6','12/11/15 13:20:20','R2',14);
insert into class values('class7','12/11/15 10:10:10','R3',14);
commit;
select * from class;

insert into enrolled values(1,'class1');
insert into enrolled values(2,'class1');
insert into enrolled values(3,'class3');
insert into enrolled values(4,'class3');
insert into enrolled values(5,'class4');
insert into enrolled values(1,'class5');
insert into enrolled values(2,'class5');
insert into enrolled values(3,'class5');
insert into enrolled values(4,'class5');
insert into enrolled values(5,'class5');
commit;
select * from enrolled;

#Query i
select distinct s.sname
from student s,class c, enrolled e, faculty f
where s.snum=e.snum 
and e.cname=c.cname 
and c.fid=f.fid
and f.fname='Harish' and s.lvl='Jr';

#Query ii
select c.cname
from class c
where c.room='R128'
or c.cname in(select e.cname from enrolled e group by e.cname having count(*)>=5);


#Query iii
select distinct s.sname
from student s
where s.snum in(select e1.snum 
               from enrolled e1,enrolled e2,class c1, class c2
			   where e1.snum=e2.snum and e1.cname<>e2.cname
			   and e1.cname=c1.cname
               and e2.cname=c2.cname
               and c1.meets_at=c2.meets_at);
               

#Query iv
select f.fname
from faculty f
where f.fid in (select fid from class
			    group by fid having count(*)=(select count(distinct room) from class) );


#Query v
select distinct f.fname
from faculty f
where 5>(select count(e.snum) from class c, enrolled e where c.cname=e.cname and c.fid=f.fid);


#Query vi
select distinct s.sname
from student s
where s.snum not in(select e.snum from enrolled e);

#Query vii
select s.age, s.lvl
from student s
group by s.age,s.lvl
having s.lvl in(select s1.lvl from student s1 
			where s1.age=s.age
            group by s1.lvl,s1.age
            having count(*)>=all(select count(*) from student s2 where s1.age=s2.age group by s2.lvl,s2.age));
