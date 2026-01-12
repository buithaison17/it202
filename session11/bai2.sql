delimiter $$
create procedure CalculatePostLikes(in post_id int, out total_likes int)
begin
	set total_likes = (
		select count(*) from likes l
        where l.post_id = post_id
    );
end $$
delimiter ;

call CalculatePostLikes(101, @total_likes);
select @total_likes;

drop procedure CalculatePostLikes;