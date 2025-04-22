-- HR Database Schema and Sample Data
-- Created on April 22, 2025

-- Create Tables
-- Employees Table
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    hire_date DATE NOT NULL,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Departments Table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    manager_id INT,
    FOREIGN KEY (manager_id) REFERENCES Employees(employee_id)
);

-- Salaries Table
CREATE TABLE Salaries (
    salary_id INT PRIMARY KEY,
    employee_id INT NOT NULL,
    salary_amount DECIMAL(10,2) NOT NULL,
    effective_from DATE NOT NULL,
    effective_to DATE,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Projects Table
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE
);

-- Employee_Projects Table
CREATE TABLE Employee_Projects (
    id INT PRIMARY KEY,
    employee_id INT NOT NULL,
    project_id INT NOT NULL,
    role VARCHAR(50) NOT NULL,
    assigned_date DATE NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

-- Attendance Table
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    employee_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('Present', 'Absent', 'Late') NOT NULL,
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);

-- Insert Sample Data
-- Employees (10 records)
INSERT INTO Employees VALUES
(1, 'John Smith', 'john.smith@company.com', '555-0101', '2020-01-15', 1),
(2, 'Mary Johnson', 'mary.johnson@company.com', '555-0102', '2019-03-22', 2),
(3, 'James Wilson', 'james.wilson@company.com', '555-0103', '2021-06-10', 1),
(4, 'Patricia Brown', 'patricia.brown@company.com', '555-0104', '2018-11-01', 3),
(5, 'Robert Davis', 'robert.davis@company.com', '555-0105', '2022-02-14', 2),
(6, 'Linda Martinez', 'linda.martinez@company.com', '555-0106', '2020-09-01', 4),
(7, 'Michael Lee', 'michael.lee@company.com', '555-0107', '2021-04-20', 1),
(8, 'Sarah Clark', 'sarah.clark@company.com', '555-0108', '2019-07-15', 3),
(9, 'William Taylor', 'william.taylor@company.com', '555-0109', '2022-08-01', 2),
(10, 'Emma White', 'emma.white@company.com', '555-0110', '2020-12-10', 4);

-- Departments (10 records)
INSERT INTO Departments VALUES
(1, 'Engineering', 1),
(2, 'Marketing', 2),
(3, 'Human Resources', 4),
(4, 'Finance', NULL),
(5, 'Sales', 5),
(6, 'IT Support', 6),
(7, 'Research', 7),
(8, 'Operations', NULL),
(9, 'Customer Service', 9),
(10, 'Legal', 10);

-- Salaries (10 records)
INSERT INTO Salaries VALUES
(1, 1, 75000.00, '2023-01-01', NULL),
(2, 2, 82000.00, '2023-01-01', NULL),
(3, 3, 65000.00, '2023-01-01', NULL),
(4, 4, 90000.00, '2023-01-01', NULL),
(5, 5, 70000.00, '2023-01-01', NULL),
(6, 6, 68000.00, '2023-01-01', NULL),
(7, 7, 72000.00, '2023-01-01', NULL),
(8, 8, 85000.00, '2023-01-01', NULL),
(9, 9, 67000.00, '2023-01-01', NULL),
(10, 10, 78000.00, '2023-01-01', NULL);

-- Projects (10 records)
INSERT INTO Projects VALUES
(1, 'Website Redesign', '2023-01-01', '2023-06-30'),
(2, 'Mobile App Dev', '2023-02-01', '2023-12-31'),
(3, 'ERP Implementation', '2023-03-01', '2024-03-31'),
(4, 'Marketing Campaign', '2023-04-01', '2023-09-30'),
(5, 'Data Migration', '2023-05-01', '2023-11-30'),
(6, 'Cloud Integration', '2023-06-01', '2024-06-30'),
(7, 'Security Upgrade', '2023-07-01', '2023-12-31'),
(8, 'CRM System', '2023-08-01', '2024-02-28'),
(9, 'AI Research', '2023-09-01', '2024-09-30'),
(10, 'Compliance Audit', '2023-10-01', '2023-12-31');

-- Employee_Projects (10 records)
INSERT INTO Employee_Projects VALUES
(1, 1, 1, 'Lead Developer', '2023-01-01'),
(2, 2, 4, 'Marketing Lead', '2023-04-01'),
(3, 3, 1, 'Developer', '2023-01-01'),
(4, 4, 3, 'HR Manager', '2023-03-01'),
(5, 5, 2, 'App Developer', '2023-02-01'),
(6, 6, 5, 'Data Specialist', '2023-05-01'),
(7, 7, 7, 'Security Analyst', '2023-07-01'),
(8, 8, 8, 'Project Manager', '2023-08-01'),
(9, 9, 4, 'Marketing Assistant', '2023-04-01'),
(10, 10, 10, 'Legal Advisor', '2023-10-01');

-- Attendance (10 records)
INSERT INTO Attendance VALUES
(1, 1, '2023-04-01', 'Present'),
(2, 2, '2023-04-01', 'Present'),
(3, 3, '2023-04-01', 'Late'),
(4, 4, '2023-04-01', 'Present'),
(5, 5, '2023-04-01', 'Absent'),
(6, 6, '2023-04-01', 'Present'),
(7, 7, '2023-04-01', 'Present'),
(8, 8, '2023-04-01', 'Present'),
(9, 9, '2023-04-01', 'Late'),
(10, 10, '2023-04-01', 'Present');

-- Complex Queries
-- 1. Monthly Salary Report for All Employees
SELECT 
    e.name,
    d.department_name,
    s.salary_amount,
    DATE_FORMAT(s.effective_from, '%Y-%m') AS salary_month
FROM 
    Employees e
    JOIN Departments d ON e.department_id = d.department_id
    JOIN Salaries s ON e.employee_id = s.employee_id
WHERE 
    s.effective_to IS NULL
ORDER BY 
    d.department_name, e.name;

-- 2. Average Salary by Department
SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    ROUND(AVG(s.salary_amount), 2) AS average_salary
FROM 
    Departments d
    LEFT JOIN Employees e ON d.department_id = e.department_id
    LEFT JOIN Salaries s ON e.employee_id = s.employee_id
WHERE 
    s.effective_to IS NULL
GROUP BY 
    d.department_name
HAVING 
    employee_count > 0
ORDER BY 
    average_salary DESC;

-- 3. Employees Working on More Than One Project
SELECT 
    e.name,
    COUNT(ep.project_id) AS project_count,
    GROUP_CONCAT(p.project_name) AS projects
FROM 
    Employees e
    JOIN Employee_Projects ep ON e.employee_id = ep.employee_id
    JOIN Projects p ON ep.project_id = p.project_id
GROUP BY 
    e.employee_id, e.name
HAVING 
    project_count > 1
ORDER BY 
    project_count DESC;

-- 4. Attendance Percentage of Each Employee
SELECT 
    e.name,
    COUNT(a.attendance_id) AS total_days,
    SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) AS present_days,
    ROUND((SUM(CASE WHEN a.status = 'Present' THEN 1 ELSE 0 END) / COUNT(a.attendance_id)) * 100, 2) AS attendance_percentage
FROM 
    Employees e
    LEFT JOIN Attendance a ON e.employee_id = a.employee_id
GROUP BY 
    e.employee_id, e.name
ORDER BY 
    attendance_percentage DESC;

-- 5. Departments with No Currently Assigned Manager
SELECT 
    d.department_name
FROM 
    Departments d
WHERE 
    d.manager_id IS NULL
ORDER BY 
    d.department_name;