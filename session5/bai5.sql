INSERT INTO orders (orderId, customerId, totalAmount, orderDate, status) VALUES
(11, 1, 1550000.00, '2025-02-01', 'completed'),
(12, 2, 980000.00,  '2025-02-02', 'pending'),
(13, 3, 2650000.00, '2025-02-03', 'completed'),
(14, 4, 1200000.00, '2025-02-04', 'cancelled'),
(15, 5, 3450000.00, '2025-02-05', 'completed'),
(16, 6, 1750000.00, '2025-02-06', 'pending'),
(17, 7, 2900000.00, '2025-02-07', 'completed'),
(18, 8, 860000.00,  '2025-02-08', 'completed'),
(19, 9, 2100000.00, '2025-02-09', 'pending'),
(20, 10, 4250000.00, '2025-02-10', 'completed');

select * from orders
where status = "completed" or status = "pending"
limit 5 offset 0;

select * from orders
where status = "completed" or status = "pending"
limit 5 offset 5;

select * from orders
where status = "completed" or status = "pending"
limit 5 offset 10;