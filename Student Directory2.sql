# The query retrieves the name and surname of each student from the maths1learners table, 
# calculates their average attendance over four weeks, and then adds a new column called concern_Status. 
# This concern_Status column will be either :
#1)Concern if the student's average attendance is below 80%  
#2)Not Concern (attendance over 80%)  
# This allows you to easily identify students whose attendance might be a cause for concern.


use importcsv;
Select * from maths1learners;

select 
Name ,
Surname,
round((Week1_Attendance+Week2_Attendance+Week3_Attendance+Week4_Attendance)/4,2) as Attendance_Overall ,

Case when round((Week1_Attendance+Week2_Attendance+Week3_Attendance+Week4_Attendance)/4,2) < 0.8 *100 
then "Concern" 
 else "Not Concern" 
	end  as concern_Status  
    
 from maths1learners ;

# This combined query will output a single table with the following columns: 
# Course, Name, Surname, Attendance_Overall, and concern_Status, showing the concern status for learners in both the Maths1 and Physics1 courses.


# Query to analyze attendance for maths1learnersmaths1learners
 SELECT
    'Maths1' AS Course,
    Name,
    Surname,
    round((Week1_Attendance + Week2_Attendance + Week3_Attendance + Week4_Attendance) / 4, 2) AS Attendance_Overall,
    CASE
        WHEN round((Week1_Attendance + Week2_Attendance + Week3_Attendance + Week4_Attendance) / 4, 2) < 80
        THEN 'Concern'
        ELSE 'Not Concern'
    END AS concern_Status
FROM
    maths1learners

UNION ALL

# Query to analyze attendance for physics1learners
SELECT
    'Physics1' AS Course,
    Name,
    Surname,
    round((Week1_Attendance + Week2_Attendance + Week3_Attendance + Week4_Attendance) / 4, 2) AS Attendance_Overall,
    CASE
        WHEN round((Week1_Attendance + Week2_Attendance + Week3_Attendance + Week4_Attendance) / 4, 2) < 80
        THEN 'Concern'
        ELSE 'Not Concern'
    END AS concern_Status
FROM
    physics1learners;
 


