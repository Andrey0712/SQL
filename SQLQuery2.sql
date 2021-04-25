create table Departments (
Id int identity not null primary key,
Building int not null check(Building >0 and Building <=5),
Name nvarchar(100) not null check(len(name)>0) unique,

);
create table Doctors (
Id int identity not null primary key,
Name nvarchar(max) not null check(len(name)>0),
Premium money not null check(Premium>0) default 0,
Salary money not null check(Salary>0) default 0,
Surname nvarchar(max) not null check(len(Surname)>0),
);

create table Examinations(
Id int identity not null primary key,
Name nvarchar(100) not null check(len(name)>0) unique,
);
create table Wards(
Id int identity not null primary key,
Name nvarchar(20) not null  unique check(len(name)>0),
Places int not null check(len(Places)>0),
DepartmentId int not null FOREIGN KEY (DepartmentId)  REFERENCES Departments (Id),
);
create table DoctorsExaminations (
Id int identity not null primary key,
StartTime time not null check(StartTime>'7:59:59' and StartTime<='18:00:00'),
EndTime time not null ,
CONSTRAINT end_after_start CHECK (EndTime > StartTime),
DoctorId int not null FOREIGN KEY (DoctorId)  REFERENCES Doctors (Id),
ExaminationId int not null FOREIGN KEY (ExaminationId)  REFERENCES Examinations (Id),
WardId int not null FOREIGN KEY (WardId)  REFERENCES Wards (Id),
);
INSERT Departments( Building, Name ) VALUES ( 2, 'Корпус2');
INSERT Departments( Building, Name ) VALUES ( 3, 'Корпус3');
INSERT Departments( Building, Name ) VALUES ( 4, 'Корпус4');
INSERT Doctors( Surname, Name,Salary,Premium ) VALUES ( 'Иванов', 'Иван',4000,1000);
INSERT Doctors( Surname, Name,Salary,Premium ) VALUES ( 'Петров', 'Петр',5000,1500);
INSERT Doctors( Surname, Name,Salary,Premium ) VALUES ( 'Сергеев', 'Сергей',6000,500);
INSERT Doctors( Surname, Name,Salary,Premium ) VALUES ( 'Василькова', 'Галя',3000,1000);
INSERT Doctors( Surname, Name,Salary,Premium ) VALUES ( 'Костылев', 'Гарик',4000,500);
INSERT Examinations( Name ) VALUES ( 'Осмотр');
INSERT Examinations( Name ) VALUES ( 'КТ внутренних органов');
INSERT Examinations( Name ) VALUES ( 'Лоботомя');
INSERT Examinations( Name ) VALUES ( 'Эндоскопия');
INSERT Examinations( Name ) VALUES ( 'Гастроскопия');
INSERT Examinations( Name ) VALUES ( 'Пункция костного мозга');
INSERT Examinations( Name ) VALUES ( 'Анализ крови');
INSERT Wards( DepartmentId, Name,Places ) VALUES (2, 'Реанимация',2);
INSERT Wards(  DepartmentId,Name,Places ) VALUES ( 3, 'Процедурная',2);
INSERT Wards( DepartmentId, Name,Places ) VALUES ( 1, 'Общего режима',10);
INSERT Wards(DepartmentId,  Name,Places ) VALUES (2,  'Изолятор',1);
INSERT Wards(DepartmentId,  Name,Places ) VALUES ( 3, 'Люкс',1);
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '8:05:00','8:45:00',1,2,3);
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '9:15:00','9:45:00',1,2,3);
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '10:25:00','10:45:00',1,2,3);
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '11:13:00','11:40:00',1,2,3);
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '12:37:00','12:55:00',1,2,3);
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '13:49:00','14:45:00',1,2,3);
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '14:33:00','15:00:00',1,2,3);
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '15:27:00','16:15:00',1,2,3);
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '16:19:00','16:45:00',1,2,3);
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '17:22:00','17:55:00',1,2,3);
--1. Вывести количество палат, вместимость которых больше 10.
select count(*) from Wards where Places  >= 10
--2. Вывести названия корпусов и количество палат в каждом из них.

--6.Вывести количество врачей и их суммарную зарплату (сумма ставки и надбавки).
select count(*) as[количество врачей],SUM(Doctors.Salary+Doctors.Premium) as[сумма ставки и надбавки] from Doctors
--7. Вывести среднюю зарплату (сумма ставки и надбавки) врачей.
select count(*) as[количество врачей], AVG(Doctors.Salary+Doctors.Premium) as[средняя ставка и надбавка] from Doctors
--8. Вывести названия палат с минимальной вместительностью.
SELECT Wards.Name FROM Wards WHERE Places=(SELECT MIN(Places) FROM Wards )

