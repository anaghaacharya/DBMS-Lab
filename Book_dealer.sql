create database book_dealer;
use book_dealer;

create table author(
author_id int,
author_name varchar(20),
author_city varchar(20),
author_country varchar(20),
primary key(author_id));
desc author;

create table publisher(
publisher_id int,
publisher_name varchar(20),
publisher_city varchar(20),
publisher_country varchar(20),
primary key(publisher_id));
desc publisher;

create table category(
category_id int,
category_desc varchar(30),
primary key(category_id));
desc category;

create table catalog(
book_id int,
book_title varchar(30),
author_id int,
publisher_id int,
category_id int,
year int,
price int,
primary key(book_id),
foreign key(author_id) references author(author_id),
foreign key(publisher_id) references publisher(publisher_id),
foreign key(category_id) references category(category_id));
desc catalog;

create table order_details(
order_id int,
book_id int,
quantity int,
primary key(order_id),
foreign key(book_id) references catalog(book_id));
desc order_details;

insert into author values(1001,'JK Rowling','London','England');
insert into author values(1002,'Chetan Bhagat','Delhi','India');
insert into author values(1003,'John McCarthy','Chicago','USA');
insert into author values(1004,'Dan Brown','California','USA');
commit;
select * from author;

insert into publisher values(2001,'Bloomsbury','London','England');
insert into publisher values(2002,'Scholastic','Washington','USA');    
insert into publisher values(2003,'Pearson','London','England');  
insert into publisher values(2004,'Rupa','Delhi','India');  
commit;
select * from publisher;

insert into category values(3001,'Fiction');
insert into category values(3002,'Non-Fiction');
insert into category values(3003,'Thriller');
insert into category values(3004,'Action');
insert into category values(3005,'Fiction');
commit;
select * from category;

insert into catalog values(4001,'HP and Goblet Of Fire',1001,2001,3001,2002,600);
insert into catalog values(4002,'HP and Order Of Phoenix',1001,2002,3001,2005,650);
insert into catalog values(4003,'Two States',1002,2004,3001,2009,65);
insert into catalog values(4004,'3 Mistakes of my life',1002,2004,3001,2007,55);
insert into catalog values(4005,'Da Vinci Code',1004,2003,3001,2004,450);
insert into catalog values(4006,'Angels and Demons',1004,2003,3001,2003,350);
insert into catalog values(4007,'Artificial Intelligence',1003,2002,3002,1970,500);
commit;
select * from catalog;

insert into order_details values(5001,4001,5);
insert into order_details values(5002,4002,7);
insert into order_details values(5003,4003,15);
insert into order_details values(5004,4004,11);
insert into order_details values(5005,4005,9);
insert into order_details values(5006,4006,8);
insert into order_details values(5007,4007,2);
insert into order_details values(5008,4004,3);
commit;
select * from order_details;

#Query1
select * from author
where author_id in
(select author_id from catalog 
where year>2000 and price>(select avg(price) from catalog)
group by author_id having count(*)>1);

#Query2
select a.author_name 
from author a,catalog c
where a.author_id=c.author_id 
and book_id in(select book_id from order_details where quantity = (select max(quantity) from order_details));

#Query3
set sql_safe_updates=0;
update catalog set price=1.1*price
where publisher_id in(select publisher_id from publisher where publisher_name='pearson');
select * from catalog;
set sql_safe_updates = 1;
