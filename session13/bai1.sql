create database session13;
use session13;

create table users(
	user_id int primary key auto_increment,
    username varchar(50) not null unique,
    email varchar(100) not null unique,
    created_at date,
    follower_count int default 0,
    post_count int default 0
);

create table posts(
	post_id int primary key auto_increment,
    user_id int,
    content text,
    created_at datetime,
    like_count int default 0,
    
    foreign key(user_id) references users(user_id)
);

insert into users (username, email, created_at) values
('alice', 'alice@example.com', '2025-01-01'),
('bob', 'bob@example.com', '2025-01-02'),
('charlie', 'charlie@example.com', '2025-01-03');

/* 
	Trigger AFTER INSERT trên posts: Khi thêm bài đăng mới, tăng post_count của người dùng
    tương ứng lên 1.
*/
delimiter $$
create trigger triggerAfterInsertPost
after insert on posts
for each row
begin
	declare count int default 0;
    select count(*) into count from posts
    where user_id = new.user_id;
    
    update users
    set post_count = count
    where user_id = new.user_id;
end $$
delimiter ;

drop trigger triggerUpdateUser;

insert into posts (user_id, content, created_at) values
(1, 'Hello world from Alice!', '2025-01-10 10:00:00'),
(1, 'Second post by Alice', '2025-01-10 12:00:00'),
(2, 'Bob first post', '2025-01-11 09:00:00'),
(3, 'Charlie sharing thoughts', '2025-01-12 15:00:00');
select * from users;

/* 
	Trigger AFTER DELETE trên posts: Khi xóa bài đăng, giảm post_count của người dùng 
    tương ứng đi 1.
*/
delimiter $$
create trigger triggerAfterDeletePost
after delete on posts
for each row
begin
	update users
    set post_count = post_count - 1
    where user_id = old.user_id;
end $$
delimiter ;

delete from posts
where post_id = 2;

select * from users;

drop trigger triggerAfterDeletePost;