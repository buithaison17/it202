use session3;

create table enrollment(
	studentId int,
    subjectId int,
	enrollDate timestamp,
    
    primary key (studentId, subjectId),
    foreign key (studentId) references student(studentId),
    foreign key (subjectId) references subject(subjectId)
);

insert into enrollment(studentId, subjectId, enrollDate)
values (1, 2, current_timestamp()),
		(2, 3, current_timestamp());

select * from enrollment;

select * from enrollment
where studentId = 1;