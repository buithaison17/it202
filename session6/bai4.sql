create table products(
	productId int primary key,
    productName varchar(150),
    price decimal(10, 2)
);

create table orderItems(
	orderId int,
    productId int,
    quantity int,
    
    foreign key (orderId) references orders(orderId),
    foreign key (productId) references products(productId)
);

INSERT INTO products (productId, productName, price) VALUES
(1, 'Bút bi Thiên Long', 5000.00),
(2, 'Vở học sinh 200 trang', 15000.00),
(3, 'Thước kẻ 20cm', 8000.00),
(4, 'Bút chì 2B', 6000.00),
(5, 'Gôm tẩy', 4000.00),
(6, 'Hộp bút nhựa', 35000.00),
(7, 'Sách giáo khoa Toán', 120000.00),
(8, 'Sách giáo khoa Văn', 115000.00),
(9, 'Balo học sinh', 350000.00),
(10, 'Máy tính Casio FX-570', 650000.00);

INSERT INTO orderItems (orderId, productId, quantity) VALUES
(1, 1, 2),
(1, 3, 1),
(2, 2, 3),
(2, 5, 2),
(3, 4, 5),
(3, 6, 1),
(4, 7, 2),
(4, 8, 1),
(5, 9, 1),
(5, 10, 1);

-- Hiển thị mỗi sản phẩm đã bán được bao nhiêu sản phẩm
select p.productId, p.productName, ifnull(sum(oi.quantity), 0) from products p
left join orderItems oi on oi.productId = p.productId
group by p.productId, p.productName;

-- Tính doanh thu của từng sản phẩm
select p.productId, p.productName ,ifnull((sum(oi.quantity) * p.price), 0) as totalAmount 
from products p
left join orderItems oi on oi.productId = p.productId
group by p.productId, p.productName;

-- Chỉ hiển thị các sản phẩm có doanh thu > 5.000.000
 select p.productId, p.productName ,ifnull((sum(oi.quantity) * p.price), 0) as totalAmount 
from products p
left join orderItems oi on oi.productId = p.productId
group by p.productId, p.productName
having totalAmount > 5000000;