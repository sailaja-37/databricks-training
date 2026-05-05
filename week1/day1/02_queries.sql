-- BASIC QUERIES 

-- 1. Select all columns from the Employee table
SELECT * FROM Employee;

-- 2. Select only the name and salary columns from the Employee table
SELECT name, salary FROM Employee;

-- 3. Select employees who are older than 30
SELECT * 
FROM Employee
WHERE age > 30;

-- 4. Select the names of all departments
SELECT name 
FROM Department;

-- 5. Select employees who work in the IT department
SELECT e.*
FROM Employee e
JOIN Department d 
ON e.department_id = d.department_id
WHERE d.name = 'IT';



-- STRING MATCHING QUERIES 

-- 6. Select employees whose names start with 'J'
SELECT * 
FROM Employee
WHERE name LIKE 'J%';

-- 7. Select employees whose names end with 'e'
SELECT * 
FROM Employee
WHERE name LIKE '%e';

-- 8. Select employees whose names contain 'a'
SELECT * 
FROM Employee
WHERE name LIKE '%a%';

-- 9. Select employees whose names are exactly 9 characters long
SELECT * 
FROM Employee
WHERE LENGTH(name) = 9;

-- 10. Select employees whose names have 'o' as the second character
SELECT * 
FROM Employee
WHERE name LIKE '_o%';
