
-- Query 1: Show all tables and explain how they are related to one another (keys, triggers, etc.)
SHOW TABLES;
SHOW CREATE TABLE Exhibitions;
SHOW CREATE TABLE ArtObjects;
SHOW CREATE TABLE Collections;
SHOW CREATE TABLE Ownership;

-- Query 2: A basic retrieval query
SELECT * FROM ArtObjects;

-- Query 3: A retrieval query with ordered results
SELECT * FROM ArtObjects ORDER BY object_name;

-- Query 4: A nested retrieval query
SELECT * FROM Exhibitions
WHERE exhibition_id IN (SELECT exhibition_id FROM ArtObjects WHERE category = 'painting');

-- Query 5: A retrieval query using joined tables
SELECT ao.object_name, ao.category, e.exhibition_name, c.collection_name
FROM ArtObjects ao
JOIN Exhibitions e ON ao.exhibition_id = e.exhibition_id
LEFT JOIN Ownership o ON ao.object_id = o.object_id
LEFT JOIN Collections c ON o.collection_id = c.collection_id;

-- Query 6: An update operation with any necessary triggers

UPDATE Ownership SET owned = FALSE WHERE object_id = 1;

-- Query 7: A deletion operation with any necessary triggers
-- (Delete an exhibition and associated art objects, collections, and ownership)
-- Create a trigger to handle deletion cascade
-- Create a trigger for deletion
DELIMITER //

CREATE TRIGGER before_exhibition_deletion
BEFORE DELETE ON Exhibitions
FOR EACH ROW
BEGIN
    INSERT INTO Exhibitions_Log (exhibition_id, exhibition_name, museum_name, deleted_at)
    VALUES (OLD.exhibition_id, OLD.exhibition_name, OLD.museum_name, NOW());
END;
//

DELIMITER ;

