Database Trigger : Write a database trigger on Library table. The System should keep track of the records that are 
being updated or deleted. The old value of updated or deleted records should be added in 
Library_Audit table.


-- Step 1: Create Library table
CREATE TABLE Library (
    Book_ID INT PRIMARY KEY,
    Book_Title VARCHAR(100),
    Author VARCHAR(100)
);

-- Step 2: Insert sample data
INSERT INTO Library (Book_ID, Book_Title, Author) VALUES
(1, 'Introduction to SQL', 'John Doe'),
(2, 'Advanced SQL Techniques', 'Jane Smith'),
(3, 'Database Management', 'Alice Brown');

-- Step 3: Create Library_Audit table
CREATE TABLE Library_Audit (
    Audit_ID INT AUTO_INCREMENT PRIMARY KEY,
    Book_ID INT,
    Book_Title VARCHAR(100),
    Author VARCHAR(100),
    Action_Type VARCHAR(10),
    Action_Timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 4: Create triggers
DELIMITER //

CREATE TRIGGER Library_Update_Audit
AFTER UPDATE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (Book_ID, Book_Title, Author, Action_Type)
    VALUES (OLD.Book_ID, OLD.Book_Title, OLD.Author, 'UPDATE');
END;
//

CREATE TRIGGER Library_Delete_Audit
AFTER DELETE ON Library
FOR EACH ROW
BEGIN
    INSERT INTO Library_Audit (Book_ID, Book_Title, Author, Action_Type)
    VALUES (OLD.Book_ID, OLD.Book_Title, OLD.Author, 'DELETE');
END;
//

DELIMITER ;

-- Step 5: Test the triggers
UPDATE Library
SET Book_Title = 'SQL Essentials'
WHERE Book_ID = 1;

DELETE FROM Library
WHERE Book_ID = 2;

-- Verify by checking Library_Audit
SELECT * FROM Library_Audit;
