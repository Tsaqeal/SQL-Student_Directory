-- Select the database you are using
USE student_directory;

-- Create the Criteria configuration table for weighted grading
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

-- Create subject learner tables including Chemistry1
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

CREATE TABLE IF NOT EXISTS Chemistry1Learners (
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

-- Populate Physics1Learners with balanced non-zero random data (Scores 50-100)
TRUNCATE TABLE Physics1Learners;
INSERT INTO Physics1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT Name, Surname, Email,
       ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2),
       FLOOR(50 + RAND() * 50), FLOOR(50 + RAND() * 50), FLOOR(50 + RAND() * 50)
FROM student_directory
WHERE Class = 'Physics1';

-- Populate Maths1Learners with balanced non-zero random data (Scores 50-100)
TRUNCATE TABLE Maths1Learners;
INSERT INTO Maths1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT Name, Surname, Email,
       ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2),
       FLOOR(50 + RAND() * 50), FLOOR(50 + RAND() * 50), FLOOR(50 + RAND() * 50)
FROM student_directory
WHERE Class = 'Maths1';

-- Populate English1Learners with balanced non-zero random data (Scores 50-100)
TRUNCATE TABLE English1Learners;
INSERT INTO English1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT Name, Surname, Email,
       ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2),
       FLOOR(50 + RAND() * 50), FLOOR(50 + RAND() * 50), FLOOR(50 + RAND() * 50)
FROM student_directory
WHERE Class = 'English1';

-- Populate Chemistry1Learners with balanced non-zero random data (Scores 50-100)
TRUNCATE TABLE Chemistry1Learners;
INSERT INTO Chemistry1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT Name, Surname, Email,
       ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2), ROUND(50 + (RAND() * 50), 2),
       FLOOR(50 + RAND() * 50), FLOOR(50 + RAND() * 50), FLOOR(50 + RAND() * 50)
FROM student_directory
WHERE Class = 'Chemistry1';

-- Comprehensive Analytical Query: Uses COALESCE across all subjects and grades performance categories
SELECT 
    sd.Name,
    sd.Surname,
    sd.Email,
    sd.Class,
    ROUND(
        (
            (
                COALESCE(p.Week1_Attendance, m.Week1_Attendance, e.Week1_Attendance, c.Week1_Attendance, 0) + 
                COALESCE(p.Week2_Attendance, m.Week2_Attendance, e.Week2_Attendance, c.Week2_Attendance, 0) + 
                COALESCE(p.Week3_Attendance, m.Week3_Attendance, e.Week3_Attendance, c.Week3_Attendance, 0) + 
                COALESCE(p.Week4_Attendance, m.Week4_Attendance, e.Week4_Attendance, c.Week4_Attendance, 0)
            ) / 4.0
        ) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Attendance_Weight')
        
        + COALESCE(p.First_Project_Score, m.First_Project_Score, e.First_Project_Score, c.First_Project_Score, 0) 
          * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'First_Project_Weight')
          
        + COALESCE(p.Second_Project_Score, m.Second_Project_Score, e.Second_Project_Score, c.Second_Project_Score, 0) 
          * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Second_Project_Weight')
          
        + COALESCE(p.Final_Project_Score, m.Final_Project_Score, e.Final_Project_Score, c.Final_Project_Score, 0) 
          * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Final_Project_Weight')
    , 2) AS Final_Certification_Score,
    CASE 
        WHEN 
            (
                (
                    COALESCE(p.Week1_Attendance, m.Week1_Attendance, e.Week1_Attendance, c.Week1_Attendance, 0) + 
                    COALESCE(p.Week2_Attendance, m.Week2_Attendance, e.Week2_Attendance, c.Week2_Attendance, 0) + 
                    COALESCE(p.Week3_Attendance, m.Week3_Attendance, e.Week3_Attendance, c.Week3_Attendance, 0) + 
                    COALESCE(p.Week4_Attendance, m.Week4_Attendance, e.Week4_Attendance, c.Week4_Attendance, 0)
                ) / 4.0
            ) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Attendance_Weight')
            + COALESCE(p.First_Project_Score, m.First_Project_Score, e.First_Project_Score, c.First_Project_Score, 0) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'First_Project_Weight')
            + COALESCE(p.Second_Project_Score, m.Second_Project_Score, e.Second_Project_Score, c.Second_Project_Score, 0) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Second_Project_Weight')
            + COALESCE(p.Final_Project_Score, m.Final_Project_Score, e.Final_Project_Score, c.Final_Project_Score, 0) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Final_Project_Weight') 
            >= 89 THEN 'Excellent'
        WHEN 
            (
                (
                    COALESCE(p.Week1_Attendance, m.Week1_Attendance, e.Week1_Attendance, c.Week1_Attendance, 0) + 
                    COALESCE(p.Week2_Attendance, m.Week2_Attendance, e.Week2_Attendance, c.Week2_Attendance, 0) + 
                    COALESCE(p.Week3_Attendance, m.Week3_Attendance, e.Week3_Attendance, c.Week3_Attendance, 0) + 
                    COALESCE(p.Week4_Attendance, m.Week4_Attendance, e.Week4_Attendance, c.Week4_Attendance, 0)
                ) / 4
            ) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Attendance_Weight')
            + COALESCE(p.First_Project_Score, m.First_Project_Score, e.First_Project_Score, c.First_Project_Score, 0) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'First_Project_Weight')
            + COALESCE(p.Second_Project_Score, m.Second_Project_Score, e.Second_Project_Score, c.Second_Project_Score, 0) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Second_Project_Weight')
            + COALESCE(p.Final_Project_Score, m.Final_Project_Score, e.Final_Project_Score, c.Final_Project_Score, 0) * (SELECT Weight FROM Criteria WHERE Criterion_Name = 'Final_Project_Weight') 
            >= 70 THEN 'Passed'
        ELSE 'Failed'
    END AS Status
FROM student_directory sd
LEFT JOIN Physics1Learners p ON sd.Email = p.Email
LEFT JOIN Maths1Learners m ON sd.Email = m.Email
LEFT JOIN English1Learners e ON sd.Email = e.Email
LEFT JOIN Chemistry1Learners c ON sd.Email = c.Email
ORDER BY Final_Certification_Score DESC;