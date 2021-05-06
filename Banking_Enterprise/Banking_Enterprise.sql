create database banking_enterprise;
use banking_enterprise;

create table Branch(
branchname varchar(30),
branchcity varchar(30),
assets real,
primary key(branchname));
desc Branch;

create table BankAccount(
accno integer,
branchname varchar(30),
balance real,
primary key(accno),
foreign key(branchname) references Branch(branchname));
desc BankAccount;

create table BankCustomer(
customername varchar(30),
customerstreet varchar(30),
customercity varchar(30),
primary key(customername));
desc BankCustomer;

create table Depositer(
customername varchar(30),
accno integer,
primary key(customername, accno),
foreign key(customername) references BankCustomer(customername),
foreign key(accno) references BankAccount(accno));
desc Depositer;

create table Loan(
loannumber int,
branchname varchar(30),
amount real,
primary key(loannumber),
foreign key(branchname) references Branch(branchname));
desc Loan;

insert into Branch values('SBI_Chamarajpet','Bangalore',50000);
insert into Branch values('SBI_ResidencyRoad','Bangalore',10000);
insert into Branch values('SBI_ShivajiRoad','Bombay',20000);
insert into Branch values('SBI_ParliamentRoad','Delhi',10000);
insert into Branch values('SBI_Jantarmantar','Delhi',20000);
commit;
select * from Branch;


insert into Loan values(1,'SBI_Chamarajpet',1000);
insert into Loan values(2,'SBI_ResidencyRoad',2000);
insert into Loan values(3,'SBI_ShivajiRoad',3000);
insert into Loan values(4,'SBI_ParliamentRoad',4000);
insert into Loan values(5,'SBI_Jantarmantar',5000);
commit;
select * from Loan;

insert into BankAccount values(1,'SBI_Chamarajpet',2000);
insert into BankAccount values(2,'SBI_ResidencyRoad',5000);
insert into BankAccount values(3,'SBI_ShivajiRoad',6000);
insert into BankAccount values(4,'SBI_ParliamentRoad',9000);
insert into BankAccount values(5,'SBI_Jantarmantar',8000);
insert into BankAccount values(6,'SBI_ShivajiRoad',4000);
insert into BankAccount values(8,'SBI_ResidencyRoad',4000);
insert into BankAccount values(9,'SBI_ParliamentRoad',3000);
insert into BankAccount values(10,'SBI_ResidencyRoad',5000);
insert into BankAccount values(11,'SBI_Jantarmantar',2000);
commit;
select * from BankAccount;

insert into BankCustomer values('Avinash','Bull_Temple_Road','Bangalore');
insert into BankCustomer values('Dinesh','Bannerghatta_Road','Bangalore');
insert into BankCustomer values('Mohan','NationalCollegeRoad','Bangalore');
insert into BankCustomer values('Nikhil','Gulmohar_Marg','Delhi');
insert into BankCustomer values('Ravi','Prithviraj_Road','Delhi');
commit;
select * from BankCustomer;

insert into Depositer values('Avinash',1);
insert into Depositer values('Dinesh',2);
insert into Depositer values('Nikhil',4);
insert into Depositer values('Ravi',5);
insert into Depositer values('Avinash',8);
insert into Depositer values('Nikhil',9);
insert into Depositer values('Dinesh',10);
insert into Depositer values('Nikhil',11);
commit;
select * from Depositer;

select c.customername
from BankCustomer c
where exists(
select d.customername
from depositer d, BankAccount ba
where
d.accno=ba.accno and
c.customername=d.customername and
ba.branchname='SBI_ResidencyRoad'
group by d.customername
having count(d.customername)>=2
);

select d.customername from Depositer d,Branch b,BankAccount ba 
where b.branchname=ba.branchname
AND ba.accno=d.accno
and branchcity='Delhi'
group by d.customername 
having COUNT(distinct b.branchname)=(select  COUNT(branchname) from  branch where branchcity='Delhi');

delete from BankAccount
where branchname IN(
select branchname
from Branch
where branchcity='Bombay');

select * from BankAccount;