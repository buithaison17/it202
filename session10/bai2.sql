/* Tạo một view tên view_user_post hiển thị danh sách các User 
với các cột: user_id(mã người dùng) và total_user_post 
(Tổng số bài viết mà từng người dùng đã đăng). */
create or replace view view_user_post as
select u.user_id, count(p.post_id) as total_user_post from users u 
join posts p on p.user_id = u.user_id
group by u.user_id;

-- Tiến hành hiển thị lại view_user_post để kiểm chứng
select * from view_user_post; 

/* Kết hợp view view_user_post với bảng users để hiển thị các 
cột: full_name(họ tên) và  total_user_post (Tổng số bài viết mà từng 
người dùng đã đăng). */
select u.full_name, vup.total_user_post from view_user_post vup
join users u on u.user_id = vup.user_id;
