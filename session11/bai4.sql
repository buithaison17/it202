delimiter $$
create procedure CreatePostWithValidation(
	in user_id_in int,
    in content_in text,
    out result_message varchar(255)
)
begin
	if length(content_in) < 5 then set result_message = "Nội dung quá ngắn";
    else
		insert into posts(user_id, content) values(user_id_in, content_in);
		set result_message = "Thêm bài viết thành công"; 
    end if;
end $$
delimiter ;

call CreatePostWithValidation(1, "Sơn Bùi", @result);

drop procedure CreatePostWithValidation;