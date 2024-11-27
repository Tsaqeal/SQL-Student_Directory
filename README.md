# SQL Student Analytics Project

Welcome to my SQL Student Analytics project! This repository demonstrates my ability to work with relational databases, write complex SQL queries, and perform data analysis. The project focuses on creating and managing tables for student data, analyzing attendance and performance, and generating meaningful insights.

This project showcases my expertise in database design, data manipulation, and analysis using SQL.

---

## Project Objectives

### Data Management
- Create and manage relational tables for students in Physics1 and Maths1 classes.
- Use data from a central directory (`student_directory`) to populate class-specific tables.

### Data Analysis
- Calculate attendance percentages and project scores.
- Compute certification scores for students based on weighted metrics.
- Compare and rank students across different classes.

---

## What This Project Demonstrates
- **SQL Proficiency**: Table creation, data population, and advanced querying.
- **Data Analysis**: Use of calculated fields to derive insights such as certification scores.
- **Relational Database Design**: Joining multiple tables and organizing data effectively.
- **Problem-Solving Skills**: Translating business logic (e.g., certification scoring) into efficient SQL queries.

---

## Features

### Relational Table Design
- **Physics1Learners**: Stores weekly attendance and project scores for Physics1 students.
- **Maths1Learners**: Stores the same for Maths1 students.

### Dynamic Data Generation
- Randomized attendance percentages and project scores to simulate real-world data.

### Certification Score Calculation
Combines attendance and project scores using the formula:

- Certification Score = (Average Attendance * 0.4) 
                      + (First & Second Project Scores * 0.3) 
                      + (Final Project Score * 0.3)


---

## Features

### Table Creation
- **Physics1Learners**: Contains weekly attendance percentages and project scores for Physics1 students.
- **Maths1Learners**: Contains similar data for Maths1 students.
- **Below** is the code that you would use to create the tables for Physics1 and Maths1 students, import the data from the student_directory table, and perform various analyses as mentioned. 

```text
-- Select the database you are using (assuming 'importcsv' in this case)
USE importcsv;

-- Create the Physics1Learners table to store Physics students data
CREATE TABLE Physics1Learners (
    Name VARCHAR(50),
    Surname VARCHAR(50),
    Email VARCHAR(100),
    Week1_Attendance DECIMAL(5, 2),
    Week2_Attendance DECIMAL(5, 2),
    Week3_Attendance DECIMAL(5, 2),
    Week4_Attendance DECIMAL(5, 2),
    First_Project_Score INT,
    Second_Project_Score INT,
    Final_Project_Score INT
);

-- Create the Maths1Learners table to store Maths students data
CREATE TABLE Maths1Learners (
    Name VARCHAR(50),
    Surname VARCHAR(50),
    Email VARCHAR(100),
    Week1_Attendance DECIMAL(5, 2),
    Week2_Attendance DECIMAL(5, 2),
    Week3_Attendance DECIMAL(5, 2),
    Week4_Attendance DECIMAL(5, 2),
    First_Project_Score INT,
    Second_Project_Score INT,
    Final_Project_Score INT
);

-- Populate Physics1Learners table with random data from student_directory where class is 'Physics1'
INSERT INTO Physics1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT 
    Name, 
    Surname, 
    Email,
    ROUND(RAND() * 100, 2) AS Week1_Attendance,
    ROUND(RAND() * 100, 2) AS Week2_Attendance,
    ROUND(RAND() * 100, 2) AS Week3_Attendance,
    ROUND(RAND() * 100, 2) AS Week4_Attendance,
    FLOOR(RAND() * 100) + 1 AS First_Project_Score,
    FLOOR(RAND() * 100) + 1 AS Second_Project_Score,
    FLOOR(RAND() * 100) + 1 AS Final_Project_Score
FROM student_directory
WHERE Class = 'Physics1';

-- Populate Maths1Learners table with random data from student_directory where class is 'Maths1'
INSERT INTO Maths1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT 
    Name, 
    Surname, 
    Email,
    ROUND(RAND() * 100, 2) AS Week1_Attendance,
    ROUND(RAND() * 100, 2) AS Week2_Attendance,
    ROUND(RAND() * 100, 2) AS Week3_Attendance,
    ROUND(RAND() * 100, 2) AS Week4_Attendance,
    FLOOR(RAND() * 100) + 1 AS First_Project_Score,
    FLOOR(RAND() * 100) + 1 AS Second_Project_Score,
    FLOOR(RAND() * 100) + 1 AS Final_Project_Score
FROM student_directory
WHERE Class = 'Maths1';

```


  























### Certification Score Calculation
The certification score is calculated using the formula:


Certification Score = (Average Attendance * 0.4) 
                      + (First & Second Project Scores * 0.3) 
                      + (Final Project Score * 0.3).


	
## How to Use:

- Clone the Repository


- Run the Script
- Open the student_analytics.sql file in your SQL editor.
- Execute the script step-by-step:
- Create tables.
- Populate data using randomized values.
- Run analysis queries to retrieve insights.
- Analyze the Data
- Use the provided queries to calculate attendance and certification scores.
- Customize the queries to extract additional insights.
- Example Outputs
- Certification Scores.

## Example Queries:

```text
-- Joining and Analyzing Data:
SELECT 
    (
        (
            (p.Week1_Attendance + p.Week2_Attendance + p.Week3_Attendance + p.Week4_Attendance) / 4
        ) * 0.4 
        + ((p.First_Project_Score + p.Second_Project_Score) * 0.3) 
        + (p.Final_Project_Score * 0.3)
    ) AS Certification_Score_P,
    (
        (
            (m.Week1_Attendance + m.Week2_Attendance + m.Week3_Attendance + m.Week4_Attendance) / 4
        ) * 0.4 
        + ((m.First_Project_Score + m.Second_Project_Score) * 0.3) 
        + (m.Final_Project_Score * 0.3)
    ) AS Certification_Score_M,
    sd.Surname, 
    sd.Class, 
    sd.Name, 
    sd.Email
FROM student_directory sd
LEFT JOIN Maths1Learners m 
    ON sd.Email = m.Email
LEFT JOIN Physics1Learners p 
    ON sd.Email = p.Email
ORDER BY 
    sd.Class, 
    Certification_Score_M DESC, 
    Certification_Score_P DESC;



  

-- Attendance Calculation:
SELECT 
    (Week1_Attendance + Week2_Attendance + Week3_Attendance + Week4_Attendance) / 4 AS AttendanceOverall,
    Surname, Name, Email 
FROM Physics1Learners
ORDER BY AttendanceOverall DESC;

```

## How to Run This Project
-Prerequisites:
- A MySQL-compatible database.
- A student_directory table with these columns:

# Steps to Run;
### Clone the Repository:

git clone https://github.com/your-username/sql-student-analytics.git
cd sql-student-analytics

## Import the SQL Script:

#### Open student_analytics.sql in your preferred SQL editor (e.g., MySQL Workbench).
- Execute the script step-by-step:
- Create the tables for Physics1Learners and Maths1Learners.
- Populate tables with data.
- Run the queries for analysis.

## Why This Project Matters
# This project illustrates how I can:

- Translate complex requirements into efficient SQL logic.
- Work with relational databases to organize, manage, and analyze data.
- Provide actionable insights through thoughtful querying and data aggregation.
## About Me:

I’m a database enthusiast and aspiring data professional with a passion for solving problems through data. This project reflects my ability to handle real-world data challenges and present insights effectively.

