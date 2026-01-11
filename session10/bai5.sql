select u.user_id, u.username, u.hometown, p.post_id, p.content from users u
join posts p on p.user_id = u.user_id
where u.hometown like "%ha noi%"
order by u.user_id desc
limit 10;

explain analyze select u.user_id, u.username, u.hometown, p.post_id, p.content from users u
join posts p on p.user_id = u.user_id
where u.hometown like "%ha noi%"
order by u.user_id desc
limit 10;

create index idx_hometown on users(hometown);
drop index idx_hometown on users;

/* Việc sử dụng chỉ mục idx_hometown giúp truy vấn tránh quét toàn bộ bảng,
giảm đáng kể thời gian thực thi và nâng cao hiệu năng khi lọc dữ liệu theo cột hometown */