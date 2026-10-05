# Employee Management System

## About the Project

I created this project to practice SQL and understand how employee-related data can be stored, connected, and analyzed using a relational database.

The project focuses on employee details, departments, job roles, salaries, qualifications, leaves, and payroll information. I used MySQL to create the tables, define relationships, and write SQL queries to answer different business questions.

## What I Worked On

- Created a relational database using MySQL.
- Created and connected six tables using primary and foreign keys.
- Stored employee, department, salary, qualification, leave, and payroll data.
- Used SQL joins to combine information from different tables.
- Used `GROUP BY`, aggregate functions, filtering, sorting, and subqueries for analysis.
- Analyzed salary, employee, leave, qualification, and payroll information.
- Generated business insights from the available data.

## Tables Used

- **Employee** – Employee personal and job details
- **JobDepartment** – Departments and job roles
- **SalaryBonus** – Salary, annual pay, and bonus details
- **Qualification** – Employee qualification information
- **Leaves** – Employee leave records
- **Payroll** – Payroll and payment information

## SQL Analysis

SQL queries were used to analyze different aspects of the organization, including:

### Employee Analysis
- Number of unique employees
- Department-wise employee count
- Average salary by department
- Top 5 highest-paid employees
- Total salary expenditure

### Job & Department Analysis
- Number of job roles in each department
- Average salary by department
- Highest-paying job roles
- Total salary allocation by department

### Qualification Analysis
- Number of employees with qualifications
- Positions requiring the most qualifications
- Employees with the highest number of qualifications

### Leave Analysis
- Year-wise employee leave analysis
- Average leaves by department
- Employees taking the most leaves
- Total leave days
- Relationship between leave days and payroll

### Payroll Analysis
- Total monthly payroll
- Average bonus by department
- Total bonuses by department
- Average payroll amount

## Tools Used

- MySQL
- SQL
- Excel / CSV
- PowerPoint

## Project Files

```text
Employee-Management-System
│
├── employee_management_system.sql
│
├── data
│   ├── Employee.csv
│   ├── JobDepartment.csv
│   ├── Leaves.csv
│   ├── Payroll.csv
│   ├── Qualification.csv
│   └── SalaryBonus.csv
│
├── documentation
│   └── Employee_Management_System_Documentation.docx
│
└── presentation
    └── Employee_Management_System_Presentation.pptx
