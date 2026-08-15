CREATE TABLE hospital_data (
    "Hospital Name" VARCHAR(100),
    "Location" VARCHAR(100),
    "Department" VARCHAR(100),
    "Doctors Count" INT,
    "Patients Count" INT,
    "Admission Date" DATE,
    "Discharge Date" DATE,
    "Medical Expenses" DECIMAL(12,2)
);
SELECT * FROM hospital_data;

--Q1) Write a SQL query to find the total number of patients across all hospitals
SELECT SUM("Patients Count") AS total_patients
FROM hospital_data;

--Q2)Retrieve the average count of doctors available in each hospital
SELECT "Hospital Name", ROUND(AVG("Doctors Count"), 2) AS average_doctors
FROM hospital_data
GROUP BY "Hospital Name"
ORDER BY average_doctors DESC;

--Q3)Find top three hospital department that have the highest number of patients
SELECT "Department",SUM("Patients Count") AS total_patients
FROM hospital_data
GROUP BY "Department"
ORDER BY total_patients DESC
LIMIT 3;

--Q4)Identify the hospital that recorded the highest medical expenses
SELECT "Hospital Name", SUM("Medical Expenses") AS total_medical_expenses
FROM hospital_data
GROUP BY "Hospital Name"
ORDER BY total_medical_expenses DESC
LIMIT 1;

--Q5)Calculate the average medical expenses per day for each hospital
SELECT "Hospital Name",
       ROUND(
	   SUM("Medical Expenses") / 
	   SUM("Discharge Date" - "Admission Date"),
	   2
	  ) AS average_daily_expenses
FROM hospital_data
GROUP BY "Hospital Name"
ORDER BY average_daily_expenses DESC;

ALTER TABLE hospital_data
ALTER COLUMN "Admission Date" TYPE DATE
USING TO_DATE("Admission Date", 'DD-MM-YYYY'),
ALTER COLUMN "Discharge Date" TYPE DATE
USING TO_DATE("Discharge Date", 'DD-MM-YYYY');

SELECT 
    "Admission Date",
    "Discharge Date"
FROM hospital_data
LIMIT 5;

--Q6) Find the patient with the longest stay by calculating the difference between Discharged date and Admission date 
SELECT "Hospital Name",
       "Location",
	   "Department",
	   "Admission Date",
	   "Discharge Date",
	   ("Discharge Date" - "Admission Date") AS stay_days
FROM hospital_data
ORDER BY stay_days DESC
LIMIT 1;

--Q7)Count the total number of patients treated in each city
SELECT "Location", SUM("Patients Count") AS total_patients
FROM hospital_data
GROUP BY "Location"
ORDER BY total_patients DESC;

--Q8)Calculate the average number of days the patients spend in each department
SELECT "Department", ROUND(AVG("Discharge Date" - "Admission Date"), 2) AS average_stay_days
FROM hospital_data
GROUP BY "Department"
ORDER BY average_stay_days DESC;

--Q9)Find the department with least numbers of patients
SELECT "Department", SUM("Patients Count") AS total_patients
FROM hospital_data
GROUP BY "Department"
ORDER BY total_patients ASC
LIMIT 1;

--Q10) Group the data by month and calculate the total expenses for each month
SELECT 
     TO_CHAR("Admission Date", 'YYYY-MM') AS month,
	 SUM("Medical Expenses") AS total_medical_expenses
FROM hospital_data
GROUP BY TO_CHAR("Admission Date", 'YYYY-MM')
ORDER BY month;