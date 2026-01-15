create table comments(
	comment_id int primary key auto_increment,
    post_id int not null,
    user_id int not null,
    content text not null,
    created_at datetime,
    
    foreign key(post_id) references posts(post_id),
    foreign key(user_id) references users(user_id)
);

alter table posts
add column comments_count int default 0;

delimiter $$
create procedure sp_post_comment(
	post_id_in int,
    user_id_in int,
    content_in text,
    error_test int
)
begin
	start transaction;
    insert into comments(post_id, user_id, content)
    values(post_id_in, user_id_in, content_in);
    savepoint after_insert;
    
    if error_test = 1 then
		update posts
		set comments_count = comments_count + 1
		where post_id = 9999;
        rollback to after_insert;
	else
		update posts
		set comments_count = comments_count + 1
		where post_id = post_id_in;
	end if;
    commit;
end $$
delimiter ;

drop procedure sp_post_comment;

-- Comment thành công 
call sp_post_comment(1, 1, 'Comment OK', 0);
-- Comment lỗi
call sp_post_comment(1, 1, 'Comment rollback update', 1);