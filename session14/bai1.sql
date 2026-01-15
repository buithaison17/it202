create database social_network;
use social_network;

create table users(
	user_id int primary key auto_increment,
    username varchar(50) not null,
    posts_count int default 0
);

create table posts(
	post_id int primary key auto_increment,
    user_id int not null,
    content text,
    created_at datetime default current_timestamp,

	foreign key(user_id) references users(user_id)
);

insert into users(username) values ("sonbui");

-- Trường hợp thành công
start transaction;
insert into posts(user_id, content) values(1, "đang học transaction");
update users
set posts_count = posts_count + 1
where user_id = 1;
commit;

-- Trường hợp lỗi
start transaction;
insert into posts(user_id, content) values(1, "đang học transaction");
update users
set posts_count = posts_count + 1
where user_id = 2;
rollback;

select * from posts; 
select * from users;