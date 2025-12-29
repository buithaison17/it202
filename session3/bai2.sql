create database session3;
use session3;

create table student (
	studentId int primary key,
    fullName varchar(25) not null,
    dateOfBirthday date,
    email varchar(25) unique
);

insert into student (studentId, fullName, dateOfBirthday, email)
values 
		(5, "Trí Công", "2006-01-01", "tricong@gmail.com"),
		(1, "Bùi Thái Sơn", "2006-01-17","sonbui@gmail.com"),
        (2, "Trôn Việt Nam", "2006-01-01", "tron@gmail.com"),
        (3, "Kiên Chổi", "2006-01-01", "kienchoi@gmail.com")
        
        
