use session3;

insert into student(studentId ,fullName, dateOfBirthday, email)
values 
	(4, "Quang Huy", "2006-02-02", "quanghuy@gmail.com");
    
insert into enrollment(studentId, subjectId, enrollDate)
values
	(4, 2, current_timestamp()),
    (4, 3, current_timestamp());
    
insert into score(studentId, subjectId, midScore, finalScore)
values
	(4, 2, 3, 5),
    (4, 3, 9, 10);

insert into score(studentId, subjectId, midScore, finalScore)
values
	(4, 2, 3, 2);
    
delete from score
where studentId = 4 and subjectId = 2;

select st.fullName `Họ và tên`, s.subjectName `Môn học`, midScore, finalScore from score sc
JOIN student st ON st.studentId = sc.studentId
JOIN subject s ON s.subjectId = sc.subjectId;
