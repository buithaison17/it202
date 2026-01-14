create table likes(
	like_id int primary key auto_increment,
    user_id int,
    post_id int,
    liked_at datetime,
    
    foreign key(user_id) references users(user_id),
    foreign key(post_id) references posts(post_id)
);

insert into likes (user_id, post_id, liked_at) VALUES
(2, 1, '2025-01-10 11:00:00'),
(3, 1, '2025-01-10 13:00:00'),
(1, 3, '2025-01-11 10:00:00'),
(3, 4, '2025-01-12 16:00:00');

-- Tạo trigger được khi insert likes để tự động cập nhật like_count 
delimiter $$
create trigger triggerAfterInsertLikes
after insert on likes
for each row
begin
	declare like_count int default 0;
    
    select count(*) into like_count from likes
    where post_id = new.post_id;
    
    update posts p
    set p.like_count = like_count
    where p.post_id = new.post_id;
end $$
delimiter ;

drop trigger triggerAfterInsertLikes;

-- Trigger sau khi xóa like
delimiter $$
create trigger triggerAfterDeleteLikes
after delete on likes
for each row
begin
	update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
end $$
delimiter ; 

drop trigger triggerAfterDeleteLikes;

/*
	Tạo một View tên user_statistics hiển thị: user_id, username, post_count, total_likes 
    (tổng like_count của tất cả bài đăng của người dùng đó).
*/
create or replace view user_statistics as
select u.username, u.post_count, sum(p.like_count) as total_likes from users u
join posts p on p.user_id = u.user_id
group by u.username;

select * from user_statistics;

-- Thực hiện thêm/xóa một lượt thích và kiểm chứng:
insert into likes (user_id, post_id, liked_at) VALUES (2, 4, NOW()); 
delete from likes
where like_id = 5;
select * from posts;