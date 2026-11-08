# SQL Student Analytics Project

Welcome to my SQL Student Analytics project! This repository demonstrates my ability to work with relational databases, write complex SQL queries, and perform data analysis. The project focuses on creating and managing tables for student data, analyzing attendance and performance, and generating meaningful insights.

This project showcases my expertise in database design, data manipulation, and analysis using SQL.

---

## Project Objectives

### Data Management
- Create and manage relational tables for students in Physics1, Maths1, and English1 classes.
- Use data from a central directory (`student_directory`) populated via `student_directory.csv` to populate class-specific tables.

### Data Analysis
- Calculate attendance percentages and project scores.
- Compute certification scores for students based on dynamic criteria-driven weights.
- Compare and rank students across different classes.

---

## What This Project Demonstrates
- **SQL Proficiency:** Table creation, data population, dynamic configuration querying, and advanced joins.
- **Data Analysis:** Use of calculated fields and configuration tables to derive insights such as certification scores.
- **Relational Database Design:** Joining multiple tables and organizing data effectively.
- **Problem-Solving Skills:** Translating business logic (e.g., dynamic certification scoring) into efficient SQL queries.

---

## Repository Structure
* **`student_directory.csv`**: Raw master dataset containing student records.
* **`Student Directory.sql`**: Complete SQL script to set up tables, populate data, and run analytical queries.
* **`README.md`**: Project documentation and execution instructions.

---

## Features

### Relational Table Design
- **`Physics1Learners`:** Stores weekly attendance and project scores for Physics1 students.
- **`Maths1Learners`:** Stores the same for Maths1 students.
- **`English1Learners`:** Stores the same for English1 students.
- **`Criteria`:** Dynamic configuration table storing evaluation weight parameters.
- **`Certifications`:** Centralized analytical table storing final weighted scores and pass/fail statuses.

### Dynamic Data Generation
- Randomized attendance percentages and project scores to simulate real-world data.

### Certification Score Calculation
The certification score is calculated dynamically by pulling weights from the configuration criteria table:
- Certification Score = (Average Attendance × W_Attendance) + (First and Second Project Scores × W_Projects) + (Final Project Score × W_Final)

---

## How to Run This Project

### Prerequisites
- A MySQL-compatible database (e.g., MySQL Workbench).
- The `student_directory` master table imported from `student_directory.csv`.

### Steps to Run

1. **Clone the Repository:**

git clone [https://github.com/Tsaqeal/SQL-Student_Directory.git](https://github.com/Tsaqeal/SQL-Student_Directory.git)
```
cd SQL-Student_Directory
```
1
## Project Script

```sql
-- Select the database you are using
USE student_directory;

-- Create the Criteria configuration table
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

-- Create the Physics1Learners table
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

-- Create the Maths1Learners table
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

-- Create the English1Learners table
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

-- Clear and populate class tables with random data from student_directory
TRUNCATE TABLE Physics1Learners;
INSERT INTO Physics1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT Name, Surname, Email,
       ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2),
       FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1
FROM student_directory
WHERE Class = 'Physics1';

TRUNCATE TABLE Maths1Learners;
INSERT INTO Maths1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT Name, Surname, Email,
       ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2),
       FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1
FROM student_directory
WHERE Class = 'Maths1';

TRUNCATE TABLE English1Learners;
INSERT INTO English1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT Name, Surname, Email,
       ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2), ROUND(RAND() * 100, 2),
       FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1, FLOOR(RAND() * 100) + 1
FROM student_directory
WHERE Class = 'English1';

```


## Example Queries
### Joining and Analyzing Data via Criteria Config

```SELECT 
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
        END, 2) AS Final_Certification_Score
FROM student_directory sd
LEFT JOIN Physics1Learners p ON sd.Email = p.Email
LEFT JOIN Maths1Learners m ON sd.Email = m.Email
LEFT JOIN English1Learners e ON sd.Email = e.Email
ORDER BY sd.Class, Final_Certification_Score DESC;
```

### Attendance calculation
```
SELECT 
    (Week1_Attendance + Week2_Attendance + Week3_Attendance + Week4_Attendance) / 4 AS AttendanceOverall,
    Surname, Name, Email 
FROM Physics1Learners
ORDER BY AttendanceOverall DESC;
```
