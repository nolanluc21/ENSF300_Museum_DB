-- database creation scipt
-- by Nolan Luc (UCID: 30205550), Avish Wijeratne (UCID: 302063
SET sql_notes = 0;
DROP DATABASE IF EXISTS MUSEUM;
SET sql_notes = 1;

CREATE DATABASE MUSEUM;
USE MUSEUM;


DROP TABLE IF EXISTS ARTIST;
CREATE TABLE ARTIST (
	Name 				varchar(40)	not null,
	Date_born			varchar(10),
    Date_died 			varchar(10),
    Country_of_origin	varchar(30),
    Epoch varchar(30),
    Main_style varchar(30),
    Description varchar(400),
	primary key (Name)
);

INSERT INTO ARTIST(Name, Date_born, Date_died, Country_of_origin, Epoch, Main_style, Description)
VALUES
('R W','1631-03-05','1672-03-04','England', 'Renaissance', 'Elizabethan', 'Limited Info'),
('Bob Smith','1567-01-02','1600-02-03','England','Renaissance','Baroque', 'Limited Info'),
('Marcus Gheeraerts the Younger','1561','1636','England','Renaissance', 'Elizabethean','Flemish-born painter'),
('Hans Holbein the Younger','1497','1543-11-29','Germany','Renaissance','Realism','He is known for his precise and realistic portraiture.'),
('Pablo Picasso','1881-10-25','1973-03-08','Spain','Modernist','Cubism','Pablo Picasso was a pioneering Spanish artist, best known for co-founding Cubism and revolutionizing modern art with his innovative and diverse approach to painting, sculpture, and other media throughout the 20th century.'),
('Lee Bul','1964-01-25',NULL,'South Korea','Modern','Futuristic','South Korean artist who works in various mediums, including performance, sculpture, installation, architecture.'),
('Josepeh Chinard','1756-02-12','1813-06-20','France','Renaissance','Neoclassical','French Sculptor'),
('Edgar Degas','1834-07-19','1917-09-27','France','Impressionist','Humanism','Peferred to be called a realist.');


DROP TABLE IF EXISTS ART_OBJECT;
CREATE TABLE ART_OBJECT (
	Id_no 	varchar(30)	not null,
	Artist	varchar(40),
	Year	varchar(25),
    Title	varchar(100),
    Description varchar(2000),
    Origin varchar(30),
    Epoch varchar(30),
	primary key (Id_no),
    foreign key (Artist) references ARTIST(Name)
);

INSERT INTO ART_OBJECT(Id_no, Artist, Year, Title, Description, Origin, Epoch)
VALUES
('68.141.120a, b','R W','1590–91','Cup with Cover','Principally sourced from the interiors of exotic shells, Indian mother-of-pearl was admired and sought after by Europeans, and imports sold at astronomical prices. Though some vessels worked by Gujarati craftsmen (from Western India) were kept in their original forms, others—such as this one—were carefully dismantled and their mother-of-pearl inlays set in new precious-metal mounts. The extremely delicate gilded silver foot and cover decorated with miniature heraldic roses locate this piece to Elizabethan London.','British', 'Renaissance'),
('68.141.104','Bob Smith','1599-1600','Wine Cup on a High Foot (Tazza)', 'The broad, shallow bowl of this wine cup is a borrowing into silver design of a Venetian glass form popular in the second half of the sixteenth century.', 'British', 'Renaissance'),
('2017.249','Marcus Gheeraerts the Younger','1597','Ellen Maurice (1578–1626)','Portrait of Ellen Maurice','British', 'Renaissance'),
('50.145.24','Hans Holbein the Younger','1532–35','Portrait of a Man in Royal Livery','The man in this portrait wears English royal livery, a uniform consisting of a red cap and coat embroidered with Henry VIII’s initials (HR), which identifies him as an artisan or attendant in the royal household.','British', 'Renaissance'),
('2016.526',NULL,'ca. 1600','Bearing Cloth','This magnificent satin embellished with a broad border of elaborate, ornamental embroidery was almost certainly a bearing cloth- used to wrap and carry an infant during baptisms and other ceremonial occasions- from a particularly wealthy, possibly noble or even royal, household.','British', 'Renaissance'),
('28.220.7, .8',NULL,'ca. 1600','Pair of gloves','The weeping eye. green parrot, and shimmering pansies adorning this pair of gloves indicate they were originally intended as a love token.','British','Renaissance'),
('CTO.026','Pablo Picasso','1912','Still Life with Chair Caning','Picasso made the first Cubist collage by pasting a piece of oilcloth (a waterproof fabric used for tablecloths) onto an oval canvas depicting café fare and a newspaper.','Spanish','Modernist'),
('SL.17.2014.1.67','Pablo Picasso','1912','The Scallop Shell: "Notre Avenir est dans l\'Air"','The blue, white, and red stripes refer to the French flag.','French','Art Nouveau'),
('LTH.002','Lee Bul','2024','Long Tail Halo: CTCS #1','An intricate sculpture that blends organic and mechanical forms.','South Korean','Modern'),
('LTH.003','Lee Bul','2024','Long Tail Halo: CTCS #2','An intricate sculpture that blends organic and mechanical forms.','South Korean','Modern'),
('RFML.SC.2023.1.1','Josepeh Chinard','1798','The Silence','Detailed Sculpture','French','Renaissance'),
('RFML.SC.2023.1.2','Josepeh Chinard','1798','The Disturbance','Detailed Sculpture','French','Renaissance'),
('RFML.SC.2023.1.3','Josepeh Chinard','1800','The Loud','Detailed Sculpture','French','Renaissance'),
('RFML.AG.2023.8.1, Recto','Edgar Degas','1855','The Dying Slave, copy after Michelangelo\'s sculpture','Copy Sculpture','Italian','Renaissance'),
('RFML.AG.2023.8.2, Recto','Edgar Degas','1856','The Dying Boy','Copy Sculpture','Italian','Renaissance'),
('RFML.AG.2023.8.3, Recto','Edgar Degas','1857','The Dying Man','Copy Sculpture','Italian','Renaissance');

DROP TABLE IF EXISTS PAINTING;
CREATE TABLE PAINTING (
	Id_no 	varchar(30)	not null,
	Paint_type	varchar(30),
	Drawn_on   	varchar(20),
    Style	varchar(30),
	primary key (Id_no),
    foreign key (Id_no) references ART_OBJECT(Id_no)
);

INSERT INTO PAINTING(Id_no, Paint_type, Drawn_on, Style)
VALUES
('2017.249','Oil','Cloak','Elizabethean'),
('50.145.24','Oil and gold','Parchment','Elizabethean'),
('CTO.026','Oil','Canvas','Cubism'),
('SL.17.2014.1.67','Enamel and Oil','Canvas','Cubism');

DROP TABLE IF EXISTS SCULPTURE_STATUE;
CREATE TABLE SCULPTURE_STATUE (
	Id_no		varchar(30)	not null,
	Material	varchar(30),
	Height  	decimal(10, 1),
    Weight		decimal(10, 3),
    Style 		varchar(20),
	primary key (Id_no),
    foreign key (Id_no) references ART_OBJECT(Id_no)
);

INSERT INTO SCULPTURE_STATUE(Id_no, Material, Height, Weight, Style)
VALUES
('68.141.120a, b','Mother-of-pearl',19.7,0.354,'Elizabethan'),
('68.141.104','Gilded silver',15.6,3.454,'Baroque'),
('LTH.002','Stainless steel','275.0','10.000','Cybernetic'),
('LTH.003','Stainless steel','268.0','9.000','Cybernetic'),
('RFML.SC.2023.1.1','Marble','86.0','11.000','Realism'),
('RFML.SC.2023.1.2','Marble','87.0','12.000','Realism'),
('RFML.SC.2023.1.3','Marble','88.0','13.000','Realism');

DROP TABLE IF EXISTS OTHER;
CREATE TABLE OTHER (
	Id_no 	varchar(30)	not null,
	Type varchar(15),
    Style varchar(15),
	primary key (Id_no),
    foreign key (Id_no) references ART_OBJECT(Id_no)
);

INSERT INTO OTHER(Id_no, Type, Style)
VALUES
('2016.526','Cloth','Elizabethean'),
('28.220.7, .8','Leather','Elizabethean'),
('RFML.AG.2023.8.1, Recto','Drawing','Humanism'),
('RFML.AG.2023.8.2, Recto','Drawing','Humanism'),
('RFML.AG.2023.8.3, Recto','Drawing','Humanism');

DROP TABLE IF EXISTS PERMANENT_COLLECTION;
CREATE TABLE PERMANENT_COLLECTION (
	Id_no 			varchar(30)	not null,
	Date_acquired 	varchar(10),
    Status 			varchar(30),
    Cost 			varchar(20),
	primary key (Id_no),
    foreign key (Id_no) references ART_OBJECT(Id_no)
);

INSERT INTO PERMANENT_COLLECTION(Id_no, Date_acquired, Status, Cost)
VALUES
('68.141.120a, b','2002-12-01','On Display','$7000.00'),
('68.141.104','2023-01-01','On Display','$8000.00'),
('2017.249','2022-07-07', 'On Display','$100000.00'),
('50.145.24','2021-08-08','On Display','$150000.00'),
('2016.526','2020-02-21','On Display','$202202.00'),
('28.220.7, .8','1999-05-06','On Display','$20000.00'),
('CTO.026','2005-03-23','On Display','$10000000.00'),
('SL.17.2014.1.67','2002-02-02','On Display','$3783388.00'),
('LTH.002','2024-09-11','On Display','$210000.00'),
('LTH.003','2024-09-09','On Display','$190000.00');

DROP TABLE IF EXISTS COLLECTION;
CREATE TABLE COLLECTION (
	Name 	varchar(80)	not null,
	Type varchar(15),
    Description varchar(50),
    Address varchar(70),
    Phone varchar(15),
    Contact_person varchar(30),
	primary key (Name)
);

INSERT INTO COLLECTION(Name, Type, Description, Address, Phone, Contact_person)
VALUES
('Department of Medieval, Renaissance and Modern Sculptures','Museum','Known for Collecting Sculptures','22 Charleswood Road NE, Paris, France','678-911-9111','Bill Mountie'),
('Department of Graphic Arts','Museum','Known for collecting pricey pieces','66 Babylon Street NW, Madrid, Spain','778-228-8989','David Gomez');



DROP TABLE IF EXISTS BORROWED;
CREATE TABLE BORROWED (
	Id_no 	varchar(30)	not null,
	Collection varchar(80),
    Date_borrowed varchar(10),
    Date_returned varchar(10),
	primary key (Id_no),
    foreign key (Id_no) references ART_OBJECT(Id_no),
    foreign key (Collection) references COLLECTION(Name)
);

INSERT INTO BORROWED(Id_no, Collection, Date_borrowed, Date_returned)
VALUES
('RFML.SC.2023.1.1','Department of Medieval, Renaissance and Modern Sculptures','2010-10-10','2015-05-05'),
('RFML.SC.2023.1.2','Department of Medieval, Renaissance and Modern Sculptures','2010-11-10','2016-03-05'),
('RFML.SC.2023.1.3','Department of Medieval, Renaissance and Modern Sculptures','2010-12-10','2017-10-10'),
('RFML.AG.2023.8.1, Recto','Department of Graphic Arts','2018-09-09','2019-09-09'),
('RFML.AG.2023.8.2, Recto','Department of Graphic Arts','2019-09-09','2021-09-09'),
('RFML.AG.2023.8.3, Recto','Department of Graphic Arts','2019-08-09','2022-09-09');



DROP TABLE IF EXISTS EXHIBITION;
CREATE TABLE EXHIBITION (
	Name 	varchar(100)	not null,
	Start_date varchar(10),
    End_date varchar(10),
	primary key (Name)
);

INSERT INTO EXHIBITION(Name, Start_date, End_date)
VALUES
('The Genesis Facade Commission: Lee Bul, Long Tail Halo','2024-09-12','2025-05-27'),
('The Tudors: Art and Majesty in Renaissance England','2022-10-10','2023-01-08'),
('Cubism and the Trompe l’Oeil Tradition','2022-10-20','2023-01-22');

DROP TABLE IF EXISTS EXHIBITION_ART_OBJECT;
CREATE TABLE EXHIBITION_ART_OBJECT (
	Exhibition_name 	varchar(100)	not null,
	Id_no 				varchar(30),
	primary key (Exhibition_name, Id_no),
    foreign key (Exhibition_name) references EXHIBITION(Name),
	foreign key (Id_no) references ART_OBJECT(Id_no)
);

INSERT INTO EXHIBITION_ART_OBJECT(Exhibition_name, Id_no)
VALUES
('The Genesis Facade Commission: Lee Bul, Long Tail Halo','LTH.002'),
('The Genesis Facade Commission: Lee Bul, Long Tail Halo','LTH.003'),
('The Tudors: Art and Majesty in Renaissance England','68.141.120a, b'),
('The Tudors: Art and Majesty in Renaissance England','68.141.104'),
('The Tudors: Art and Majesty in Renaissance England','2017.249'),
('The Tudors: Art and Majesty in Renaissance England','50.145.24'),
('The Tudors: Art and Majesty in Renaissance England','2016.526'),
('The Tudors: Art and Majesty in Renaissance England','28.220.7, .8'),
('Cubism and the Trompe l’Oeil Tradition','CTO.026'),
('Cubism and the Trompe l’Oeil Tradition','SL.17.2014.1.67');

-- ART_OBJECT_LOG table creation for trigger questions 6 and 7
DROP TABLE IF EXISTS ART_OBJECT_LOG;
CREATE TABLE ART_OBJECT_LOG (
    Log_ID INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each log entry
    Id_no VARCHAR(30) NOT NULL,            -- Reference to the ART_OBJECT table
    Old_Description TEXT NULL,                  -- Previous description of the art object
    New_Description TEXT NULL,                  -- New description after the update
    Deleted_At DATETIME NULL,              -- Timestamp of deletion (NULL if not deleted)
    Updated_At DATETIME NULL,              -- Timestamp of update (NULL if not updated)
    Log_Type ENUM('UPDATE', 'DELETE') NOT NULL, -- Type of operation (update or delete)
    FOREIGN KEY (Id_no) REFERENCES ART_OBJECT(Id_no) ON DELETE CASCADE
);
