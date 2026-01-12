delimiter $$
create procedure getPostsOfUser(user_id int)
begin
	select p.post_id, p.content, p.created_at from posts p
    where p.user_id = user_id;
end $$
delimiter ;

call getPostsOfUser(3);
drop procedure getPostsOfUser;