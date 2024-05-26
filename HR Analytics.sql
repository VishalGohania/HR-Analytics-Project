use hr;
select * from hr_1;
select * from hr_2;

-- 1.Average Attrition rate for all Departments

With a as (select department, attrition,
case when attrition = 'Yes'
then 1
else 0
End as atr 
from hr_1)
select department, concat(format(avg(atr)*100,2),'%') as Attrition_Rate
from a
group by department;

-- 2 Average Hourly rate of Male Research Scientist

Select JobRole, format(avg(hourlyrate),2) as Avg_Hourly_Rate, Gender
from hr_1
where JobRole = 'Research Scientist' and 
Gender = 'Male';



-- 3. Attrition rate Vs Monthly income stats 

Alter table hr_2 RENAME COLUMN `ï»¿Employee ID` To EmployeeID;

select a.department, concat(format(avg(a.attrition_rate)*100,2),'%') as Average_Attrition,
	 format(avg(b.MonthlyIncome),0) as Average_Monthly_Income
 from (
		select department, attrition, employeenumber,
		case when attrition = 'Yes' then 1
		else 0
		End as attrition_rate
		from hr_1 ) as a
		Join hr_2 as b on b.EmployeeID = a.EmployeeNumber
		group by a.department;

-- 4 Average working years for each Department

select a.department, format(avg(TotalWorkingYears),0) as Average_Working_Years
from hr_1 a 
Join hr_2 b on b.employeeID = a.employeenumber
group by a.department;

-- 5. Job Role Vs Work life balance

select a.JobRole,
sum(case when WorkLifeBalance = 1 then 1 else 0 end) as Poor,
sum(case when WorkLifeBalance = 2 then 1 else 0 end) as Average,
sum(case when WorkLifeBalance = 3 then 1 else 0 end) as Good,
sum(case when WorkLifeBalance = 4 then 1 else 0 end) as Excellent,
count(b.WorkLifeBalance) as Total_Employee
from hr_1 a
Join hr_2 b on b.EmployeeId = a.EmployeeNumber
group by a.JobRole;


-- 6. Attrition rate Vs Year since last promotion relation By department

select a.department, concat(format(avg(a.attrition_rate)*100,2),'%') as Average_Attrition_Rate,
	 format(avg(b.YearsSinceLastPromotion),1) as Average_YearsSinceLastPromotion
 from (
		select department, attrition, employeenumber,
		case when attrition = 'Yes' then 1
		else 0
		End as attrition_rate
		from hr_1 ) as a
		Join hr_2 as b on b.EmployeeID = a.EmployeeNumber
		group by a.department;

