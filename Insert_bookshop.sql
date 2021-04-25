INSERT INTO BOOK (Name,Description) VALUES 
('HARRY POTTER AND THE GOBLET OF FIRE' , 'Children literature'),
('HARRY POTTER. A HISTORY OF MAGIC' , 'Children literature'),
('HARRY POTTER AND THE PHILOSOPHICAL STONE' , 'Children literature'),
('STAIRS. DIALOGUES ABOUT POWER' , 'Psychology'),
('THE KEEPERS' , 'Detective'),
('BLACK SWAN' , 'Detective'),
('RISKING YOUR OWN SKIN ' , 'Detective'),
('ANTI-FRAGILITY' , 'Detective'),
('THREE TALES ABOUT THE BABY AND CARLSON ' , 'Children literature'),
('THE FIRE GOD OF THE MARRANS' , 'Children literature'),
('ADVENTURES OF THE KNOB AND HIS FRIENDS ' , 'Children literature'),
('Gang of pirates' , 'Children literature'),
('THE JUNGLE BOOK' , 'Children literature')

INSERT INTO Author (Name,Address) VALUES 
('Joanne Rowling' , 'New York, Manhattan '),
('Mikhail Khazin' , 'Kiev, Stepan Bandera 28 '),
('Semyon Shcheglov' , 'Kyiv, Shevchenka 22 '),
('ALAN MOORE' , 'London, 30 Gaden Street '),
('NASSIMA TALEBA' , 'Tbilisi, Kikavidze 18 '),
('ASTRID LINDGREN' , 'Copenhagen, Scheisestrase 66 '),
('VOLKOV Alexey' , 'Moscow, Krasnaya Polyana 1 '),
('NIKOLAY NOSOV' , 'Saint Petersburg, Moskovskaya 12 '),
('Alain DUPIN' , 'Toronto, Shevchenko 13 '),
('REDIARD KIPLING' , 'London, 11 Freedom Street ')

INSERT INTO BookAuthor (BookId, AuthorId) VALUES (1,1),(2,1),(3,1),(4,2),(4,3),(5,4),(6,5),(7,5),(8,5),(9,6),(10,7),(11,8),(12,9),(13,10)

INSERT INTO BookForSale (Id, Prise,Publish, Amount) VALUES (1, 150,'2019.11.10', 10),(2, 100,'2018.10.10', 8),(3, 120,'2017.12.22', 7),(11, 75,'2020.11.10', 10)
