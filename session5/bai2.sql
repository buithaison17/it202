create table customers(
	customerId int primary key,
    fullName varchar(255) not null,
    email varchar(255) not null unique,
    city varchar(255) not null,
    status enum("active", "inactive")
);

insert into customers(customerId, fullName, email, city, status) values
(1, 'Nguyễn Văn An', 'an.nguyen@example.com', 'Hà Nội', 'active'),
(2, 'Trần Thị Bình', 'binh.tran@example.com', 'TP. Hồ Chí Minh', 'active'),
(3, 'Lê Văn Cường', 'cuong.le@example.com', 'Đà Nẵng', 'active'),
(4, 'Phạm Thị Dung', 'dung.pham@example.com', 'Hà Nội', 'inactive'),
(5, 'Hoàng Văn Em', 'em.hoang@example.com', 'Cần Thơ', 'active'),
(6, 'Vũ Thị Hoa', 'hoa.vu@example.com', 'TP. Hồ Chí Minh', 'inactive'),
(7, 'Đặng Văn Khoa', 'khoa.dang@example.com', 'Hải Phòng', 'active'),
(8, 'Bùi Thị Lan', 'lan.bui@example.com', 'Hà Nội', 'active'),
(9, 'Ngô Văn Minh', 'minh.ngo@example.com', 'Nghệ An', 'active'),
(10, 'Phan Thị Ngọc', 'ngoc.phan@example.com', 'TP. Hồ Chí Minh', 'active');

-- Lấy khách hàng đang ở HN 
select * from customers
where city like "ha noi%";

-- Lấy khách hàng đang hoạt động ở HCM
select * from customers
where city like "tp. ho chi minh%" and status = "active";

-- Sắp xếp theo tên từ A đến Z
select * from customers
order by fullName asc;  