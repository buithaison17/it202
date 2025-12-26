create table Student (
	studentId char(10) primary key,
    studentName varchar(25) not null
);

create table Subject (
	subjectId char(10) primary key,
    subjectName varchar(25) not null,
    credit int not null,
    
    check(credit > 0)
)