create database session7;
use session7;

create table customers(
	customerId int primary key,
    customerName varchar(150) not null,
    email varchar(50) unique
);

create table orders(
	orderId int primary key,
    customerId int,
    orderDate date,
    totalAmount decimal(10, 2),
    
    foreign key(customerId) references customers(customerId)
);

INSERT INTO customers (customerId, customerName, email) VALUES
(1, 'Nguyễn Văn An', 'an.nguyen@gmail.com'),
(2, 'Trần Thị Bình', 'binh.tran@gmail.com'),
(3, 'Lê Văn Cường', 'cuong.le@gmail.com'),
(4, 'Phạm Thị Dung', 'dung.pham@gmail.com'),
(5, 'Hoàng Văn Em', 'em.hoang@gmail.com'),
(6, 'Vũ Thị Hoa', 'hoa.vu@gmail.com'),
(7, 'Đặng Văn Hùng', 'hung.dang@gmail.com'),
(8, 'Bùi Thị Lan', 'lan.bui@gmail.com'),
(9, 'Đỗ Văn Minh', 'minh.do@gmail.com'),
(10, 'Ngô Thị Nga', 'nga.ngo@gmail.com');

INSERT INTO orders (orderId, customerId, orderDate, totalAmount) VALUES
(1, 1, '2025-01-01', 2500000.00),
(2, 2, '2025-01-01', 1800000.00),
(3, 3, '2025-01-02', 3200000.00),
(4, 1, '2025-01-03', 4500000.00),
(5, 4, '2025-01-03', 1200000.00),
(6, 5, '2025-01-04', 9800000.00),
(7, 6, '2025-01-05', 1500000.00),
(8, 2, '2025-01-05', 6700000.00),
(9, 7, '2025-01-06', 2200000.00),
(10, 3, '2025-01-06', 5400000.00);

select * from customers c
where c.customerId in (
	select o.customerId from orders o
);