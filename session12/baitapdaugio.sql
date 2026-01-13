CREATE DATABASE StudentDB;
USE StudentDB;
-- 1. Bảng Khoa
CREATE TABLE Department (
    DeptID CHAR(5) PRIMARY KEY,
    DeptName VARCHAR(50) NOT NULL
);

-- 2. Bảng SinhVien
CREATE TABLE Student (
    StudentID CHAR(6) PRIMARY KEY,
    FullName VARCHAR(50),
    Gender VARCHAR(10),
    BirthDate DATE,
    DeptID CHAR(5),
    FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);

-- 3. Bảng MonHoc
CREATE TABLE Course (
    CourseID CHAR(6) PRIMARY KEY,
    CourseName VARCHAR(50),
    Credits INT
);

-- 4. Bảng DangKy
CREATE TABLE Enrollment (
    StudentID CHAR(6),
    CourseID CHAR(6),
    Score FLOAT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);
INSERT INTO Department VALUES
('IT','Information Technology'),
('BA','Business Administration'),
('ACC','Accounting');

INSERT INTO Student VALUES
('S00001','Nguyen An','Male','2003-05-10','IT'),
('S00002','Tran Binh','Male','2003-06-15','IT'),
('S00003','Le Hoa','Female','2003-08-20','BA'),
('S00004','Pham Minh','Male','2002-12-12','ACC'),
('S00005','Vo Lan','Female','2003-03-01','IT'),
('S00006','Do Hung','Male','2002-11-11','BA'),
('S00007','Nguyen Mai','Female','2003-07-07','ACC'),
('S00008','Tran Phuc','Male','2003-09-09','IT');

INSERT INTO Course VALUES
('C00001','Database Systems',3),
('C00002','C Programming',3),
('C00003','Microeconomics',2),
('C00004','Financial Accounting',3);

INSERT INTO Enrollment VALUES
('S00001','C00001',8.5),
('S00001','C00002',7.0),
('S00002','C00001',6.5),
('S00003','C00003',7.5),
('S00004','C00004',8.0),
('S00005','C00001',9.0),
('S00006','C00003',6.0),
('S00007','C00004',7.0),
('S00008','C00001',5.5),
('S00008','C00002',6.5);


-- Câu 1:  Tạo View View_StudentBasic hiển thị: StudentID, FullName , DeptName. Sau đó truy vấn toàn bộ View_StudentBasic; 
create or replace view view_studentBasic as
select s.studentId, s.fullName, d.deptName from student s
join department d on d.deptId = s.deptId;
select * from view_studentBasic;

-- Câu 2: Tạo Regular Index cho cột FullName của bảng Student.
create index idx_fullName_user on student(fullName); 

-- Câu 3: Viết Stored Procedure GetStudentsIT
delimiter $$
create procedure GetStudentsIT()
begin
	select s.studentId, s.fullName, deptName from student s
    join department d on d.deptId = s.deptId
    where d.deptId = "IT";
end $$
delimiter ;
call GetStudentsIT();
drop procedure GetStudentsIT;

-- Câu 4: Tạo View View_StudentCountByDept hiển thị: DeptName, TotalStudents (số sinh viên mỗi khoa).
create or replace view View_StudentCountByDept as
select d.deptName, count(s.studentId) as TotalStudents from department d
join student s on s.deptId = d.deptId
group by d.deptId;
select * from View_StudentCountByDept;

-- Câu 5: Viết Stored Procedure GetTopScoreStudent 
delimiter $$
create procedure GetTopScoreStudent(courseId_in varchar(6))
begin
	select s.studentId, s.fullName, c.courseName, e.score from student s
	join enrollment e on e.studentId = s.studentId
	join course c on c.courseId = e.courseId
	where c.courseId = courseId_in
	having e.score = (
		select max(score) from enrollment
		where courseId = courseId_in
	);
end $$
delimiter ;
call GetTopScoreStudent("C00001");
drop procedure GetTopScoreStudent;

-- Bài 6:
create or replace view View_IT_Enrollment_DB as
select s.studentId, s.fullName, d.deptName, e.courseId, e.score from student s
join department d on d.deptId = s.deptId
join enrollment e on e.studentId = s.studentId
where e.courseId = "C00001" and d.deptId = "IT"
with check option;

delimiter $$
create procedure UpdateScore_IT_DB(
	studentId_in varchar(6), 
    inout newScore float
)
begin
	if newScore > 10 then set newScore = 10;
    end if;
	
    update View_IT_Enrollment_DB
	set score = newScore
	where studentId = studentId_in;
end $$
delimiter ;

select * from View_IT_Enrollment_DB;
set @newScore = 15;
call UpdateScore_IT_DB("S00001", @newScore);
select @newScore;
drop procedure UpdateScore_IT_DB;