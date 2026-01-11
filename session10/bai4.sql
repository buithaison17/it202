explain analyze select post_id, content, created_at from posts where user_id = 1;

/* -> Index lookup on posts using posts_fk_users (user_id=1)  (cost=0.7 rows=2) 
(actual time=0.0507..0.0627 rows=2 loops=1)
  */

create index idx_created_at_user_id on posts(user_id, created_at);
/* 3	89	09:32:41	explain analyze select
 post_id, content, created_at from posts where user_id = 1	1 row(s) returned	0.000 sec / 0.000 sec */
 
-- Tìm kiếm theo idx_created_at_user_id nhanh hơn

explain analyze select * from users
where email = "an@gmail.com";

/* Trước khi tạo index -> Rows fetched before execution 
 (cost=0..0 rows=1) (actual time=400e-6..500e-6 rows=1 loops=1) */
 
 create index idx_email on users(email);
 
 /* Sau khi tạo index -> Rows fetched before execution 
 (cost=0..0 rows=1) (actual time=200e-6..300e-6 rows=1 loops=1) */
 
 -- Tạo index sẽ giúp tìm kiếm nhanh hơn
 
drop index idx_created_at_user_id on posts;
drop index idx_email on users;