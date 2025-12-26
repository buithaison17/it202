use session2;

create table teacher (
	teacherId int primary key auto_increment,
    teacherName varchar(25) not null,
    email varchar(25) not null unique
);

create table Subject (
	subjectId int primary key auto_increment,
    subjectName varchar(25) not null,
    teacherId int,
    
    foreign key(teacherId) references teacher(teacherId)
)