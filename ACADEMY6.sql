CREATE DATABASE Academy6
USE Academy6

CREATE TABLE Curators (
Id INT NOT NULL IDENTITY PRIMARY KEY,
Name NVARCHAR(MAX) NOT NULL CHECK(LEN(Name)>0),
Surname NVARCHAR(MAX) NOT NULL CHECK(LEN(Surname)>0)
)
CREATE TABLE Faculties(
Id INT NOT NULL IDENTITY PRIMARY KEY,
Name NVARCHAR(100) NOT NULL CHECK(LEN(Name)>0) UNIQUE
)
CREATE TABLE Departments(
Id INT NOT NULL IDENTITY PRIMARY KEY,
Building INT NOT NULL CHECK(Building>0 AND Building<=5),
Financing MONEY NOT NULL CHECK(LEN(Financing)>0) DEFAULT 0,
Name NVARCHAR(100) NOT NULL CHECK(LEN(Name)>0) UNIQUE,
FacultyId INT NOT NULL FOREIGN KEY  (FacultyId) REFERENCES Faculties (Id)
)
CREATE TABLE Groups(
Id INT NOT NULL IDENTITY PRIMARY KEY,
Name nvarchar(10) NOT NULL CHECK(LEN(Name)>0) UNIQUE,
Year INT NOT NULL CHECK(Year>0 AND Year<=5),
DepartmentId INT NOT NULL FOREIGN KEY (DepartmentId) REFERENCES Departments(Id)
)
CREATE TABLE GroupsCurators(
Id INT NOT NULL IDENTITY PRIMARY KEY,
CuratorId INT NOT NULL FOREIGN KEY (CuratorId) REFERENCES Curators (Id),
GroupId INT NOT NULL FOREIGN KEY(GroupId) REFERENCES Groups(Id),
)

CREATE TABLE Students(
Id INT NOT NULL IDENTITY PRIMARY KEY,
Name NVARCHAR(MAX) NOT NULL CHECK(LEN(Name)>0),
Rating INT NOT NULL CHECK(Rating>=0 AND Rating<=5),
Surname NVARCHAR(MAX) NOT NULL CHECK(LEN(Surname)>0)
)
CREATE TABLE GroupsStudents(
Id INT NOT NULL IDENTITY PRIMARY KEY,
GroupId INT NOT NULL FOREIGN KEY (GroupId) REFERENCES Groups(Id),
StudentId INT NOT NULL FOREIGN KEY (StudentId) REFERENCES Students(Id)
)
CREATE TABLE Subjects(
Id INT NOT NULL IDENTITY PRIMARY KEY,
Name NVARCHAR(100) NOT NULL CHECK(LEN(Name)>0) UNIQUE,
)
CREATE TABLE Teachers(
Id INT NOT NULL IDENTITY PRIMARY KEY,
IsProfessor BIT NOT NULL DEFAULT 0,
Name NVARCHAR(MAX) NOT NULL CHECK(LEN(Name)>0),
Salary MONEY  NOT NULL CHECK(LEN(Salary)>0),
Surname NVARCHAR(MAX) NOT NULL CHECK(LEN(Surname)>0)
)
CREATE TABLE Lectures(
Id INT NOT NULL IDENTITY PRIMARY KEY,
Date DATE NOT NULL CHECK(Date> GetDate()),
SubjectId INT NOT NULL FOREIGN KEY (SubjectId) REFERENCES Subjects(Id),
TeacherId INT NOT NULL FOREIGN KEY (TeacherId) REFERENCES Teachers(Id),
)
CREATE TABLE GroupsLectures(
Id INT NOT NULL IDENTITY PRIMARY KEY,
GroupId INT NOT NULL FOREIGN KEY (GroupId) REFERENCES Groups (Id),
LectureId INT NOT NULL FOREIGN KEY(LectureId)REFERENCES Lectures (Id)
)

INSERT INTO Curators (Surname,Name ) VALUES ('������','����'),('������','����'),('������','�����'),('����������','����')

INSERT INTO Faculties (Name) VALUES ('Computer Science'),('���������'),('���������� ����������'),('�����������')

INSERT INTO Departments (Building,Financing, Name, FacultyId) VALUES 
(1,10000, 'Software Development', 1),(2,5000, '�������', 2),(3,5000, '�������������', 1),(4,1000, '������ ����������', 3),(5,10000, '������������ �����', 4)

INSERT INTO Groups (Name,Year,DepartmentId) VALUES ('D221',1, 1),('E111',2, 3),('R333',3, 2),('T444',4, 4),('Y555',5, 4),('U888',2, 5),('I999',3, 5),('K777',4, 1)

INSERT INTO GroupsCurators  (CuratorId,GroupId) VALUES (1, 1),(2, 2),(3, 3),(4, 4),(1, 5),(2, 6),(3, 7),(4, 8)

INSERT INTO Subjects (Name) VALUES ('�����'),('���������'),('�++'),('�#'),('����������'),('���������������'),('������������� ��������'),('�����������������'),('��������������')

INSERT INTO Teachers (IsProfessor, Name,Salary,Surname) VALUES 
(1,'����',3000, '����������'),(0,'����',1000, '������'),(1,'������',4000, '�������'),(0,'�����',1000, '��������'),(0,'����',1000, '���������')

INSERT INTO Lectures (Date,SubjectId,TeacherId) VALUES 
('22.11.2020',1, 1),('22.11.2020',2, 2),('21.11.2020',3, 3),('20.11.2020',4, 4),('25.11.2020',5, 5),('30.11.2020',6, 5),('29.11.2020',7, 4),('28.11.2020',8, 3),('25.11.2020',9, 1)

INSERT INTO GroupsLectures  (GroupId,LectureId) VALUES (1, 2),(2, 9),(3, 3),(4, 4),(5, 5),(6, 6),(7, 7),(8, 8),(7, 10)

 
 --1. ������� ������ ��������, ���� ��������� ���� �������������� ������������� � ��� ������ ��������� 100000.(100000- ������� �� 5000 ��� ���������� ������)
 SELECT Departments.Building FROM Departments WHERE Departments.Financing > 5000
 --2. ������� �������� ����� 5-�� ����� ������� �Software Development�, ������� ����� ����� 10 ��� � ������ ������.(����� 5-�� ����� -������� �� 1 ���� ��� ���������� ������)
 SELECT Groups.Name FROM Groups,Departments  WHERE  Groups.DepartmentId = Departments.Id AND Departments.Name = 'Software Development' AND Groups.Year = 1
 --3. ������� �������� �����, ������� ������� (������� ������� ���� ��������� ������) ������, ��� ������� ������ �D221�.
 SELECT Groups.Name FROM Groups,GroupsStudents,Students WHERE GroupsStudents.GroupId = Groups.Id AND Students.Id = GroupsStudents.StudentId GROUP BY Groups.Name HAVING AVG(Students.Rating) > (
SELECT AVG(Students.Rating) FROM Groups, GroupsStudents WHERE GroupsStudents.GroupId = Groups.Id AND Students.Id = GroupsStudents.StudentId AND Groups.Name = 'D221')
 --4. ������� ������� � ����� ��������������, ������ ������� ���� ������� ������ �����������.
  SELECT Teachers.Name, Teachers.Surname FROM Teachers WHERE Teachers.Salary > (SELECT AVG(Teachers.Salary) FROM Teachers WHERE Teachers.IsProfessor = 1)
  --5. ������� �������� �����, � ������� ������ ������ ��������(=1).
  SELECT Groups.Name FROM Curators,Groups,GroupsCurators WHERE Groups.Id=GroupsCurators.GroupId AND GroupsCurators.CuratorId=Curators.Id GROUP BY Groups.Name HAVING COUNT(Curators.Id) =1 
  --6. ������� �������� �����, ������� ������� (������� ������� ���� ��������� ������) ������, ��� ����������� ������� ����� 5-�� �����.
  SELECT Groups.Name FROM Groups,Students,GroupsStudents WHERE GroupsStudents.GroupId=Groups.Id AND GroupsStudents.StudentId=Students.Id GROUP BY Groups.Name HAVING  AVG(Students.Rating)<(
  SELECT MIN(Students.Rating) FROM Students,GroupsStudents,Groups WHERE GroupsStudents.StudentId = Students.Id AND GroupsStudents.GroupId= Groups.Id AND Groups.Year = 5)
   --7. ������� �������� �����������, ��������� ���� �������������� ������ ������� ������ ���������� ����� �������������� ������ ���������� �Computer Science�.
 SELECT Faculties.Name FROM Faculties, Departments WHERE Faculties.Id = Departments.FacultyId GROUP BY Faculties.Name HAVING SUM(Departments.Financing) > (
 SELECT SUM(Departments.Financing) FROM Departments,Faculties WHERE Departments.FacultyId = Faculties.Id AND Faculties.Name = 'Computer Science')
 --	10. ������� ���������� ��������� � �������� ��������� ��������� �Software Development�.
SELECT COUNT(Students.Id) as [���������� ���������], COUNT(Subjects.Id) as [�������� ���������] FROM Departments, Groups,GroupsStudents,Students,GroupsLectures,Lectures,Subjects WHERE
Groups.DepartmentId = Departments.Id AND GroupsStudents.GroupId = Groups.Id AND Students.Id = GroupsStudents.StudentId AND GroupsLectures.GroupId = Groups.Id AND
Lectures.Id = GroupsLectures.LectureId AND Subjects.Id = Lectures.SubjectId AND Departments.Name = 'Software Development'






