create table users (
	userId int primary key auto_increment,
    fullName varchar(25) not null,
    email varchar(25) not null unique,
	role enum('teacher', 'student')
);

create table enrollment (
    enrollmentId int primary key auto_increment,
    userId int,
    subjectId int,
    
    foreign key (userId) references users(userId),
    foreign key (subjectId) references subject(subjectId)
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

alter table score
add constraint foreign key (studentId) references users(userId)