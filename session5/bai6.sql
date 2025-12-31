INSERT INTO products (productId, productName, price, stock, soldQuantity, status) VALUES
(21, 'Điện thoại Xiaomi Redmi Note 12', 5200000.00, 30, 12, 'active'),
(22, 'Điện thoại Oppo Reno 8', 8900000.00, 25, 9, 'active'),
(23, 'Laptop Lenovo IdeaPad', 16500000.00, 15, 6, 'active'),
(24, 'Laptop Acer Aspire 5', 15800000.00, 12, 4, 'active'),
(25, 'Máy tính bảng iPad Gen 9', 8200000.00, 20, 7, 'active'),
(26, 'Tai nghe Bluetooth Sony WF', 3200000.00, 18, 5, 'active'),
(27, 'Chuột Gaming Razer', 1500000.00, 35, 14, 'active'),
(28, 'Bàn phím Logitech K380', 890000.00, 40, 18, 'active'),
(29, 'Màn hình Dell 24 inch', 4500000.00, 14, 6, 'active'),
(30, 'Webcam Full HD Logitech', 2100000.00, 22, 8, 'active'),
(31, 'Loa Bluetooth Sony XB', 2600000.00, 28, 11, 'active'),
(32, 'Sạc dự phòng Anker 20000mAh', 1200000.00, 50, 20, 'active'),
(33, 'Router Wifi Tenda AC10', 950000.00, 26, 9, 'active'),
(34, 'Ổ cứng SSD Kingston 500GB', 1800000.00, 32, 13, 'active'),
(35, 'Ổ cứng HDD Seagate 1TB', 1500000.00, 45, 17, 'active'),
(36, 'Máy in HP LaserJet', 4200000.00, 10, 3, 'inactive'),
(37, 'Camera an ninh Xiaomi', 980000.00, 38, 16, 'active'),
(38, 'Smart TV Samsung 43 inch', 10500000.00, 8, 2, 'active'),
(39, 'Nồi chiên không dầu Philips', 3900000.00, 16, 6, 'active'),
(40, 'Máy lọc không khí Sharp', 6200000.00, 14, 5, 'active');

select * from products
where status = "active" and price between 1000000 and 3000000
order by price asc
limit 10 offset 0;

select * from products
where status = "active" and price between 1000000 and 3000000
order by price asc
limit 10 offset 10;
