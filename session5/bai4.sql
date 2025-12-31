alter table products
add column soldQuantity int;

UPDATE products SET soldQuantity = 5  WHERE productId = 1;
UPDATE products SET soldQuantity = 3  WHERE productId = 2;
UPDATE products SET soldQuantity = 20 WHERE productId = 3;
UPDATE products SET soldQuantity = 15 WHERE productId = 4;
UPDATE products SET soldQuantity = 7  WHERE productId = 5;
UPDATE products SET soldQuantity = 2  WHERE productId = 6;
UPDATE products SET soldQuantity = 12 WHERE productId = 7;
UPDATE products SET soldQuantity = 40 WHERE productId = 8;
UPDATE products SET soldQuantity = 6  WHERE productId = 9;
UPDATE products SET soldQuantity = 4  WHERE productId = 10;

INSERT INTO products (productId, productName, price, stock, soldQuantity, status) VALUES
(11, 'Điện thoại iPhone 13', 18500000.00, 20, 8, 'active'),
(12, 'Điện thoại Samsung S22', 16500000.00, 18, 6, 'active'),
(13, 'Tai nghe AirPods Pro', 5200000.00, 25, 10, 'active'),
(14, 'Chuột không dây Logitech MX', 2100000.00, 30, 12, 'active'),
(15, 'Bàn phím cơ Keychron K6', 1900000.00, 22, 9, 'active'),
(16, 'Màn hình LG 27 inch', 6800000.00, 12, 4, 'active'),
(17, 'Laptop ASUS VivoBook', 17500000.00, 10, 5, 'inactive'),
(18, 'Ổ cứng HDD WD 2TB', 2300000.00, 40, 15, 'active'),
(19, 'Loa Bluetooth JBL Flip', 2800000.00, 28, 11, 'active'),
(20, 'Router Wifi TP-Link AX', 3500000.00, 16, 7, 'active');

-- Lấy 10 sản phẩm bán chạy nhất 
select * from products
order by soldQuantity desc
limit 10;

-- Lấy 5 sản phẩm bán chạy tiếp theo
select * from products
order by soldQuantity desc
limit 5 offset 10;

-- Hiển thị danh sách sản phẩm giá < 2.000.000, sắp xếp theo số lượng bán giảm dần
select * from products
where price < 2000000
order by price desc;
