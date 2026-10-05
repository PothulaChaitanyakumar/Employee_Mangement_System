create database EMP;
use EMP;
-- Table 1: Job Department
CREATE TABLE JobDepartment (
    Job_ID INT PRIMARY KEY,
    jobdept VARCHAR(50),
    name VARCHAR(100),
    description TEXT,
    salaryrange VARCHAR(50)
);
select * from JobDepartment;

-- Table 2: Salary/Bonus
CREATE TABLE SalaryBonus (
    salary_ID INT PRIMARY KEY,
    Job_ID INT,
    amount DECIMAL(10,2),
    annual DECIMAL(10,2),
    bonus DECIMAL(10,2),
    CONSTRAINT fk_salary_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(Job_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
select * from SalaryBonus;

-- Table 3: Employee
CREATE TABLE Employee (
    emp_ID INT PRIMARY KEY,
    firstname VARCHAR(50),
    lastname VARCHAR(50),
    gender VARCHAR(10),
    age INT,
    contact_add VARCHAR(100),
    emp_email VARCHAR(100) UNIQUE,
    emp_pass VARCHAR(50),
    Job_ID INT,
    CONSTRAINT fk_employee_job FOREIGN KEY (Job_ID)
        REFERENCES JobDepartment(Job_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
DESCRIBE EMPLOYEE;
select * from Employee;

-- Table 4: Qualification
CREATE TABLE Qualification (
    QualID INT PRIMARY KEY,
    Emp_ID INT,
    Position VARCHAR(50),
    Requirements VARCHAR(255),
    Date_In DATE,
    CONSTRAINT fk_qualification_emp FOREIGN KEY (Emp_ID)
        REFERENCES Employee(emp_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
select * from Qualification;

-- Table 5: Leaves
CREATE TABLE Leaves (
    leave_ID INT PRIMARY KEY,
    emp_ID INT,
    date DATE,
    reason TEXT,
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
);
select * from Leaves;
-- Table 6: Payroll
CREATE TABLE Payroll (
    payroll_ID INT PRIMARY KEY,
    emp_ID INT,
    job_ID INT,
    salary_ID INT,
    leave_ID INT,
    date DATE,
    report TEXT,
    total_amount DECIMAL(10,2),
    CONSTRAINT fk_payroll_emp FOREIGN KEY (emp_ID) REFERENCES Employee(emp_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_job FOREIGN KEY (job_ID) REFERENCES JobDepartment(job_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_salary FOREIGN KEY (salary_ID) REFERENCES SalaryBonus(salary_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_leave FOREIGN KEY (leave_ID) REFERENCES Leaves(leave_ID)
        ON DELETE SET NULL ON UPDATE CASCADE
);
select * from Payroll;

-- Analysis Questions
-- 1. EMPLOYEE INSIGHTS
-- How many unique employees are currently in the system?
select count(distinct emp_id) as unique_employees
from employee;

-- Which departments have the highest number of employees?
select j.jobdept,count(emp_ID) as
employee_count
from employee e
join jobdepartment j
on e.emp_ID=j.Job_ID
group by j.jobdept
order by employee_count desc;

-- What is the average salary per department?
select j.jobdept,avg(s.amount) as avg_salary
from jobdepartment j
join salarybonus s
on j.job_id=s.job_id
group by j.jobdept;

-- Who are the top 5 highest-paid employees?
select e.firstname,e.lastname ,s.amount
from employee e
join  salarybonus s
on e.emp_ID=s.Job_ID
order by s.amount desc
limit 5;

-- What is the total salary expenditure across the company?
select sum(s.amount) as total_salary_expendicture
from employee e
join salarybonus s
on e.emp_id=s.job_id;

-- 2. JOB ROLE AND DEPARTMENT ANALYSIS
-- How many different job roles exist in each department?
select jobdept,count(name) as job_roles
from jobdepartment
group by jobdept;

-- What is the average salary range per department?
select j.jobdept,avg(s.amount) as average_salary
from jobdepartment j
join salarybonus s
on j.Job_ID=s.Job_ID
group by j.jobdept;

-- Which job roles offer the highest salary?
select j.name,s.amount as height_salary
from jobdepartment j
join salarybonus s
on j.Job_ID=s.Job_ID
where s.amount=(select max(amount) from salarybonus);

-- Which departments have the highest total salary allocation?
select j.jobdept,sum(s.annual) as total_salary_allocation
from jobdepartment j
join salarybonus s
on j.job_id=s.Job_ID
group by j.jobdept
order by total_salary_allocation desc;

-- 3. QUALIFICATION AND SKILLS ANALYSIS
-- How many employees have at least one qualification listed?
select count(distinct emp_id) as employee_qualification
from qualification;

-- Which positions require the most qualifications?
select q.position,count(q.qualid) as most_qualification
from qualification q
group by q.position
order by most_qualification desc;

-- Which employees have the highest number of qualifications?
select e.firstname,e.lastname,count(q.QualID) as height_qualification
from employee e
join qualification q
on e.emp_ID=q.emp_ID
group by e.firstname,e.lastname
order by height_qualification desc;

-- 4. LEAVE AND ABSENCE PATTERNS
-- Which year had the most employees taking leaves?
select year(date) as leaves_year,count(distinct emp_ID) as employees_leaves
from leaves
group by year(date)
order by employees_leaves;

-- What is the average number of leave days taken by its employees per department?
select j.jobdept,count(l.leave_id)/count(distinct e.emp_id) as average_leaves
from leaves l
join employee e
on l.emp_ID=e.emp_ID
join jobdepartment j
on e.Job_ID=j.Job_ID
group by j.jobdept;

-- Which employees have taken the most leaves?
select e.emp_ID,e.firstname,e.lastname,count(l.leave_id) as most_leaves
from employee e
join leaves l
on e.emp_ID=l.emp_ID
group by e.emp_ID,e.firstname,e.lastname
order by most_leaves desc;

-- What is the total number of leave days taken company-wide?
select count(*) as total_leaves from leaves;

-- How do leave days correlate with payroll amounts?
select e.emp_ID,e.firstname,e.lastname,count(l.leave_id)as leave_days,
sum(p.total_amount) as total_pay
from employee e
join leaves l
on e.emp_ID=l.emp_ID
join payroll p
on e.emp_ID=p.emp_ID
group by e.emp_ID,e.firstname,e.lastname,p.total_amount
order by leave_days;

-- 5. PAYROLL AND COMPENSATION ANALYSIS
-- What is the total monthly payroll processed?
select sum(total_amount) as monthly_payroll from payroll;

-- What is the average bonus given per department?
select j.jobdept,avg(s.bonus) as average_bonus
from jobdepartment j
join salarybonus s
on j.job_id=s.Job_ID
group by j.jobdept;

-- Which department receives the highest total bonuses?
select j.jobdept,sum(s.bonus) as total_bonuses
from jobdepartment  j
join salarybonus s
on j.Job_ID=s.Job_ID
group by j.jobdept;

-- What is the average value of total_amount after considering leave deductions?
select avg(p.total_amount) as average_payroll
from payroll p
join leaves l
on p.emp_ID=l.emp_ID;





