create table classRoom (
	classRoomId char(10) primary key,
	classRoomName varchar(25) unique not null,
    studyYear date not null
);

create table Student(
	studentId char(10) primary key,
    fullName varchar(25) not null,
    dateOfBirthday date not null,
    classRoomId CHAR(10),
    foreign key (classRoomId) references classRoom(classRoomId)
);