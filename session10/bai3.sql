/* Viết câu truy vấn Select tìm tất cả những User ở Hà Nội. 
Sử dụng EXPLAIN ANALYZE để kiểm tra truy vấn thực tế. */
explain analyze select * from users where hometown = "hà nội";

 create index idx_hometown on users(hometown);
 
drop index idx_hometown on users;