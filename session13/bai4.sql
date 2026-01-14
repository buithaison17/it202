create table post_history(
	history_id int primary key auto_increment,
	post_id int ,
    old_content text,
    new_content text,
    changed_at datetime,
    changed_by_user_id int,
    
    foreign key(post_id) references posts(post_id) on delete cascade
);

-- Trigger trước khi update posts
delimiter $$
create trigger triggerBeforeUpdatePosts
before update on posts
for each row
begin
	declare old_content text;
    select content into old_content from posts
    where post_id = old.post_id;
    
    if old_content <> new.content then
		insert into post_history(post_id, old_content, new_content, changed_at, changed_by_user_id)
        values(old.post_id, old_content, new.content, now(), old.user_id);
    end if;
end $$
delimiter ; 

-- Cập nhật dữ liệu 
update posts
set content = "Hello world"
where post_id = 1;

select * from posts;

select * from post_history;

drop trigger triggerBeforeUpdatePosts;