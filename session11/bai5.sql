delimiter $$
create procedure CalculateUserActivityScore(
	in user_id int, 
	out activity_score int, 
    out activity_level varchar(255)
)
begin
	declare post_count int default 0;
    declare comment_count int default 0;
    declare like_count int default 0;
    
    set post_count = (
		select count(*) from posts p
        where p.user_id = user_id
    );
    set comment_count = (
		select count(*) from messages
        where sender_id = user_id
    );
    set like_count = (
		select count(*) from likes l
        where l.user_id = user_id
    );
    
    set activity_score = post_count * 10 + comment_count * 5 + like_count * 3;
    if activity_score < 200 then set activity_level = "Bình thường";
    elseif activity_score < 500 then set activity_level = "Tích cực";
    else set activity_level = "Rất tích cực";
    end if;
end $$
delimiter ;

call CalculateUserActivityScore(20, @activity_score, @activity_level);
select @activity_score, @activity_level;

drop procedure CalculateUserActivityScore;