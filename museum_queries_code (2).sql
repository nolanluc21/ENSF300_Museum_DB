use museum;
-- Query Code
-- by Nolan Luc (UCID: 30205550), Avish Wijeratne (UCID: 30206332)

-- 1. Show all tables and explain how they are related to one another (keys, triggers, etc.)
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'museum';

-- explanation of how all the tables are related to each other
-- ARTIST: 
-- Primary key is 'Name'

-- ART_OBJECT: 
-- Primary key is 'Id_no'
-- Foreign key is 'Artist' that references ARTIST(Name)

-- PAINTING:
-- Primary key is 'Id_no'
-- Foreign key is 'Id_no' that references ART_OBJECT(Id_no)

-- SCULPTURE_STATUE:
-- Primary key is 'Id_no'
-- Foreign key is 'Id_no' that references ART_OBJECT(Id_no)

-- OTHER:
-- Primary key is 'Id_no'
-- Foreign key is 'Id_no' that references ART_OBJECT(Id_no)

-- PERMANENT COLLECTION:
-- Primary key is 'Id_no'
-- Foreign key is 'Id_no' that references ART_OBJECT(Id_no)

-- COLLECTION:
-- Primary key is 'Name'

-- BORROWED:
-- Primary key is 'Id_no'
-- Foreign keys are: 'Id_no' that references ART_OBJECT(Id_no) and 'Collection' that references COLLECTION(Name)

-- EXHIBITION:
-- Primary key is 'Name'

-- EXHIBITION_ART_OBJECT:
-- Primary keys are: 'Exhibition_name' and 'Id_no'
-- Foreign keys are: 'Exhibition_name' that references EXHIBITION(name) and 'Id_no' that references ART_OBJECT(Id_no)

-- 2. A basic retrieval query
SELECT * FROM ART_OBJECT
WHERE Artist = 'Pablo Picasso';

-- 3. A retrieval query with ordered results
SELECT SS.Id_no, SS.Height 
FROM SCULPTURE_STATUE SS
ORDER BY HEIGHT ASC;

-- 4. A nested retrieval query
SELECT Title
FROM ART_OBJECT
WHERE Id_no IN (
	SELECT Id_no
    FROM EXHIBITION_ART_OBJECT
    WHERE Exhibition_name IN (
		SELECT Exhibition_name
        FROM EXHIBITION
        WHERE Year > 2020
	)
);

-- 5. A retrieval query using joined tables
SELECT AO.Title, E.Name AS Exhibition_name, E.End_Date
FROM EXHIBITION E
JOIN EXHIBITION_ART_OBJECT EAO ON E.Name = EAO.Exhibition_name
JOIN ART_OBJECT AO ON EAO.Id_no = AO.Id_no;

-- 6. An update operation with any necessary triggers
-- Update the description of an art object
UPDATE ART_OBJECT
-- SET clause will inidicate the field that will be updated
SET Description = 'Updated Description'
-- Ensures only row with specific Id_no value is updated
WHERE Id_no = 'some_id_no';

-- Create a trigger to log updates to art objects
-- used a delimiter to change terminator from ; to ??
-- this prevents program from ending prematurely
DELIMITER ??
CREATE TRIGGER log_art_object_update
-- trigger activated after update operation
AFTER UPDATE ON ART_OBJECT
FOR EACH ROW
BEGIN
    INSERT INTO ART_OBJECT_LOG (Id_no, Old_Description, New_Description, Updated_At)
    VALUES (OLD.Id_no, OLD.Description, NEW.Description, NOW());
END??
DELIMITER ;


-- 7. A deletion operation with any necessary triggers
-- Delete an art object
DELETE FROM ART_OBJECT 
WHERE Id_no = 'some_id_no';

-- Create a trigger to log deletions from art objects
-- used a delimiter to change terminator from ; to ??
-- this prevents program from ending prematurely
DELIMITER ??
CREATE TRIGGER log_art_object_deletion
AFTER DELETE ON ART_OBJECT
FOR EACH ROW
BEGIN
    INSERT INTO ART_OBJECT_LOG (Id_no, Description, Deleted_At)
    VALUES (OLD.Id_no, OLD.Description, NOW());
END??
DELIMITER ;