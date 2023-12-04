CREATE DATABASE IF NOT EXISTS art_gallery;

USE art_gallery;

-- Create Exhibitions table
CREATE TABLE IF NOT EXISTS Exhibitions (
    exhibition_id INT PRIMARY KEY AUTO_INCREMENT,
    exhibition_name VARCHAR(255) NOT NULL,
    museum_name VARCHAR(255) NOT NULL
);

-- Create ArtObjects table
CREATE TABLE IF NOT EXISTS ArtObjects (
    object_id INT PRIMARY KEY AUTO_INCREMENT,
    object_name VARCHAR(255) NOT NULL,
    category ENUM('painting', 'sculpture', 'other') NOT NULL,
    exhibition_id INT,
    FOREIGN KEY (exhibition_id) REFERENCES Exhibitions(exhibition_id) ON DELETE CASCADE
);

-- Create Collections table
CREATE TABLE IF NOT EXISTS Collections (
    collection_id INT PRIMARY KEY AUTO_INCREMENT,
    collection_name VARCHAR(255) NOT NULL,
    description TEXT
);


-- Create Ownership table
CREATE TABLE IF NOT EXISTS Ownership (
    ownership_id INT PRIMARY KEY AUTO_INCREMENT,
    object_id INT,
    collection_id INT,
    owned BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (object_id) REFERENCES ArtObjects(object_id) ON DELETE CASCADE,
    FOREIGN KEY (collection_id) REFERENCES Collections(collection_id) ON DELETE CASCADE
);

-- Insert data for Exhibitions
INSERT INTO Exhibitions (exhibition_name, museum_name) VALUES
('The Tudors: Art and Majesty in Renaissance England', 'The Met Museum'),
('Cubism and the Trompe l’Oeil Tradition', 'The Met Museum'),
('Hear Me Now: The Black Potters of Old Edgefield, South Carolina', 'Placeholder Museum');

-- Insert data for ArtObjects with more descriptive names for paintings, sculptures, and other
INSERT INTO ArtObjects (object_name, category, exhibition_id) VALUES
('Still Life with Chair Caning', 'painting', 1),
('The Absinthe Glass', 'sculpture', 1),
('Cup and cover', 'other', 1),
('Trompe lOeil Still Life', 'painting', 1),
('Portrait Bust of John Fisher, Bishop of Rochester', 'sculpture', 1),
('Ewer from Burghley House, Lincolnshire', 'other', 1);

-- Insert data for Collections with more descriptive names
INSERT INTO Collections (collection_name, description) VALUES
('Arms and Armour Collection', 'Description for Collection 1'),
('Drawing and Prints Collection', 'Description for Collection 2');

-- Insert data for Ownership
INSERT INTO Ownership (object_id, collection_id) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 2),
(5, 2),
(6, 2);

UPDATE ArtObjects SET object_name = 'Still Life with Chair Caning' WHERE object_id = 1;
UPDATE ArtObjects SET object_name = 'The Absinthe Glass' WHERE object_id = 2;
UPDATE ArtObjects SET object_name = 'Cup and Cover' WHERE object_id = 3;
UPDATE ArtObjects SET object_name = 'Trompe l\'Oeil Still Life' WHERE object_id = 4;
UPDATE ArtObjects SET object_name = 'Portrait Bust of John Fisher, Bishop of Rochester' WHERE object_id = 5;
UPDATE ArtObjects SET object_name = 'Ewer from Burghley House, Lincolnshire' WHERE object_id = 6;


DROP ROLE IF EXISTS db_admin@localhost, read_access@localhost, employee@localhost;

CREATE ROLE db_admin@localhost, read_access@localhost, employee@localhost;
GRANT ALL PRIVILEGES ON art_gallery.* TO db_admin@localhost;
GRANT SELECT ON art_gallery.* TO read_access@localhost;

DROP USER IF EXISTS admin1@localhost;
DROP USER IF EXISTS guest@localhost;
DROP USER IF EXISTS employee@localhost;

CREATE USER admin1@localhost IDENTIFIED WITH mysql_native_password BY 'password';
CREATE USER guest@localhost;
CREATE USER employee@localhost;

GRANT db_admin@localhost TO admin1@localhost;
GRANT read_access@localhost TO guest@localhost;

GRANT SELECT ON art_gallery.* TO employee@localhost;
GRANT INSERT ON art_gallery.Exhibitions TO employee@localhost;
GRANT INSERT ON art_gallery.ArtObjects TO employee@localhost;
GRANT INSERT ON art_gallery.Collections TO employee@localhost;
GRANT UPDATE ON art_gallery.Exhibitions TO employee@localhost;
GRANT UPDATE ON art_gallery.ArtObjects TO employee@localhost;
GRANT UPDATE ON art_gallery.Collections TO employee@localhost;
GRANT DELETE ON art_gallery.Exhibitions TO employee@localhost;
GRANT DELETE ON art_gallery.ArtObjects TO employee@localhost;
GRANT DELETE ON art_gallery.Collections TO employee@localhost;

SET DEFAULT ROLE ALL TO admin1@localhost;

