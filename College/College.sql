create database college;
use college;

create table student(
usn varchar(10) primary key,
sname varchar(25),
address varchar(25),
phone int,
gender char(1));
desc student;
alter table student modify column phone bigint;

create table semsec(
ssid varchar(5) primary key,
sem int,
sec char(1));
desc semsec;

create table class(
usn varchar(10),
ssid varchar(5),
primary key(usn,ssid),
foreign key(usn) references student(usn),
foreign key(ssid) references semsec(ssid));
desc class;

create table subject(
subcode varchar(8),
title varchar(20),
sem int,
credits int,
primary key(subcode));
desc subject;

create table iamarks(
usn varchar(10),
subcode varchar(8),
ssid varchar(5),
test1 int,
test2 int,
test3 int,
finalia int,
primary key (usn,subcode,ssid),
foreign key (usn) references student (usn),
foreign key (subcode) references subject (subcode),
foreign key (ssid) references semsec (ssid));
desc iamarks;

insert into student values('1RN13CS020','AKSHAY','BELAGAVI', 8877881122,'M'); 
insert into student values('1RN13CS062','SANDHYA','BENGALURU', 7722829912,'F'); 
insert into student values('1RN13CS091','TEESHA','BENGALURU', 7712312312,'F'); 
insert into student values('1RN13CS066','SUPRIYA','MANGALURU', 8877881122,'F'); 
insert into student values ('1RN14CS010','ABHAY','BENGALURU', 9900211201,'M'); 
insert into student values ('1RN14CS032','BHASKAR','BENGALURU', 9923211099,'M'); 
insert into student values ('1RN14CS025','ASMI','BENGALURU', 7894737377,'F'); 
insert into student values ('1RN15CS011','AJAY','TUMKUR', 9845091341,'M');
insert into student values ('1RN15CS029','CHITRA','DAVANGERE', 7696772121,'F'); 
insert into student values ('1RN15CS045','JEEVA','BELLARY', 9944850121,'M'); 
insert into student values ('1RN15CS091','SANTOSH','MANGALURU', 8812332201,'M'); 
insert into student values ('1RN16CS045','ISMAIL','KALBURGI', 9900232201,'M'); 
insert into student values ('1RN16CS088','SAMEERA','SHIMOGA', 9905542212,'F'); 
insert into student values ('1RN16CS122','VINAYAKA','CHIKAMAGALUR', 8800880011,'M'); 
commit;
select * from student;
 
insert into semsec values('CSE8A', 8,'A'); 
insert into semsec values('CSE8B', 8,'B'); 
insert into semsec values('CSE8C', 8,'C'); 
insert into semsec values('CSE7A', 7,'A'); 
insert into semsec values('CSE7B', 7,'B'); 
insert into semsec values('CSE7C', 7,'C'); 
insert into semsec values('CSE6A', 6,'A'); 
insert into semsec values('CSE6B', 6,'B'); 
insert into semsec values('CSE6C', 6,'C'); 
insert into semsec values('CSE5A', 5,'A'); 
insert into semsec values('CSE5B', 5,'B'); 
insert into semsec values('CSE5C', 5,'C'); 
insert into semsec values('CSE4A', 4,'A'); 
insert into semsec values('CSE4B', 4,'B'); 
insert into semsec values('CSE4C', 4,'C'); 
insert into semsec values('CSE3A', 3,'A'); 
insert into semsec values('CSE3B', 3,'B'); 
insert into semsec values('CSE3C', 3,'C'); 
insert into semsec values('CSE2A', 2,'A'); 
insert into semsec values('CSE2B', 2,'B'); 
insert into semsec values('CSE2C', 2,'C'); 
insert into semsec values('CSE1A', 1,'A');
insert into semsec values('CSE1B', 1,'B'); 
insert into semsec values('CSE1C', 1,'C'); 
commit;
select * from semsec;

insert into class values ('1RN13CS020','CSE8A'); 
insert into class values ('1RN13CS062','CSE8A'); 
insert into class values ('1RN13CS066','CSE8B'); 
insert into class values ('1RN13CS091','CSE8C'); 
insert into class values ('1RN14CS010','CSE7A'); 
insert into class values ('1RN14CS025','CSE7A'); 
insert into class values ('1RN14CS032','CSE7A'); 
insert into class values ('1RN15CS011','CSE4A'); 
insert into class values ('1RN15CS029','CSE4A'); 
insert into class values ('1RN15CS045','CSE4B'); 
insert into class values ('1RN15CS091','CSE4C'); 
insert into class values ('1RN16CS045','CSE3A'); 
insert into class values ('1RN16CS088','CSE3B'); 
insert into class values ('1RN16CS122','CSE3C'); 
commit;
select * from class;

insert into subject values ('10CS81','ACA', 8, 4); 
insert into subject values ('10CS82','SSM', 8, 4); 
insert into subject values ('10CS83','NM', 8, 4); 
insert into subject values ('10CS84','CC', 8, 4); 
insert into subject values ('10CS85','PW', 8, 4); 
insert into subject values ('10CS71','OOAD', 7, 4); 
insert into subject values ('10CS72','ECS', 7, 4); 
insert into subject values ('10CS73','PTW', 7, 4); 
insert into subject values ('10CS74','DWDM', 7, 4); 
insert into subject values ('10CS75','JAVA', 7, 4); 
insert into subject values ('10CS76','SAN', 7, 4); 
insert into subject values ('15CS51', 'ME', 5, 4); 
insert into subject values ('15CS52','CN', 5, 4); 
insert into subject values ('15CS53','DBMS', 5, 4); 
insert into subject values ('15CS54','ATC', 5, 4); 
insert into subject values ('15CS55','JAVA', 5, 3); 
insert into subject values ('15CS56','AI', 5, 3);
insert into subject values ('15CS41','M4', 4, 4); 
insert into subject values ('15CS42','SE', 4, 4); 
insert into subject values ('15CS43','DAA', 4, 4); 
insert into subject values ('15CS44','MPMC', 4, 4); 
insert into subject values ('15CS45','OOC', 4, 3); 
insert into subject values ('15CS46','DC', 4, 3); 
insert into subject values ('15CS31','M3', 3, 4); 
insert into subject values ('15CS32','ADE', 3, 4); 
insert into subject values ('15CS33','DSA', 3, 4); 
insert into subject values ('15CS34','CO', 3, 4); 
insert into subject values ('15CS35','USP', 3, 3); 
insert into subject values ('15CS36','DMS', 3, 3); 
commit;
select * from subject ;

insert into iamarks (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) values ('1RN13CS091','10CS81','CSE8C', 15, 16, 18); 
insert into iamarks (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) values ('1RN13CS091','10CS82','CSE8C', 12, 19, 14); 
insert into iamarks (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) values ('1RN13CS091','10CS83','CSE8C', 19, 15, 20); 
insert into iamarks (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) values ('1RN13CS091','10CS84','CSE8C', 20, 16, 19); 
insert into iamarks (USN, SUBCODE, SSID, TEST1, TEST2, TEST3) values ('1RN13CS091','10CS85','CSE8C', 15, 15, 12);
commit;
select * from iamarks;

#Query1
select s.*, ss.sem,ss.sec
from student s, semsec ss, class c
where s.usn=c.usn and
ss.ssid=c.ssid and
ss.sem=4 and
ss.sec='C';

#Query2
select ss.sem,ss.sec,s.gender,count(s.gender)as count
from student s,semsec ss,class c
where s.usn=c.usn and
ss.ssid=c.ssid
group by ss.sem,ss.sec,s.gender
order by sem;

#Query3
create view student_test1
as select test1, subcode
from iamarks
where usn='1RN13CS091';
select * from student_test1;

#Query4
select s.usn,s.sname,s.address,s.phone,s.gender, 
(case 
when ia.finalia between 17 and 20 then 'outstanding' 
when ia.finalia between 12 and 16 then 'average' 
else 'weak' 
end)
as cat 
from student s, semsec ss, iamarks ia, subject sub
where s.usn = ia.usn and 
ss.ssid = ia.ssid and
sub.subcode = ia.subcode and
sub.sem = 8;


