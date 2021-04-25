create database Academy1
use Academy1

create table Departments(
Id int identity not null primary key,
Financing money not null check(Financing>0) default 0,
Name nvarchar(100) not null check(len(name)>0) unique,
);
create table Faculties(
Id int identity not null primary key,
Dean nvarchar(max) not null check(len(Dean)>0),
Name nvarchar(100) not null check(len(name)>0) unique,
);
create table Groups(
Id int identity not null primary key,
Name nvarchar(10) not null check(len(name)>0) unique,
Rating int  not null check(Rating >=0 and Rating <=5),
[Year] int not null check(Year >0 and Year <=5),
);
create table Teachers(
Id int identity not null primary key,
EmploymentDate date not null check(EmploymentDate>'01.01.1990'),
IsAssistant bit not null default 0,
IsProfessor bit not null default 0,
Name nvarchar(max) not null check(len(name)>0),
Surname nvarchar(max) not null check(len(Surname)>0),
Position nvarchar(max) not null check(len(Position)>0),
Premium money  not null check( Premium>0) default 0,
Salary money not null check(Salary>0),
);
INSERT Departments( Name, Financing ) VALUES ( 'Gumanitarny', 200000);
INSERT Departments( Name, Financing ) VALUES ( 'Technic', 150000);
DELETE FROM Departments WHERE ID = 4;
INSERT Faculties( Dean, Name ) VALUES ( ('Petrov Taras'),'Economica');
INSERT Faculties( Dean, Name ) VALUES ( ('Semenov Semen' ),'Pravo');
INSERT Faculties( Dean, Name ) VALUES ( ('Stephen Wozniak' ),('Computer Science'));
INSERT Departments( Name, Financing ) VALUES ( 'Software Development', 10000);
INSERT Groups(Name, Rating,Year ) VALUES ( 'E123',4 ,1);
INSERT Groups(Name, Rating,Year ) VALUES ( 'E987',2 ,3);
INSERT Groups(Name, Rating,Year ) VALUES ( 'E654',3 ,5);
INSERT Groups(Name, Rating,Year ) VALUES ( 'pr123',4 ,5);
INSERT Groups(Name, Rating,Year ) VALUES ( 'pr798',2 ,1);
INSERT Groups(Name, Rating,Year ) VALUES ( 's123',4 ,4);
INSERT Groups(Name, Rating,Year ) VALUES ( 's456',1 ,1);
INSERT Teachers(EmploymentDate,IsAssistant,IsProfessor,Name,Surname,Position,Premium,Salary ) VALUES ( '01.01.1999',1 ,0,'Ivan','Ivanov','Docent',150,500);
INSERT Teachers(EmploymentDate,IsAssistant,IsProfessor,Name,Surname,Position,Premium,Salary ) VALUES ( '30.03.1997',0 ,1,'Pavel','Osipov','Professor',300,1500);
INSERT Teachers(EmploymentDate,IsAssistant,IsProfessor,Name,Surname,Position,Premium,Salary ) VALUES ( '01.01.2002',0 ,1,'Victor','Ynukovich','Professor',150,1200);
INSERT Teachers(EmploymentDate,IsAssistant,IsProfessor,Name,Surname,Position,Premium,Salary ) VALUES ( '01.01.2009',1 ,0,'Galina','Petrova','Docent',100,500);

--1.������� ������� ������, �� ����������� �� ���� � �������� �������.
select * from Departments order by Name desc
--2. ������� �������� ����� � �� �������� � ���������� ���� ����� ������ �������.
select Name +'    '+ convert(nvarchar(MAX), Rating) as [name Groups] from Groups
--3. ������� ��� �������������� �� �������, ������� ������
--�� ��������� � �������� � ������� ������ �� ���������
--� �������� (����� ������ � ��������).
select Surname+' '+convert(nvarchar(MAX), Premium/Salary*100)+' '+convert(nvarchar(MAX), Salary/(Premium+Salary)*100)as [% �������� % ������]from Teachers
--4. ������� ������� ����������� � ���� ������ ���� � ��������� �������: �The dean of faculty [faculty] is [dean].�
select ' �The dean of faculty '+Name+' is '+Dean+'."' from Faculties
--5. ������� ������� ��������������, ������� �������� ������������ � ������ ������� ��������� 1050.select Surname from Teachers where Salary  > 1050--6. ������� �������� ������, ���� �������������� ������� ������ 11000 ��� ������ 25000.select name from Departments where Financing  > 25000 or Financing  < 11000--7. ������� �������� ����������� ����� ���������� �Computer Science�select * from Faculties where Name <> 'Computer Science'--8. ������� ������� � ��������� ��������������, ������� �� �������� ������������.select Surname+' '+Position as [�� ����������] from Teachers where IsProfessor <> 1--10.������� ������� � ������ �����������.select Surname+' '+convert(nvarchar(MAX),Salary) as [����������] from Teachers where IsProfessor = 0--11.������� ������� � ��������� ��������������, ������� ���� ������� �� ������ �� 01.01.2000.select Surname+' '+Position from Teachers where EmploymentDate < '01.01.2000'--12.������� �������� ������, ������� � ���������� �������
--������������� �� ������� �Software Development�. ��������� ���� ������ ����� �������� �Name of Department�.
select Name as [ �Name of Department�] from Departments where Name LIKE '[A-s]%' 
--13.������� ������� �����������, ������� �������� (����� ������ � ��������) �� ����� 650.
select Surname as [���������� c �� < 650] from Teachers where Premium+Salary < 650
--14.������� �������� ����� 5-�� �����, ������� ������� � ��������� �� 2 �� 4.
select name from Groups where Rating>1 and Rating<5 and Year=5
--15.������� ������� ����������� �� ������� ������ 550 ��� ��������� ������ 200.
select surname  from Teachers where IsAssistant in(select IsAssistant = 1  where Salary<550 or Premium<200 )
