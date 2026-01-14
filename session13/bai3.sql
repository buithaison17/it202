delimiter $$
create trigger triggerBeforInsertLikes
before insert on likes
for each row
begin
	declare user_id_of_post int;
    -- Tìm người đăng bài 
	select user_id into user_id_of_post from posts
    where post_id = new.post_id;
    
    -- Kiểm tra không cho phép like bài đăng của chính mình
    if new.user_id = user_id_of_post
		then signal sqlstate "45000" set message_text = "Không được like bài viết của chính mình"; 
	end if;
end $$
delimiter ;
drop trigger triggerBeforInsertLikes;
-- Like bài viết của chính mình 
insert into likes(user_id, post_id, liked_at) values
(2, 3, now());

-- Like bài viết hợp lệ
insert into likes(user_id, post_id, liked_at) values
(3, 1, now()); 

-- Trigger sau khi update likes
delimiter $$
create trigger triggerAfterUpdateLikes
after update on likes
for each row
begin
	-- Giảm like bài viết cũ
	update posts
    set like_count = like_count - 1
    where post_id = old.post_id;
	
    -- Tăng like bài viết mới
    update posts
    set like_count = like_count + 1
    where post_id = new.post_id;
end $$
delimiter ;

drop trigger triggerAfterUpdateLikes;

-- Cập nhật like
update likes
set post_id = 3
where like_id = 2;

select * from posts;
select * from user_statistics;