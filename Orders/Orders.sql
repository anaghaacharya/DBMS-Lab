create database orders;
use orders;

create table salesman(
salesman_id int,
name varchar(20),
city varchar(20),
commission varchar(20),
primary key(salesman_id));
desc salesman;

create table customer(
customer_id int,
cust_name varchar(20),
city varchar(20),
grade int,
salesman_id int,
primary key(customer_id),
foreign key(salesman_id) references salesman(salesman_id) on delete set null);
desc customer;

create table orders(
ord_no int,
purchase_amt int,
ord_date date,
customer_id int,
salesman_id int,
primary key(ord_no),
foreign key(customer_id) references customer(customer_id) on delete cascade,
foreign key(salesman_id) references salesman(salesman_id) on delete cascade);
desc orders;

insert into salesman values(1000,'John','Bangalore','25%');
insert into salesman values(2000,'Ravi','Bangalore','20%');
insert into salesman values(3000,'Kumar','Mysore','15%');
insert into salesman values(4000,'Sunil','Delhi','30%');
insert into salesman values(5000,'Harsha','Hyderabad','15%');
commit;
select * from salesman;

insert into customer values(10,'Preethi','Bangalore',100,1000);
insert into customer values(11,'Vivel','Mangalore',300,1000);
insert into customer values(12,'Baskaran','Chennai',400,2000);
insert into customer values(13,'Chethan','Bangalore',200,2000);
insert into customer values(14,'Suchitra','Bangalore',400,3000);
commit;
select * from customer;

insert into orders values(50,5000,'2017-05-04',10,1000);
insert into orders values(51,450,'2017-01-20',10,2000);
insert into orders values(52,1000,'2017-02-24',13,2000);
insert into orders values(53,3500,'2017-04-13',14,3000);
insert into orders values(54,550,'2017-03-09',12,2000);
commit;
select * from orders;

#Query1
select grade,count(customer_id)
from customer
group by grade
having grade>(select avg(grade) from customer where city='Bangalore');

#Query2
select s.name,s.salesman_id
from salesman s
where 1<(select count(*) from customer where salesman_id=s.salesman_id);

#Query3
select s.salesman_id,s.name,c.cust_name,s.commission
from salesman s, customer c
where s.city=c.city
union
select s1.salesman_id,s1.name,'No match',s1.commission
from salesman s1
where not city=any(select city from customer order by city desc);

#Query4
create view highestsales
as select s.salesman_id,s.name,o.ord_date
from salesman s, orders o
where s.salesman_id=o.salesman_id
and o.purchase_amt=(select max(purchase_amt) from orders o1 where o1.ord_date=o.ord_date);
select * from highestsales;

#Query6
delete from salesman
where salesman_id=1000;

select * from salesman;
select * from customer;
select * from orders;
