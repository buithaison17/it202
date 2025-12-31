create database session5;
use session5;

create table products(
	productId int primary key,
    productName varchar(255) not null,
    price decimal(10,2) not null,
    stock int not null,
    status enum("active", "inactive") not null,
    
    check (price >= 0),
    check(stock >= 0)
);

insert into products(productId, productName, price, stock, status)
values
	(1, 'Laptop Dell Inspiron', 18500000.00, 10, 'active'),
	(2, 'Laptop HP Pavilion', 19500000.00, 8, 'active'),
	(3, 'Chuột Logitech M331', 450000.00, 50, 'active'),
	(4, 'Bàn phím cơ Redragon', 850000.00, 30, 'active'),
	(5, 'Màn hình Samsung 24 inch', 3200000.00, 15, 'active'),
	(6, 'Tai nghe Sony WH-1000XM4', 6500000.00, 5, 'inactive'),
	(7, 'Ổ cứng SSD Samsung 1TB', 2800000.00, 20, 'active'),
	(8, 'USB Kingston 64GB', 250000.00, 100, 'active'),
	(9, 'Webcam Logitech C920', 2200000.00, 12, 'inactive'),
	(10, 'Máy in Canon LBP2900', 4500000.00, 6, 'active');
    
select * from products
where status = "active" and price > 1000000
order by price desc;
