/*
 * DATABASE SETUP - SESSION 15 EXAM
 * Database: StudentManagement
 */

DROP DATABASE IF EXISTS StudentManagement;
CREATE DATABASE StudentManagement;
USE StudentManagement;

-- =============================================
-- 1. TABLE STRUCTURE
-- =============================================

-- Table: Students
CREATE TABLE Students (
    StudentID CHAR(5) PRIMARY KEY,
    FullName VARCHAR(50) NOT NULL,
    TotalDebt DECIMAL(10,2) DEFAULT 0
);

-- Table: Subjects
CREATE TABLE Subjects (
    SubjectID CHAR(5) PRIMARY KEY,
    SubjectName VARCHAR(50) NOT NULL,
    Credits INT CHECK (Credits > 0)
);

-- Table: Grades
CREATE TABLE Grades (
    StudentID CHAR(5),
    SubjectID CHAR(5),
    Score DECIMAL(4,2) CHECK (Score BETWEEN 0 AND 10),
    PRIMARY KEY (StudentID, SubjectID),
    CONSTRAINT FK_Grades_Students FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    CONSTRAINT FK_Grades_Subjects FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- Table: GradeLog
CREATE TABLE GradeLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID CHAR(5),
    OldScore DECIMAL(4,2),
    NewScore DECIMAL(4,2),
    ChangeDate DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- =============================================
-- 2. SEED DATA
-- =============================================

-- Insert Students
INSERT INTO Students (StudentID, FullName, TotalDebt) VALUES 
('SV01', 'Ho Khanh Linh', 5000000),
('SV03', 'Tran Thi Khanh Huyen', 0);

-- Insert Subjects
INSERT INTO Subjects (SubjectID, SubjectName, Credits) VALUES 
('SB01', 'Co so du lieu', 3),
('SB02', 'Lap trinh Java', 4),
('SB03', 'Lap trinh C', 3);

-- Insert Grades
INSERT INTO Grades (StudentID, SubjectID, Score) VALUES 
('SV01', 'SB01', 8.5), -- Passed
('SV03', 'SB02', 3.0); -- Failed

-- End of File
/* Câu 1 (Trigger - 2đ): Nhà trường yêu cầu điểm số (Score) nhập vào hệ thống phải 
luôn hợp lệ (từ 0 đến 10). Hãy viết một Trigger có tên tg_CheckScore chạy trước khi 
thêm (BEFORE INSERT) dữ liệu vào bảng Grades*/

delimiter $$
create trigger tg_CheckScore
before insert on grades
for each row
begin
	if new.score < 0 then 
		set new.score = 0;
    end if;
    if new.score > 10 then
		set new.score = 10;
	end if;
end $$
delimiter ;

drop trigger tg_CheckScore;
insert into grades(studentId, subjectId, score) values("sv01", "sb02", -1);
select * from grades;

/* Câu 2 (Transaction - 2đ): Viết một đoạn script sử dụng Transaction để thêm một sinh 
viên mới. Yêu cầu đảm bảo tính trọn vẹn "All or Nothing" của dữ liệu: */
start transaction;
insert into students(studentId, fullName, TotalDebt)
values("SV02", "Ha Bich Ngoc", 5000000);
commit; 
select * from students;

/* Câu 3 (Trigger - 1.5đ): Để chống tiêu cực trong thi cử, mọi hành động sửa đổi điểm 
số cần được ghi lại. Hãy viết Trigger tên tg_LogGradeUpdate chạy sau khi cập nhật 
(AFTER UPDATE) trên bảng Grades*/ 
delimiter $$
create trigger tg_LogGradeUpdate
after update on grades
for each row
begin
	if old.score <> new.score then
		insert into gradelog(studentId, oldScore, newScore, changeDate)
        values(old.studentId, old.score, new.score, now());
    end if;
end $$
delimiter ; 

drop trigger tg_LogGradeUpdate;

select * from grades;
update grades
set score = 2
where studentId = "sv01" and subjectId = "sb02";
select * from gradelog;

/* Câu 4 (Transaction & Procedure cơ bản - 1.5đ): Viết một Stored Procedure đơn giản 
tên sp_PayTuition thực hiện việc đóng học phí cho sinh viên 'SV01' với số tiền 
2,000,000 */
delimiter $$
create procedure sp_PayTuition(
	studentIdIn char(5),
    money decimal(10, 2)
)
begin
	start transaction;
    -- Đóng học phí 
    update students
    set totalDebt = totalDebt - money
    where studentId = studentIdIn;
    -- Kiểm tra sau khi trừ
    if (
		select totalDebt from students
        where studentId = studentIdIn
    ) < 0 then rollback;
    else commit;
    end if;
end $$
delimiter ;

drop procedure sp_PayTuition;
call sp_PayTuition("sv01", 4000000);
select * from students;

-- câu 5
delimiter $$
create trigger tg_PreventPassUpdate
before update on grades
for each row
begin
	if old.score >= 4 then
		signal sqlstate "45000" 
        set message_text = "Sinh viên có điểm >= 4 không thể sửa điểm";
	end if;
end $$
delimiter ; 

drop trigger tg_PreventPassUpdate;
update grades
set score = 10
where studentId = "sv01";
select * from grades;

/* Câu 6 (Stored Procedure & Transaction - 1.5đ): Viết một Stored Procedure tên 
sp_DeleteStudentGrade nhận vào p_StudentID và p_SubjectID. Thủ tục này thực hiện 
việc sinh viên xin hủy môn học nhưng phải đảm bảo an toàn dữ liệu */
delimiter $$
create procedure sp_DeleteStudentGrade(
	p_StudentID char(5),
    p_SubjectID char(5)    
)
begin
	declare count_check int;
    declare oldScore decimal(10, 2);
	start transaction;
    -- Kiểm tra dữ liệu cần xóa xem có tồn tại
    select count(*) into count_check from grades
    where studentId = p_StudentID and subjectId = p_SubjectID;
    if count_check < 1 then
		rollback;
	else
		-- Lấy điểm cũ 
        select score into oldScore from grades
        where studentId = p_StudentID and subjectId = p_SubjectID;
		-- Lưu log
        insert into gradelog(studentId, oldScore, newScore, changeDate)
		values(p_StudentID, oldScore, null, now());
		-- Xóa điểm 
		delete from grades
        where studentId = p_StudentID and subjectId = p_SubjectID;
        commit;
    end if;
end $$
delimiter ;

drop procedure sp_DeleteStudentGrade;
call sp_DeleteStudentGrade("sv01", "sb02");
select * from grades;