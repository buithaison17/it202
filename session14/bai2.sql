create table likes(
	like_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    
    foreign key(user_id) references users(user_id),
    foreign key(post_id) references posts(post_id)
);

alter table posts
add column likes_count int default 0;

-- Like thành công
start transaction;
insert into likes(user_id, post_id) values(1, 1);
update posts
set likes_count = likes_count + 1
where post_id = 1;
commit;

-- Like bị lỗi
start transaction;
insert into likes(user_id, post_id) values(1, 1);
update posts
set likes_count = likes_count + 1
where post_id = 1;
rollback;

select * from likes;
select * from posts;