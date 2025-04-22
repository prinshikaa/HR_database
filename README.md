### HR Database Project
# Overview
This project implements a comprehensive SQL-based Human Resources (HR) database for managing employee-related data in a company. The database includes tables for employees, departments, salaries, projects, employee-project assignments, and attendance records. It provides a schema, sample data, and complex queries to generate useful HR reports.
The project is designed to be compatible with SQL-based database management systems (DBMS) like MySQL, PostgreSQL, or SQLite, with minor adjustments for specific DBMS syntax.

# Features
Database Schema: Defines six interrelated tables with appropriate data types, constraints, and relationships.
Sample Data: Includes 10 records per table to simulate real-world HR data.
Complex Queries: Provides five analytical queries for generating HR reports, such as salary reports, attendance percentages, and department analysis.
Commented Code: The SQL script includes detailed comments for clarity and maintainability.

# Requirements

A SQL-compatible DBMS (e.g., MySQL, PostgreSQL, SQLite).
A SQL client or GUI tool (e.g., MySQL Workbench, pgAdmin, DBeaver, or DB Browser for SQLite).
Basic knowledge of SQL for executing scripts and queries.

# Installation and Setup
Follow these steps to set up and test the HR Database:
1. Install a DBMS

MySQL: Download from mysql.com and follow the installation instructions.
PostgreSQL: Download from postgresql.org.
SQLite: Download DB Browser for SQLite or use the SQLite command-line tool.
Ensure the DBMS is running and accessible via a client or GUI.

2. Create a Database

Log in to your DBMS using a client or GUI tool.

Create a new database named hr_database:
CREATE DATABASE hr_database;
USE hr_database;  -- MySQL
-- OR
\c hr_database;  -- PostgreSQL



3. Execute the SQL Script

Locate the SQL Script: The main script is provided in HR_Database.sql.
Run the Script:
Copy and paste the entire script into your DBMS client or GUI query editor, or run it via the command line:
mysql -u username -p hr_database < HR_Database.sql  # MySQL
psql -U username -d hr_database -f HR_Database.sql  # PostgreSQL
sqlite3 hr_database.db < HR_Database.sql  # SQLite


The script includes:

CREATE TABLE statements to define the schema.
INSERT INTO statements to populate tables with sample data.
Five complex queries for analysis.




Verify Execution:
Check for errors during execution. Common issues include:

Syntax differences (e.g., ENUM in MySQL vs. CHECK in PostgreSQL).
Foreign key constraint violations (ensure tables are created and populated in order).


List tables to confirm creation:
SHOW TABLES;  -- MySQL
\dt;  -- PostgreSQL
.tables  -- SQLite





4. Test the Database

Verify Schema: Check table structures:
DESCRIBE Employees;  -- MySQL
\d Employees;  -- PostgreSQL
PRAGMA table_info(Employees);  -- SQLite


Verify Data: Query each table to confirm 10 records:
SELECT COUNT(*) FROM Employees;  -- Should return 10
SELECT * FROM Departments;  -- View sample data


Run Queries: Execute the five complex queries (located at the end of HR_Database.sql) and verify their output:

Monthly Salary Report: Lists current salaries for all employees.
Average Salary by Department: Shows average salaries per department.
Employees on Multiple Projects: Identifies employees assigned to multiple projects (may return no results with sample data).
Attendance Percentage: Calculates attendance percentages for each employee.
Departments with No Manager: Lists departments without an assigned manager (e.g., Finance, Operations).



# Database Structure
The database consists of six tables with the following schema:
Tables

Employees
Columns: employee_id (PK), name, email (UNIQUE), phone, hire_date, department_id (FK)
Stores employee information.


Departments
Columns: department_id (PK), department_name, manager_id (FK)
Stores department details and their managers.


Salaries
Columns: salary_id (PK), employee_id (FK), salary_amount, effective_from, effective_to
Tracks employee salary history.


Projects
Columns: project_id (PK), project_name, start_date, end_date
Stores project details.


Employee_Projects
Columns: id (PK), employee_id (FK), project_id (FK), role, assigned_date
Maps employees to projects with their roles.


Attendance
Columns: attendance_id (PK), employee_id (FK), date, status (Present/Absent/Late)
Records daily employee attendance.



# Relationships

Employees.department_id references Departments.department_id.
Departments.manager_id references Employees.employee_id.
Salaries.employee_id references Employees.employee_id.
Employee_Projects.employee_id references Employees.employee_id.
Employee_Projects.project_id references Projects.project_id.
Attendance.employee_id references Employees.employee_id.

# Sample Data

Each table contains 10 rows of sample data to simulate real-world scenarios.
Example:
Employees: Includes employees like John Smith (Engineering) and Mary Johnson (Marketing).
Departments: Includes departments like Engineering, Marketing, and Finance (some with no manager).
Salaries: Current salaries range from $65,000 to $90,000.
Projects: Includes projects like Website Redesign and Mobile App Dev.
Employee_Projects: Assigns employees to projects with roles like Lead Developer or Marketing Lead.
Attendance: Records one day of attendance (April 1, 2023) with statuses like Present, Absent, or Late.



# Queries
The project includes five complex queries for HR analysis:

Monthly Salary Report:
Lists employee names, departments, current salaries, and effective months.
Joins Employees, Departments, and Salaries.


Average Salary by Department:
Calculates the average salary and employee count per department.
Uses GROUP BY and ROUND for formatting.


Employees on Multiple Projects:
Identifies employees assigned to more than one project (may return no results with sample data).
Uses GROUP BY and HAVING.


Attendance Percentage:
Computes the percentage of present days for each employee.
Uses conditional aggregation and ROUND.


Departments with No Manager:
Lists departments with no assigned manager (e.g., Finance, Operations).
Uses WHERE manager_id IS NULL.



# Testing the Database
To ensure the database works correctly:

Schema Validation:
Confirm all tables are created with correct columns, data types, and constraints.
Check foreign key relationships.


Data Validation:
Verify 10 rows per table using SELECT COUNT(*).
Spot-check data with SELECT * FROM table_name.


Query Validation:
Run each query and compare results to expected output.
Manually calculate a few results (e.g., attendance percentage) to confirm accuracy.


Edge Cases:
Test foreign key constraints by inserting invalid employee_id values.
Test unique constraints by inserting duplicate email values.
Test invalid status values in Attendance (e.g., 'Invalid').



# DBMS-Specific Notes

MySQL:
The provided script is fully compatible.
Uses ENUM for Attendance.status and DATE_FORMAT in queries.


PostgreSQL:
Replace ENUM with:
status VARCHAR(10) CHECK (status IN ('Present', 'Absent', 'Late')) NOT NULL


Replace DATE_FORMAT(s.effective_from, '%Y-%m') with:
TO_CHAR(s.effective_from, 'YYYY-MM')


Replace GROUP_CONCAT with STRING_AGG:
STRING_AGG(p.project_name, ', ') AS projects




SQLite:
SQLite does not enforce foreign keys by default. Enable them with:
PRAGMA foreign_keys = ON;


Replace ENUM with a CHECK constraint.

GROUP_CONCAT is supported, but DATE_FORMAT is not; use strftime('%Y-%m', s.effective_from).




# Troubleshooting

Syntax Errors: Check DBMS-specific syntax (e.g., ENUM, DATE_FORMAT).
Foreign Key Errors: Ensure tables are created and populated in the correct order.
Empty Query Results: Verify sample data matches query conditions (e.g., the multiple projects query may return no results).
Contact: For help, share specific error messages or issues with the project maintainers.

# Future Enhancements

Add indexes for frequently queried columns (e.g., employee_id).
Implement triggers to enforce business rules (e.g., prevent overlapping salary periods).
Create views for common reports (e.g., monthly attendance summary).
Expand sample data to include more records and scenarios.
Add stored procedures for repetitive tasks (e.g., updating salaries).
