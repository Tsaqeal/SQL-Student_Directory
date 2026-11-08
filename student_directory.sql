-- ---------------------------------------------------------------------
-- 1. DATABASE SETUP & MASTER DIRECTORY
-- ---------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS student_directory;
USE student_directory;

-- Master student directory table structure (populated via your 50-row CSV import)
CREATE TABLE IF NOT EXISTS student_directory (
    Learner_ID INT PRIMARY KEY,
    Name VARCHAR(50),
    Surname VARCHAR(50),
    Email VARCHAR(100),
    Class VARCHAR(50)
);

-- ---------------------------------------------------------------------
-- 2. DYNAMIC CRITERIA & CONFIGURATION TABLE
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Criteria (
    Criterion_Name VARCHAR(50) PRIMARY KEY,
    Weight DECIMAL(3, 2),
    Description VARCHAR(100)
);

TRUNCATE TABLE Criteria;
INSERT INTO Criteria (Criterion_Name, Weight, Description) VALUES
('Attendance_Weight', 0.40, 'Weight applied to overall average attendance'),
('First_Project_Weight', 0.15, 'Weight applied to first project score'),
('Second_Project_Weight', 0.15, 'Weight applied to second project score'),
('Final_Project_Weight', 0.30, 'Weight applied to final project score');

-- ---------------------------------------------------------------------
-- 3. CLASS-SPECIFIC RELATIONAL TABLES (Consistent Column Naming)
-- ---------------------------------------------------------------------

-- Physics Class Table
CREATE TABLE IF NOT EXISTS Physics1Learners (
    Name VARCHAR(50),
    Surname VARCHAR(50),
    Email VARCHAR(100) PRIMARY KEY,
    Week1_Attendance DECIMAL(5, 2),
    Week2_Attendance DECIMAL(5, 2),
    Week3_Attendance DECIMAL(5, 2),
    Week4_Attendance DECIMAL(5, 2),
    First_Project_Score INT,
    Second_Project_Score INT,
    Final_Project_Score INT
);

-- Maths Class Table
CREATE TABLE IF NOT EXISTS Maths1Learners (
    Name VARCHAR(50),
    Surname VARCHAR(50),
    Email VARCHAR(100) PRIMARY KEY,
    Week1_Attendance DECIMAL(5, 2),
    Week2_Attendance DECIMAL(5, 2),
    Week3_Attendance DECIMAL(5, 2),
    Week4_Attendance DECIMAL(5, 2),
    First_Project_Score INT,
    Second_Project_Score INT,
    Final_Project_Score INT
);

-- English Class Table
CREATE TABLE IF NOT EXISTS English1Learners (
    Name VARCHAR(50),
    Surname VARCHAR(50),
    Email VARCHAR(100) PRIMARY KEY,
    Week1_Attendance DECIMAL(5, 2),
    Week2_Attendance DECIMAL(5, 2),
    Week3_Attendance DECIMAL(5, 2),
    Week4_Attendance DECIMAL(5, 2),
    First_Project_Score INT,
    Second_Project_Score INT,
    Final_Project_Score INT
);

-- Clear existing class data before fresh population
TRUNCATE TABLE Physics1Learners;
TRUNCATE TABLE Maths1Learners;
TRUNCATE TABLE English1Learners;

-- Populate Physics learners with randomized data
INSERT INTO Physics1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT Name, Surname, Email,
       ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2),
       FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1
FROM student_directory
WHERE Class = 'Physics1';

-- Populate Maths learners with randomized data
INSERT INTO Maths1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT Name, Surname, Email,
       ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2),
       FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1
FROM student_directory
WHERE Class = 'Maths1';

-- Populate English learners with randomized data
INSERT INTO English1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT Name, Surname, Email,
       ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2),
       FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1
FROM student_directory
WHERE Class = 'English1';

-- ---------------------------------------------------------------------
-- 4. CENTRALIZED CERTIFICATIONS & EVALUATION TABLE
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Certifications (
    Certification_ID INT AUTO_INCREMENT PRIMARY KEY,
    Learner_ID INT,
    Name VARCHAR(50),
    Surname VARCHAR(50),
    Email VARCHAR(100),
    Class VARCHAR(50),
    Final_Certification_Score DECIMAL(5, 2),
    Status VARCHAR(20)
);

TRUNCATE TABLE Certifications;

-- Populate Certifications table referencing weights dynamically from Criteria
INSERT INTO Certifications (Learner_ID, Name, Surname, Email, Class, Final_Certification_Score, Status)
SELECT 
    sd.Learner_ID,
    sd.Name,
    sd.Surname,
    sd.Email,
    sd.Class,
    ROUND(
        CASE 
            WHEN sd.Class = 'Physics1' THEN 
                ((p.Week1_Attendance + p.Week2_Attendance + p.Week3_Attendance + p.Week4_Attendance) / 4) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Attendance_Weight')
                + (p.First_Project_Score * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'First_Project_Weight'))
                + (p.Second_Project_Score * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Second_Project_Weight'))
                + (p.Final_Project_Score * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Final_Project_Weight'))
            WHEN sd.Class = 'Maths1' THEN 
                ((m.Week1_Attendance + m.Week2_Attendance + m.Week3_Attendance + m.Week4_Attendance) / 4) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Attendance_Weight')
                + (m.First_Project_Score * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'First_Project_Weight'))
                + (m.Second_Project_Score * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Second_Project_Weight'))
                + (m.Final_Project_Score * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Final_Project_Weight'))
            WHEN sd.Class = 'English1' THEN 
                ((e.Week1_Attendance + e.Week2_Attendance + e.Week3_Attendance + e.Week4_Attendance) / 4) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Attendance_Weight')
                + (e.First_Project_Score * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'First_Project_Weight'))
                + (e.Second_Project_Score * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Second_Project_Weight'))
                + (e.Final_Project_Score * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Final_Project_Weight'))
            ELSE 0
        END, 2) AS Final_Certification_Score,
    CASE 
        WHEN (
            CASE 
                WHEN sd.Class = 'Physics1' THEN ((p.Week1_Attendance + p.Week2_Attendance + p.Week3_Attendance + p.Week4_Attendance) / 4) * 0.4 + p.First_Project_Score * 0.15 + p.Second_Project_Score * 0.15 + p.Final_Project_Score * 0.3
                WHEN sd.Class = 'Maths1' THEN ((m.Week1_Attendance + m.Week2_Attendance + m.Week3_Attendance + m.Week4_Attendance) / 4) * 0.4 + m.First_Project_Score * 0.15 + m.Second_Project_Score * 0.15 + m.Final_Project_Score * 0.3
                WHEN sd.Class = 'English1' THEN ((e.Week1_Attendance + e.Week2_Attendance + e.Week3_Attendance + e.Week4_Attendance) / 4) * 0.4 + e.First_Project_Score * 0.15 + e.Second_Project_Score * 0.15 + e.Final_Project_Score * 0.3
                ELSE 0
            END
        ) >= 50 THEN 'Certified'
        ELSE 'Fail'
    END AS Status
FROM student_directory sd
LEFT JOIN Physics1Learners p ON sd.Email = p.Email
LEFT JOIN Maths1Learners m ON sd.Email = m.Email
LEFT JOIN English1Learners e ON sd.Email = e.Email;

-- ---------------------------------------------------------------------
-- 5. FINAL ANALYTICAL QUERY
-- ---------------------------------------------------------------------
SELECT * FROM Certifications 
ORDER BY Class, Final_Certification_Score DESC;