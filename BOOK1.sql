CREATE DATABASE BOOK1
USE BOOK1

CREATE TABLE BOOK(
Id INT NOT NULL IDENTITY  PRIMARY KEY,
Name NVARCHAR(MAX) NOT NULL CHECK(LEN(Name)>0), 
Description NVARCHAR(MAX) NOT NULL CHECK(LEN(Description)>0)
)
CREATE TABLE BookForSale (
Id INT NOT NULL  PRIMARY KEY,
CONSTRAINT FK_BookForSale_Id FOREIGN KEY (Id)  REFERENCES BOOK (Id),
Prise MONEY NOT NULL CHECK(LEN(Prise)>0) DEFAULT 0,
Publish DATE NOT NULL CHECK(Publish< GetDate()) ,
Amount INT NOT NULL CHECK(Amount >= 0)
)
CREATE TABLE Author (
Id INT NOT NULL IDENTITY PRIMARY KEY ,
Name NVARCHAR(MAX) NOT NULL CHECK(LEN(Name)>0),
Address NVARCHAR(MAX) NOT NULL CHECK(LEN(Address) > 0)
)
CREATE TABLE BookAuthor (
Id INT NOT NULL IDENTITY PRIMARY KEY,
BookId INT NOT NULL FOREIGN KEY (BookId) REFERENCES Book(Id),
AuthorId INT NOT NULL FOREIGN KEY (AuthorId) REFERENCES Author(Id)
)

INSERT INTO BOOK (Name,Description) VALUES 
('����� ������ � ����� ����' , '������� ����������'),
('����� ������. ������� ����������' , '������� ����������'),
('����� ������ � ����������� ������' , '������� ����������'),
('��������. ������� � ������' , '����������'),
('���������' , '��������'),
('������ ������' , '��������'),
('������ ����������� ������ ' , '��������'),
('�������������' , '��������'),
('��� ������� � ������ � �������� ' , '������� ����������'),
('�������� ��� ��������' , '������� ����������'),
('����������� �������� � ��� ������ ' , '������� ����������'),
('����� �������' , '������� ����������'),
('����� ��������' , '������� ����������')

INSERT INTO Author (Name,Address) VALUES 
('����� �������' , '�������, �������� '),
('������ �����' , '����, ������� ������� 28 '),
('����� ������' , '����, �������� 22 '),
('���� ���' , '������, ���������� 30 '),
('������� ������' , '�������, ��������� 18 '),
('������ ��������' , '����������, ������������ 66 '),
('������ �������' , '������, ������� ������ 1 '),
('������� �����' , '����� ���������, ���������� 12 '),
('���� �����' , '�������, �������� 13 '),
('������� �������' , '������, ����������� 11 ')

INSERT INTO BookAuthor (BookId, AuthorId) VALUES (1,1),(2,1),(3,1),(4,2),(4,3),(5,4),(6,5),(7,5),(8,5),(9,6),(10,7),(11,8),(12,9),(13,10)

INSERT INTO BookForSale (Id, Prise,Publish, Amount) VALUES (1, 150,'2019.11.10', 10),(2, 100,'2018.10.10', 8),(3, 120,'2017.12.22', 7),(11, 75,'2020.11.10', 10)

--������� �� ������ ������� ������
SELECT BOOK.Name AS[�� ������ ������� ������] FROM BOOK,Author,BookAuthor WHERE BOOK.Id=BookAuthor.BookId AND BookAuthor.AuthorId=Author.Id AND Author.Id=1
--������� ������� ������ � ������
SELECT COUNT(BookForSale.Id) AS[������� ������ � ������] FROM BookForSale
--������� ������ � ���� ����� ���� ������
SELECT BOOK.Name AS[������ � ���� ����� ���� ������] FROM BOOK,Author,BookAuthor WHERE BOOK.Id=BookAuthor.BookId AND BookAuthor.AuthorId=Author.Id 
GROUP BY BOOK.Name HAVING  COUNT(Author.Id)>1
--������� ������� ���� ������ ����� �������
SELECT AVG(BookForSale.Prise) AS [������� ���� ������ ����� �������] FROM BookForSale,BOOK,Author,BookAuthor WHERE 
BOOK.Id=BookAuthor.BookId AND BookAuthor.AuthorId=Author.Id AND BookForSale.Id=BOOK.Id AND Author.Name='����� �������'
--������� ������ ������ "��������. ������� � ������"
SELECT Author.Name AS [����� ������ "��������. ������� � ������"] FROM Author,BookAuthor,BOOK WHERE BOOK.Id=BookAuthor.BookId AND BookAuthor.AuthorId=Author.Id
AND BOOK.Name='��������. ������� � ������'

