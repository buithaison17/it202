create table student (
	studentId int primary key auto_increment,
    studentName varchar(25) not null,
    email varchar(25) not null unique
);

create table subject (
	subjectId int primary key auto_increment,
    subjectName varchar(25),
    credit int,
    
    check(credit > 0)
);

create table score (
	scoreId int primary key auto_increment,
    studentId int,
    subjectId int,
    scoreProgress decimal(4, 2),
    totalScore decimal(4, 2)
);