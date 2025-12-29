use session3;
update student
set email = "sonbui@gmail.com"
where studentId = 3;

update student
set dateOfBirthday = "2006-02-02"
where studentId = 2;

delete from student
where studentId = 5;

select * from student