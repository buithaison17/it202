create table Student (
	studentId char(10) primary key,
    fullName varchar(25) not null
);

create table Subject (
	subjectId char(10) primary key,
    subjectName varchar(50) not null,
    credit int,
    
    check(credit > 0)
);

create table Enrollment (
	enrollmentId char(10) primary key,
    studentId char(10),
    subjectId char(10),
    
    foreign key (studentId) references Student(studentId),
    foreign key (subjectId) references Subject(subjectid)
);