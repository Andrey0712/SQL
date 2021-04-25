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

--1.Вывести таблицу кафедр, но расположить ее поля в обратном порядке.
select * from Departments order by Name desc
--2. Вывести названия групп и их рейтинги с уточнением имен полей именем таблицы.
select Name +'    '+ convert(nvarchar(MAX), Rating) as [name Groups] from Groups
--3. Вывести для преподавателей их фамилию, процент ставки
--по отношению к надбавке и процент ставки по отношению
--к зарплате (сумма ставки и надбавки).
select Surname+' '+convert(nvarchar(MAX), Premium/Salary*100)+' '+convert(nvarchar(MAX), Salary/(Premium+Salary)*100)as [% надбавки % ставки]from Teachers
--4. Вывести таблицу факультетов в виде одного поля в следующем формате: “The dean of faculty [faculty] is [dean].”
select ' “The dean of faculty '+Name+' is '+Dean+'."' from Faculties
--5. Вывести фамилии преподавателей, которые являются профессорами и ставка которых превышает 1050.select Surname from Teachers where Salary  > 1050--6. Вывести названия кафедр, фонд финансирования которых меньше 11000 или больше 25000.select name from Departments where Financing  > 25000 or Financing  < 11000--7. Вывести названия факультетов кроме факультета “Computer Science”select * from Faculties where Name <> 'Computer Science'--8. Вывести фамилии и должности преподавателей, которые не являются профессорами.select Surname+' '+Position as [не профессора] from Teachers where IsProfessor <> 1--10.Вывести фамилии и ставки ассистентов.select Surname+' '+convert(nvarchar(MAX),Salary) as [ассистенты] from Teachers where IsProfessor = 0--11.Вывести фамилии и должности преподавателей, которые были приняты на работу до 01.01.2000.select Surname+' '+Position from Teachers where EmploymentDate < '01.01.2000'--12.Вывести названия кафедр, которые в алфавитном порядке
--располагаются до кафедры “Software Development”. Выводимое поле должно иметь название “Name of Department”.
select Name as [ “Name of Department”] from Departments where Name LIKE '[A-s]%' 
--13.Вывести фамилии ассистентов, имеющих зарплату (сумма ставки и надбавки) не более 650.
select Surname as [ассистенты c ЗП < 650] from Teachers where Premium+Salary < 650
--14.Вывести названия групп 5-го курса, имеющих рейтинг в диапазоне от 2 до 4.
select name from Groups where Rating>1 and Rating<5 and Year=5
--15.Вывести фамилии ассистентов со ставкой меньше 550 или надбавкой меньше 200.
select surname  from Teachers where IsAssistant in(select IsAssistant = 1  where Salary<550 or Premium<200 )
