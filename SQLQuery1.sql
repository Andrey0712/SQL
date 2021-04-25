CREATE DATABASE Academy
  Use Academy

CREATE TABLE Faculties (
Id int NOT NULL IDENTITY PRIMARY KEY,
Name nvarchar(100) NOT NULL CHECK(LEN(Name) > 0) UNIQUE
)
CREATE TABLE Departments (
Id int NOT NULL IDENTITY PRIMARY KEY,
Financing money NOT NULL CHECK (Financing >= 0) DEFAULT 0,
Name nvarchar(100) NOT NULL CHECK(LEN(Name) > 0) UNIQUE,
FacultyId int NOT NULL FOREIGN KEY (FacultyId) REFERENCES Faculties(Id)
)
CREATE TABLE Subjects (
Id int NOT NULL IDENTITY PRIMARY KEY,
Name nvarchar(100) NOT NULL CHECK(LEN(Name) > 0) UNIQUE
)
CREATE TABLE Teachers (
Id int NOT NULL IDENTITY PRIMARY KEY,
Name nvarchar(MAX) NOT NULL CHECK(LEN(Name) > 0),
Salary money NOT NULL CHECK(Salary > 0),
Surname nvarchar(MAX) NOT NULL CHECK(LEN(Surname)>0)
) 
CREATE TABLE Lectures (
Id int NOT NULL IDENTITY PRIMARY KEY,
DayOfWeek int NOT NULL CHECK(DayOfWeek >0 AND DayOfWeek <= 7),
LectureRoom nvarchar(MAX) NOT NULL CHECK(LEN(LectureRoom) > 0),
SubjectId int NOT NULL FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
TeacherId int NOT NULL FOREIGN KEY (TeacherId) REFERENCES Teachers(Id)
)
CREATE TABLE Groups (
Id int NOT NULL IDENTITY PRIMARY KEY,
Name nvarchar(10) NOT NULL CHECK(LEN(Name) > 0) UNIQUE,
Year int NOT NULL CHECK (Year >0 AND Year <= 5),
DepartmentId int NOT NULL FOREIGN KEY (DepartmentId) REFERENCES Departments(Id),
Students int NOT NULL CHECK (Students > 0)
)
CREATE TABLE GroupsLectures (
Id int NOT NULL IDENTITY PRIMARY KEY,
GroupId int NOT NULL FOREIGN KEY (GroupId) REFERENCES Groups(Id),
LectureId int NOT NULL FOREIGN KEY (LectureId) REFERENCES Lectures(Id)
)

INSERT INTO Faculties (Name) VALUES ('Computer Science'),('Економика'),('Прикладная математика'),('Юридический')

INSERT INTO Departments (Financing, Name, FacultyId) VALUES 
(10000, 'Software Development', 1),(5000, 'Финансы', 2),(5000, 'Автоматизация', 1),(1000, 'Высшая математика', 3),(10000, 'Креминальное право', 4)

INSERT INTO Subjects (Name) VALUES 
('с++'),('с#'),('Теория вероятности'),('Статистика'),('Мат. анализ'),('SQL'),('Материалознавство'),('Основы права'),('Креминальный кодекс'),('Автоматизация процесов')

INSERT INTO Teachers (Name, Salary, Surname) VALUES 
('Dave', 1000, 'McQueen'), ('Jack', 1500, 'Underhill'),('Галя', 2000, 'Розенберг'),('Гиви', 2500, 'Вахгадзе')    
-- ПОДПРАВИТЬ
INSERT INTO Lectures (DayOfWeek, LectureRoom, SubjectId, TeacherId) VALUES
(1, 'D201', 2, 2),(2, 'K666', 1, 1),(3, 'R555', 3, 3),(4, 'B444', 4, 4),(5, 'D201', 5, 2),(6, 'E333', 6, 4),(7, 'U222', 7, 3),(1, 'X111', 8, 4)

INSERT INTO Groups (Name, Year, DepartmentId, Students) VALUES 
('A1', 1, 1, 25),('B2', 2, 1, 20),('C3', 3, 2, 13),('Q4', 4, 3, 18),('R5', 5, 3, 10),('G2', 4, 4, 20),('T3', 3, 4, 15),('Y4', 4, 5, 20),('С4', 4, 2, 20)

INSERT INTO GroupsLectures (GroupId, LectureId) VALUES (1, 2),(2, 1),(3, 5),(4, 4),(5, 6),(6, 3),(7, 8),(8, 2),(9, 7)

--1. Вывести количество преподавателей кафедры “SoftwareDevelopment”.
SELECT  COUNT(Teachers.Name) AS[количество преподавателей кафедры “SoftwareDevelopment]   FROM Departments, Groups, GroupsLectures, Lectures, Teachers
WHERE Groups.DepartmentId = Departments.Id AND  GroupsLectures.GroupId = Groups.Id AND GroupsLectures.LectureId = Lectures.Id 
AND Lectures.TeacherId = Teachers.Id AND Departments.Name = 'Software Development' 
--2. Вывести количество лекций, которые читает преподаватель “Dave McQueen”.
SELECT COUNT(Lectures.Id)AS[количество лекций, которые читает преподаватель “Dave McQueen] FROM Lectures,Teachers WHERE
 Lectures.TeacherId = Teachers.Id AND Teachers.Name = 'Dave' AND Teachers.Surname = 'McQueen'
 --3. Вывести количество занятий, проводимых в аудитории“D201”.
 SELECT COUNT(Lectures.Id)AS[количество занятий, проводимых в аудитории“D201”] FROM Lectures WHERE Lectures.LectureRoom = 'D201'
 --4. Вывести названия аудиторий и количество лекций, проводимых в них.
 SELECT LectureRoom as [названия аудиторий], COUNT(Lectures.Id) as [количество лекций] FROM Lectures GROUP BY LectureRoom
 --5. Вывести количество студентов, посещающих лекции преподавателя “Jack Underhill”.
 SELECT SUM(Groups.Students) AS[количество студентов] FROM Lectures, Teachers, Groups, GroupsLectures
 WHERE GroupsLectures.LectureId = Lectures.Id AND GroupsLectures.GroupId = Groups.Id AND Lectures.TeacherId = Teachers.Id  AND Teachers.Surname = 'Underhill'
 --6. Вывести среднюю ставку преподавателей факультета “Computer Science”.
 SELECT AVG(Teachers.Salary) AS[среднюю ставку преподавателей факультета “Computer Science”] FROM Teachers, Lectures,GroupsLectures,Groups,Departments,Faculties
 WHERE Faculties.Id = Departments.FacultyId AND Groups.DepartmentId = Departments.Id AND GroupsLectures.GroupId = Groups.Id AND GroupsLectures.LectureId = Lectures.Id AND
 Lectures.TeacherId = Teachers.Id 
 --7. Вывести минимальное и максимальное количество студентов среди всех групп.
 SELECT MIN(Groups.Students) as [минимальное], MAX(Groups.Students) as [максимальное] FROM Groups
 --8. Вывести средний фонд финансирования кафедр.
 SELECT AVG(Financing) as [средний фонд финансирования кафедр] FROM Departments
 --9. Вывести полные имена преподавателей и количество читаемых ими дисциплин.
 SELECT Teachers.Name, Teachers.Surname, COUNT(Lectures.SubjectId) FROM ( Teachers JOIN Lectures on Lectures.TeacherId = Teachers.Id)GROUP BY Surname, Name
 --10. Вывести количество лекций в каждый день недели.
 SELECT DayOfWeek, COUNT(Id) as [количество лекций] FROM Lectures GROUP BY DayOfWeek
 --11. Вывести номера аудиторий и количество кафедр, чьи лекции в них читаются.
 SELECT LectureRoom, COUNT(Departments.Name) as [количество кафедр]  FROM Lectures,GroupsLectures,Groups,Departments WHERE
 GroupsLectures.LectureId = Lectures.Id AND  GroupsLectures.GroupId = Groups.Id AND Groups.DepartmentId = Departments.Id GROUP BY LectureRoom
 --12. Вывести названия факультетов и количество дисциплин,которые на них читаются.
 SELECT Faculties.Name, COUNT(Lectures.SubjectId) [количество дисциплин] FROM Faculties,Departments,Groups,GroupsLectures,Lectures WHERE
Faculties.Id = Departments.FacultyId AND Groups.DepartmentId = Departments.Id AND GroupsLectures.GroupId = Groups.Id AND GroupsLectures.LectureId = Lectures.Id 
GROUP BY Faculties.Name
--13. Вывести количество лекций для каждой пары преподаватель-аудитория.
 SELECT Teachers.Surname, Lectures.LectureRoom , COUNT(Lectures.Id) as [количество лекций] FROM Lectures, Teachers WHERE
 Lectures.TeacherId = Teachers.Id GROUP BY Teachers.Surname,Lectures.LectureRoom

 


