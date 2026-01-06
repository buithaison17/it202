create table products(
	productId int primary key,
    productName varchar(150),
    price decimal(10, 2)
);

create table orderItems(
	orderId int,
    productId int,
    quantity int,
    
    primary key(orderId , productId),
    foreign key(orderId) references orders(orderId),
    foreign key(productId) references products(productId)
);

INSERT INTO products (productId, productName, price) VALUES
(1, 'Laptop Dell Inspiron', 18500000.00),
(2, 'Chuột không dây Logitech', 450000.00),
(3, 'Bàn phím cơ Keychron', 2200000.00),
(4, 'Màn hình Samsung 24 inch', 4200000.00),
(5, 'Tai nghe Sony WH-1000XM5', 8900000.00),
(6, 'USB Kingston 64GB', 250000.00),
(7, 'Ổ cứng SSD Samsung 1TB', 3100000.00),
(8, 'Webcam Logitech C920', 1800000.00),
(9, 'Máy in HP LaserJet', 5600000.00),
(10, 'Loa Bluetooth JBL', 2300000.00);

INSERT INTO orderItems (orderId, productId, quantity) VALUES
(1, 1, 1),
(1, 2, 2),
(2, 3, 1),
(3, 4, 1),
(3, 5, 1),
(4, 6, 3),
(5, 7, 1),
(6, 8, 2),
(7, 9, 1),
(8, 10, 2);

select * from products p
where p.productId in (
	select oi.productId from orderItems oi
);