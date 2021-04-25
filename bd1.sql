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
StartTime time not null check(StartTime>'7.59' and StartTime<='18.00'),
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
INSERT DoctorsExaminations (StartTime,EndTime,DoctorId,ExaminationId,WardId)VALUES ( '8:05:00','8:45:00',1,2,6);

