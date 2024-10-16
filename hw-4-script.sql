-------------------------------- 1
CREATE DATABASE IF NOT EXISTS LibraryManagement;

USE LibraryManagement;

CREATE TABLE IF NOT EXISTS authors
(
author_id int auto_increment primary key,
author_name varchar(255)
);

CREATE TABLE IF NOT EXISTS genres
(
genre_id int auto_increment primary key,
genre_name varchar(255)
);

CREATE TABLE IF NOT EXISTS books
(
book_id int auto_increment primary key,
title varchar(255),
publication_year year,
author_id int not null,
genre_id int not null,

foreign key (author_id) references authors (author_id),
foreign key (genre_id) references genres (genre_id)
);

CREATE TABLE IF NOT EXISTS users
(
user_id int auto_increment primary key,
username varchar(255),
email varchar(255)
);

CREATE TABLE IF NOT EXISTS borrowed_books
(
borrow_id int auto_increment primary key,
book_id int not null,
user_id int not null,
borrow_date date,
return_date date,

foreign key (book_id) references books (book_id),
foreign key (user_id) references users (user_id)
);

-------------------------------- 2

insert into LibraryManagement.authors (author_name) value ('Greg McKeown'), ('Yevhenia Kuznietsova'), ('John Strelecky');
insert into LibraryManagement.genres (genre_name) value ('Novel'), ('Fiction'), ('Drama');
insert into LibraryManagement.books (title, publication_year, author_id, genre_id) value ('Essentialism: The Disciplined Pursuit of Less', 2014, 1, 3), 
('Ask Miechka', 2011, 2, 2), ('The Cafe on the Edge of the World', 2003, 3, 1);
insert into LibraryManagement.users (username, email) value ('Dariia', 'dariiab@gmail.com');
insert into LibraryManagement.borrowed_books (book_id, user_id, borrow_date, return_date) value (1, 1, '2024-05-01', '2024-07-11');

select * from borrowed_books;

-------------------------------- 3

USE ORDERS_HW3;

select * from orders;
select * from customers;

select *
from orders o
inner join customers cs on o.customer_id = cs.id
inner join employees em on o.employee_id = em.employee_id
inner join shippers sh on o.shipper_id = sh.id
inner join order_details od on o.id = od.order_id
inner join products pr on od.product_id = pr.id
inner join categories cat on pr.category_id = cat.id
inner join suppliers su on pr.supplier_id = su.id
;
-------------------------------- 4
select count(*) 
from orders o
INNER JOIN customers cs ON o.customer_id = cs.id
INNER JOIN employees em ON o.employee_id = em.employee_id
INNER JOIN shippers sh ON o.shipper_id = sh.id
INNER JOIN order_details od ON o.id = od.order_id
INNER JOIN products pr ON od.product_id = pr.id
INNER JOIN categories cat ON pr.category_id = cat.id
INNER JOIN suppliers su ON pr.supplier_id = su.id;

--
select count(*)
from orders o
LEFT join customers cs on o.customer_id = cs.id
LEFT join employees em on o.employee_id = em.employee_id
LEFT join shippers sh on o.shipper_id = sh.id
LEFT join order_details od on o.id = od.order_id
RIGHT join products pr on od.product_id = pr.id
LEFT join categories cat on pr.category_id = cat.id
LEFT join suppliers su on pr.supplier_id = su.id
;
--
select count(*) 
from orders o
inner join customers cs on o.customer_id = cs.id
inner join employees em on o.employee_id = em.employee_id
inner join shippers sh on o.shipper_id = sh.id
inner join order_details od on o.id = od.order_id
inner join products pr on od.product_id = pr.id
inner join categories cat on pr.category_id = cat.id
inner join suppliers su on pr.supplier_id = su.id
WHERE em.employee_id > 3 and em.employee_id <= 10
;
--
select cat.name, count(*), avg(od.quantity) 
from orders o
inner join customers cs on o.customer_id = cs.id
inner join employees em on o.employee_id = em.employee_id
inner join shippers sh on o.shipper_id = sh.id
inner join order_details od on o.id = od.order_id
inner join products pr on od.product_id = pr.id
inner join categories cat on pr.category_id = cat.id
inner join suppliers su on pr.supplier_id = su.id
WHERE em.employee_id > 3 and em.employee_id <= 10
GROUP BY cat.name
HAVING avg(od.quantity) > 21
;
--
select cat.name, count(*), avg(od.quantity) 
from orders o
inner join customers cs on o.customer_id = cs.id
inner join employees em on o.employee_id = em.employee_id
inner join shippers sh on o.shipper_id = sh.id
inner join order_details od on o.id = od.order_id
inner join products pr on od.product_id = pr.id
inner join categories cat on pr.category_id = cat.id
inner join suppliers su on pr.supplier_id = su.id
WHERE em.employee_id > 3 and em.employee_id <= 10
group by cat.name
HAVING avg(od.quantity) > 21
order by count(*) DESC
LIMIT 4 offset 1
;