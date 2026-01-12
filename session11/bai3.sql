delimiter $$
create procedure CalculateBonusPoints(
	in user_id_in int,
    inout bonus_point int
)
begin
	declare total_posts int;
    
    set total_posts = (
		select count(*) from posts p
        where p.user_id = user_id_in
    );
    
    if total_posts >= 20 then set bonus_point = bonus_point + 100;
    elseif total_posts >= 10 then set bonus_point = bonus_point + 50;
    end if;
end $$
delimiter ;

set @bonus_point = 0;
call CalculateBonusPoints(1, @bonus_point);
select @bonus_point;

drop procedure CalculateBonusPoints;