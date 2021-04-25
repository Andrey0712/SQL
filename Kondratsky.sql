create database Academy
use Academy

create table Curators(
Id int identity not null primary key,
Name nvarchar(max) not null,
Surname nvarchar(max) not null
);
create table Faculties(
Id int identity not null primary key,
Financing money not null check(Financing>0) default 0,
Name nvarchar(100) not null check(len(name)>0) unique,
);
create table Departments(
Id int identity not null primary key,
Financing money not null check(Financing>0) default 0,
Name nvarchar(100) not null check (len(Name)>0) Unique,
FacultyId int not null FOREIGN KEY (FacultyId)  REFERENCES Faculties (Id)
);
create table Groups(
Id int identity not null primary key,
Name nvarchar(10) not null check(len(Name)>0) unique,
[Year] int not null check(Year >0 and Year <=5),
DepartmentId int not null Foreign key(DepartmentId) references Departments (Id)
);
create table GroupsCurators(
Id int identity not null primary key,
CuratorId int  not null foreign key(CuratorId) references Curators(Id),
GroupId int not null foreign key(GroupId) references Groups (ID)
);
create table Subjects(
Id int identity not null primary key,
Name nvarchar(100) not null unique check(len(Name)>0),
);
create table Teachers(
Id int identity not null primary key,
Name nvarchar(max) not null check(len(Name)>0),
Salary money not null check(Salary>=0) default 0,
Surname nvarchar(max) not null Check(len(Surname)>0)
);
create table Lectures(
Id int not null identity primary key,
LectureRoom nvarchar(max) not null check (len(LectureRoom)>0),
SubjectId int not null foreign key(SubjectId) references Subjects (ID),
TeacherId int not null foreign key(TeacherId) references Teachers (ID),
);
create table GroupsLectures(
Id int identity  not null primary key,
GroupId int not null foreign key(GroupId) references Groups (Id),
LectureId int not null foreign key(LectureId) references Lectures (Id)
);


