use session3;

create table subject(
	subjectId int primary key auto_increment,
    subjectName varchar(25),
    credit int,
    
    check(credit > 0)
);

insert into subject (subjectName, credit)
values  ("Lập trình C", 3),
		("Lập trình cơ bản", 4);

update subject
set credit = 2
where subjectId = 2;

select * from subject