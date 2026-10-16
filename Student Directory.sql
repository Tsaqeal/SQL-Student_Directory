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

-- Insert data into Physics1Learners
INSERT INTO Physics1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT 
    Name, 
    Surname, 
    Email,
    ROUND(80 + RAND() * 20, 2) AS Week1_Attendance,       -- Random percentage between 80-100
    ROUND(60 + RAND() * 40, 2) AS Week2_Attendance,       -- Random percentage between 60-100
    ROUND(70 + RAND() * 30, 2) AS Week3_Attendance,       -- Random percentage between 70-100
    ROUND(50 + RAND() * 50, 2) AS Week4_Attendance,       -- Random percentage between 50-100
    FLOOR(30 + RAND() * 71) AS First_Project_Score,       -- Random integer between 30-100
    FLOOR(60 + RAND() * 41) AS Second_Project_Score,      -- Random integer between 60-100
    FLOOR(50 + RAND() * 51) AS Final_Project_Score        -- Random integer between 50-100
FROM student_directory
WHERE Class = 'Physics1';

-- Insert data into Maths1Learners
INSERT INTO Maths1Learners (Name, Surname, Email, Week1_Attendance, Week2_Attendance, Week3_Attendance, Week4_Attendance, First_Project_Score, Second_Project_Score, Final_Project_Score)
SELECT 
    Name, 
    Surname, 
    Email,
    ROUND(90 + RAND() * 10, 2) AS Week1_Attendance,       -- Random percentage between 90-100
    ROUND(80 + RAND() * 20, 2) AS Week2_Attendance,       -- Random percentage between 80-100
    ROUND(70 + RAND() * 30, 2) AS Week3_Attendance,       -- Random percentage between 70-100
    ROUND(40 + RAND() * 60, 2) AS Week4_Attendance,       -- Random percentage between 40-100
    FLOOR(70 + RAND() * 31) AS First_Project_Score,       -- Random integer between 70-100
    FLOOR(80 + RAND() * 21) AS Second_Project_Score,      -- Random integer between 80-100
    FLOOR(70 + RAND() * 31) AS Final_Project_Score        -- Random integer between 70-100
FROM student_directory
WHERE Class = 'Maths1';
		

Select  (p.Week1_Attendance  + p.Week2_Attendance+ p.Week3_Attendance + Week4_Attendance)/4 as Avg_Att , s.email, s.name  from student_directory s
left join physics1learners p
on s.email = p.email
Having Avg_Att < 85;

Update maths1learners
set  Name = "Ronald_(M)", Email = "(M)rondaldconnan@gmail.com"  
where Name = "Ronald";  -- With this one i have changed 2 Ronald from maths while I wanted only the one had a same name with another learner from Physics1 class

Update maths1learners
set  Name = "Ronaldo"
where name="Ronaldi" and surname ="Pape";

Alter table maths1learners
add column Concern_Status Varchar (3);

Alter table physics1learners
add column Concern_Status Varchar (3);




-- Create a query to get a concern status of learner based on attendance 


-- calculates their average attendance over four weeks, and then adds a new column called concern_Status. 
-- This concern_Status column will be either :
-- 1)Concern if the student's average attendance is below 80%  
-- 2)Not Concern (attendance over 80%)  
-- This allows you to easily identify students whose attendance might be a cause for concern.




Select 
Name ,
Surname,
round((Week1_Attendance+Week2_Attendance+Week3_Attendance+Week4_Attendance)/4,2) as Attendance_Overall ,

Case when round((Week1_Attendance+Week2_Attendance+Week3_Attendance+Week4_Attendance)/4,2) < 0.8 *100 
then "Concern" 
 else "Not Concern" 
	end  as concern_Status  
    
 from maths1learners ;
 
 ###Certifitcation Criteria
 





