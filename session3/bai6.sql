use session3;

create table score (
	studentId int,
    subjectId int,
    midScore decimal(4, 2),
    finalScore decimal(4 ,2)
);

insert into score (studentId, subjectId, midScore, finalScore)
values 
	(1, 1, 8.0, 7),
    (2, 1, 8.0, 10),
    (3, 1, 7.0, 8);
    
update score
set finalScore = 2
where studentId = 2 and subjectId = 2;
    
select * from score;

select * from score
where finalScore >= 8;



