delimiter $$
create procedure NotifyFriendsOnNewPost(user_id_in int, content_in text)
begin
	declare temp_friend_id int;
    declare done int default 0;
    declare notification_content varchar(255);
    
    -- Lấy danh sách bạn bè
    declare friend_cursor cursor for
    select 
		case
			when f.user_id = user_id_in then f.friend_id
            else f.user_id
		end
    from friends f
    where f.status = "accepted"
    and (f.friend_id = user_id_in or f.user_id = user_id_in);
    
    -- Fetch đến khi hết dữ liệu thì set done = 1 để thoát vòng lặp
    declare continue handler for not found set done = 1;
    
    -- Thêm bài viết 
    insert into posts(user_id, content)
    values(user_id_in, content_in);
    
    -- Tạo nội dung cho thông báo 
    select full_name into notification_content from users
    where user_id = user_id_in;
    set notification_content = concat(notification_content, " đã đăng một bài viết mới");
    
    -- Duyệt qua danh sách friend_cursor
    open friend_cursor;
    read_loop: loop
		-- Lấy ID trong danh sách 
		fetch friend_cursor into temp_friend_id;
        -- Kiểm tra nếu duyệt hết thì thoát
        if done = 1 then leave read_loop;
        end if;
        -- Kiểm tra để không tự gửi cho chính mình
        if temp_friend_id <> user_id_in then
			insert into notifications(user_id, type, content)
            values(temp_friend_id, "new_post", notification_content);
		end if;
	end loop;
    close friend_cursor;
end $$
delimiter ;

select * from posts
order by created_at desc;

select * from notifications
order by created_at desc;

call NotifyFriendsOnNewPost(1, "Lập trình C");

drop procedure NotifyFriendsOnNewPost;