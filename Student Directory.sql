use importcsv;
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
    Final_Project_Score INT)
    ;
INSERT INTO Physics1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance,Week4_Attendance,First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT 
    Name, 
    Surname, 
    Email,
    ROUND(RAND() * 100, 2) AS Week1_Attendance,       -- Random percentage between 80-100
    ROUND(RAND() * 100, 2) AS Week2_Attendance,       -- Random percentage between 60-100
    ROUND(RAND() * 100, 2) AS Week3_Attendance,       -- Random percentage between 70-100 
	ROUND(RAND() * 100, 2) AS Week4_Attendance,       -- Random percentage between 50-100
    FLOOR(RAND() * 100) + 1 AS First_Project_Score,   -- Random integer between 30-100
    FLOOR(RAND() * 100) + 1 AS Second_Project_Score,  -- Random integer between 60-100
    FLOOR(RAND() * 100) + 1 AS Final_Project_Score    -- Random integer between 50-100
FROM student_directory
WHERE Class = 'Physics1';

INSERT INTO Maths1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance,Week4_Attendance,First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT 
    Name, 
    Surname, 
    Email,
    ROUND(RAND() * 100, 2) AS Week1_Attendance,       -- Random percentage between 50-100
    ROUND(RAND() * 100, 2) AS Week2_Attendance,       -- Random percentage between 80-100
    ROUND(RAND() * 100, 2) AS Week3_Attendance,       -- Random percentage between 70-100
	ROUND(RAND() * 100, 2) AS Week4_Attendance,       -- Random percentage between 60-100
    FLOOR(RAND() * 100) + 1 AS First_Project_Score,   -- Random integer between 30-100
    FLOOR(RAND() * 100) + 1 AS Second_Project_Score,  -- Random integer between 50-100
    FLOOR(RAND() * 100) + 1 AS Final_Project_Score    -- Random integer between 50-100
FROM student_directory
WHERE Class = 'Maths1';

Select (((Week1_Attendance+Week2_Attendance+Week3_Attendance+Week4_Attendance)/4 ) *0.4 +(First_Project_Score+First_Project_Score)*0.3+Final_Project_score * 0.3) as Certfification_Score , surname, name, email from maths1learners;

Select  (Week1_Attendance+Week2_Attendance+Week3_Attendance+Week4_Attendance)/4  AS AttendanceOverall , surname, name, email from physics1learners
order by AttendanceOverall;

select Name,surname, CerificationScore from  maths1learners ;

Select  (((Week1_Attendance+Week2_Attendance+Week3_Attendance+Week4_Attendance)/4 ) *0.4 +(First_Project_Score+First_Project_Score)*0.3+Final_Project_score * 0.3) as Certfification_Score , surname, name, email from maths1learners;

Select (((p.Week1_Attendance+p.Week2_Attendance+p.Week3_Attendance+p.Week4_Attendance)/4 ) *0.4 +(p.First_Project_Score+p.Second_Project_Score)*0.3+p.Final_Project_score * 0.3) as Certification_Score_P ,  (((m.Week1_Attendance+m.Week2_Attendance+m.Week3_Attendance+m.Week4_Attendance)/4 ) *0.4 +(m.First_Project_Score+m.Second_Project_Score)*0.3+m.Final_Project_score * 0.3) as Certification_Score_M, sd.surname, sd.class,sd.name, sd.email from student_directory sd
left join maths1learners m
on sd.email= m.Email
left join physics1learners p
on sd.email= p.Email
order by class, certification_Score_M desc ,certification_Score_P desc
;

SELECT 
    sd.Name,
    sd.Surname,
    sd.Email,
    sd.Class,
    -- Physics1 columns
    p.Week1_Attendance AS Physics1_Week1_Attendance,
    p.Week2_Attendance AS Physics1_Week2_Attendance,
    p.First_Project_Score AS Physics1_First_Project_Score,
    p.Second_Project_Score AS Physics1_Second_Project_Score,
    p.Final_Project_Score AS Physics1_Final_Project_Score,
    -- Maths1 columns
    m.Week1_Attendance AS Maths1_Week1_Attendance,
    m.Week2_Attendance AS Maths1_Week2_Attendance,
    m.First_Project_Score AS Maths1_First_Project_Score,
    m.Second_Project_Score AS Maths1_Second_Project_Score,
    m.Final_Project_Score AS Maths1_Final_Project_Score
FROM 
    student_directory sd
LEFT JOIN 
    Physics1Learners p
    ON sd.Email = p.Email -- Match based on email for Physics1
LEFT JOIN 
    Maths1Learners m
    ON sd.Email = m.Email -- Match based on email for Maths1;

