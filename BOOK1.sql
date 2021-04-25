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
('ГАРРИ ПОТТЕР И КУБОК ОГНЯ' , 'Детская литература'),
('ГАРРИ ПОТТЕР. ИСТОРИЯ ВОЛШЕБСТВА' , 'Детская литература'),
('ГАРРИ ПОТТЕР И ФИЛОСОФСКИЙ КАМЕНЬ' , 'Детская литература'),
('ЛЕСТНИЦА. ДИАЛОГИ О ВЛАСТИ' , 'Психология'),
('ХРАНИТЕЛИ' , 'Детектив'),
('ЧЕРНЫЙ ЛЕБЕДЬ' , 'Детектив'),
('РИСКУЯ СОБСТВЕННОЙ ШКУРОЙ ' , 'Детектив'),
('АНТИХРУПКОСТЬ' , 'Детектив'),
('ТРИ ПОВЕСТИ О МАЛЫШЕ И КАРЛСОНЕ ' , 'Детская литература'),
('ОГНЕННЫЙ БОГ МАРРАНОВ' , 'Детская литература'),
('ПРИКЛЮЧЕНИЯ НЕЗНАЙКИ И ЕГО ДРУЗЕЙ ' , 'Детская литература'),
('БАНДА ПИРАТОВ' , 'Детская литература'),
('КНИГА ДЖУНГЛЕЙ' , 'Детская литература')

INSERT INTO Author (Name,Address) VALUES 
('Джоан Роулинг' , 'НьюЙорк, Манхетен '),
('Михаил Хазин' , 'Киев, Степана Бандеры 28 '),
('Семен Щеглов' , 'Киев, Шевченка 22 '),
('АЛАН МУР' , 'Лондон, Гаденстрит 30 '),
('НАССИМА ТАЛЕБА' , 'Тбилиси, Кикавидзе 18 '),
('АСТРИД ЛИНДГРЕН' , 'Капенгаген, Шайзештрассе 66 '),
('ВОЛКОВ Алексей' , 'Москва, Красная Поляна 1 '),
('НИКОЛАЙ НОСОВ' , 'Санкт Питербург, Московская 12 '),
('Алан ДЮПЕН' , 'Таронто, Шевченка 13 '),
('РЕДЬЯРД КИПЛИНГ' , 'Лондон, Фридомстрит 11 ')

INSERT INTO BookAuthor (BookId, AuthorId) VALUES (1,1),(2,1),(3,1),(4,2),(4,3),(5,4),(6,5),(7,5),(8,5),(9,6),(10,7),(11,8),(12,9),(13,10)

INSERT INTO BookForSale (Id, Prise,Publish, Amount) VALUES (1, 150,'2019.11.10', 10),(2, 100,'2018.10.10', 8),(3, 120,'2017.12.22', 7),(11, 75,'2020.11.10', 10)

--вивести всі книжки першого автора
SELECT BOOK.Name AS[всі книжки першого автора] FROM BOOK,Author,BookAuthor WHERE BOOK.Id=BookAuthor.BookId AND BookAuthor.AuthorId=Author.Id AND Author.Id=1
--вивести кількість книжок в продажі
SELECT COUNT(BookForSale.Id) AS[кількість книжок в продажі] FROM BookForSale
--вивести книжки в яких більше двох авторів
SELECT BOOK.Name AS[книжки в яких більше двох авторів] FROM BOOK,Author,BookAuthor WHERE BOOK.Id=BookAuthor.BookId AND BookAuthor.AuthorId=Author.Id 
GROUP BY BOOK.Name HAVING  COUNT(Author.Id)>1
--вивести середню ціну книжки Джоан Роулинг
SELECT AVG(BookForSale.Prise) AS [середня ціна книжки Джоан Роулинг] FROM BookForSale,BOOK,Author,BookAuthor WHERE 
BOOK.Id=BookAuthor.BookId AND BookAuthor.AuthorId=Author.Id AND BookForSale.Id=BOOK.Id AND Author.Name='Джоан Роулинг'
--вивести авторів книжки "ЛЕСТНИЦА. ДИАЛОГИ О ВЛАСТИ"
SELECT Author.Name AS [автор книжки "ЛЕСТНИЦА. ДИАЛОГИ О ВЛАСТИ"] FROM Author,BookAuthor,BOOK WHERE BOOK.Id=BookAuthor.BookId AND BookAuthor.AuthorId=Author.Id
AND BOOK.Name='ЛЕСТНИЦА. ДИАЛОГИ О ВЛАСТИ'

