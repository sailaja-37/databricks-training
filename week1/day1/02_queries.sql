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


-- DATE QUERIES 

-- 11. Select employees hired in 2020
SELECT * FROM Employee WHERE YEAR(hire_date) = 2020;

-- 12. Select employees hired in January
SELECT * FROM Employee WHERE MONTH(hire_date) = 1;

-- 13. Select employees hired before 2019
SELECT * FROM Employee WHERE YEAR(hire_date) < 2019;

-- 14. Select employees hired on or after March 1, 2021
SELECT * FROM Employee WHERE hire_date >= '2021-03-01';

-- 15. Select employees hired in the last 2 years
SELECT * FROM Employee 
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);


-- AGGREGATE FUNCTION QUERIES

-- 16. Find the total salary of all employees
SELECT SUM(salary) AS total_salary FROM Employee;

-- 17. Find the average salary of employees
SELECT AVG(salary) AS avg_salary FROM Employee;

-- 18. Find the minimum salary
SELECT MIN(salary) AS min_salary FROM Employee;

-- 19. Count employees in each department
SELECT department_id, COUNT(*) AS total_employees
FROM Employee
GROUP BY department_id;

-- 20. Find average salary in each department
SELECT department_id, AVG(salary) AS avg_salary
FROM Employee
GROUP BY department_id;


-- GROUP BY QUERIES

-- 21. Find total salary in each department
SELECT department_id, SUM(salary) AS total_salary
FROM Employee
GROUP BY department_id;

-- 22. Find average age in each department
SELECT department_id, AVG(age) AS avg_age
FROM Employee
GROUP BY department_id;

-- 23. Count employees hired each year
SELECT YEAR(hire_date) AS year, COUNT(*) AS total
FROM Employee
GROUP BY YEAR(hire_date);

-- 24. Find highest salary in each department
SELECT department_id, MAX(salary) AS max_salary
FROM Employee
GROUP BY department_id;

-- 25. Find department with highest average salary
SELECT department_id
FROM Employee
GROUP BY department_id
ORDER BY AVG(salary) DESC
LIMIT 1;


-- HAVING CLAUSE QUERIES

-- 26. Find departments with more than 2 employees
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING COUNT(*) > 2;

-- 27. Find departments with average salary greater than 55000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING AVG(salary) > 55000;

-- 28. Find years with more than 1 employee hired
SELECT YEAR(hire_date)
FROM Employee
GROUP BY YEAR(hire_date)
HAVING COUNT(*) > 1;

-- 29. Find departments with total salary less than 100000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING SUM(salary) < 100000;

-- 30. Find departments with maximum salary greater than 75000
SELECT department_id
FROM Employee
GROUP BY department_id
HAVING MAX(salary) > 75000;


-- ORDER BY QUERIES

-- 31. Display employees ordered by salary in ascending order
SELECT * FROM Employee ORDER BY salary ASC;

-- 32. Display employees ordered by age in descending order
SELECT * FROM Employee ORDER BY age DESC;

-- 33. Display employees ordered by hire date in ascending order
SELECT * FROM Employee ORDER BY hire_date ASC;

-- 34. Order employees by department and salary
SELECT * FROM Employee ORDER BY department_id, salary;

-- 35. Display departments ordered by total salary
SELECT department_id 
FROM Employee 
GROUP BY department_id 
ORDER BY SUM(salary);


-- JOIN QUERIES

-- 36. Display employee names with their department names
SELECT e.name AS employee_name, d.name AS department_name
FROM Employee e
INNER JOIN Department d
ON e.department_id = d.department_id;

-- 37. Display project names with department names
SELECT p.name, d.name 
FROM Project p 
INNER JOIN Department d 
ON p.department_id = d.department_id;

-- 38. Display employee names with project names
SELECT e.name, p.name 
FROM Employee e 
INNER JOIN Project p 
ON e.department_id = p.department_id;

-- 39. Display all employees with their departments
SELECT e.name, d.name 
FROM Employee e 
LEFT OUTER JOIN Department d 
ON e.department_id = d.department_id;

-- 40. Display all departments with their employees
SELECT d.name, e.name
FROM Department d
LEFT OUTER JOIN Employee e
ON d.department_id = e.department_id;

-- 41. Find employees not assigned to any project department
SELECT e.name 
FROM Employee e 
LEFT OUTER JOIN Project p 
ON e.department_id = p.department_id 
WHERE p.project_id IS NULL;

-- 42. Count projects handled by each employee
SELECT e.name, COUNT(p.project_id) 
FROM Employee e 
LEFT OUTER JOIN Project p 
ON e.department_id = p.department_id 
GROUP BY e.emp_id, e.name;

-- 43. Find departments with no employees
SELECT d.name 
FROM Department d 
LEFT OUTER JOIN Employee e 
ON d.department_id = e.department_id 
WHERE e.emp_id IS NULL;

-- 44. Find employees working in the same department as John Doe
SELECT e1.name 
FROM Employee e1
INNER JOIN Employee e2 
ON e1.department_id = e2.department_id
WHERE e2.name = 'John Doe' 
AND e1.name != 'John Doe';

-- 45. Find department with the highest average salary
SELECT d.name 
FROM Department d
INNER JOIN Employee e 
ON d.department_id = e.department_id
GROUP BY d.department_id, d.name
ORDER BY AVG(e.salary) DESC 
LIMIT 1;

-- NESTED AND CORRELATED QUERIES

-- 46. Select the employee with the highest salary
SELECT *
FROM Employee
WHERE salary = (SELECT MAX(salary) FROM Employee);



-- 47. Select employees whose salary is above the average salary
SELECT *
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);



-- 48. Select the second highest salary from the Employee table
SELECT MAX(salary) AS second_highest_salary
FROM Employee
WHERE salary < (SELECT MAX(salary) FROM Employee);



-- 49. Select the department with the most employees
SELECT d.name, COUNT(e.emp_id) AS total_employees
FROM Department d
JOIN Employee e
ON d.department_id = e.department_id
GROUP BY d.name
ORDER BY total_employees DESC
LIMIT 1;



-- 50. Select employees who earn more than the average salary of their department
SELECT *
FROM Employee e
WHERE salary >
(
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);



-- 51. Select the nth highest salary (example: 3rd highest)
SELECT DISTINCT salary
FROM Employee e1
WHERE 2 =
(
    SELECT COUNT(DISTINCT salary)
    FROM Employee e2
    WHERE e2.salary > e1.salary
);



-- 52. Select employees who are older than all employees in the HR department
SELECT *
FROM Employee
WHERE age >
(
    SELECT MAX(age)
    FROM Employee
    WHERE department_id =
    (
        SELECT department_id
        FROM Department
        WHERE name = 'HR'
    )
);



-- 53. Select departments where the average salary is greater than 55000
SELECT d.name, AVG(e.salary) AS avg_salary
FROM Department d
JOIN Employee e
ON d.department_id = e.department_id
GROUP BY d.name
HAVING AVG(e.salary) > 55000;



-- 54. Select employees who work in a department with at least 2 projects
SELECT *
FROM Employee
WHERE department_id IN
(
    SELECT department_id
    FROM Project
    GROUP BY department_id
    HAVING COUNT(project_id) >= 2
);



-- 55. Select employees who were hired on the same date as 'Jane Smith'
SELECT *
FROM Employee
WHERE hire_date =
(
    SELECT hire_date
    FROM Employee
    WHERE name = 'Jane Smith'
);


-- COMBINED QUERIES

-- 56. Select the total salary of employees hired in the year 2020
SELECT SUM(salary) AS total_salary
FROM Employee
WHERE YEAR(hire_date) = 2020;



-- 57. Select the average salary of employees in each department,
-- ordered by the average salary in descending order
SELECT d.name, AVG(e.salary) AS avg_salary
FROM Department d
JOIN Employee e
ON d.department_id = e.department_id
GROUP BY d.name
ORDER BY avg_salary DESC;



-- 58. Select departments with more than 1 employee
-- and an average salary greater than 55000
SELECT d.name,
       COUNT(e.emp_id) AS total_employees,
       AVG(e.salary) AS avg_salary
FROM Department d
JOIN Employee e
ON d.department_id = e.department_id
GROUP BY d.name
HAVING COUNT(e.emp_id) > 1
AND AVG(e.salary) > 55000;



-- 59. Select employees hired in the last 2 years,
-- ordered by their hire date
SELECT *
FROM Employee
WHERE hire_date >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR)
ORDER BY hire_date;



-- 60. Select the total number of employees and the average salary
-- for departments with more than 2 employees
SELECT d.name,
       COUNT(e.emp_id) AS total_employees,
       AVG(e.salary) AS avg_salary
FROM Department d
JOIN Employee e
ON d.department_id = e.department_id
GROUP BY d.name
HAVING COUNT(e.emp_id) > 2;



-- 61. Select the name and salary of employees whose salary
-- is above the average salary of their department
SELECT name, salary
FROM Employee e
WHERE salary >
(
    SELECT AVG(salary)
    FROM Employee
    WHERE department_id = e.department_id
);



-- 62. Select the names of employees who are hired
-- on the same date as the oldest employee in the company
SELECT name
FROM Employee
WHERE hire_date =
(
    SELECT hire_date
    FROM Employee
    WHERE age =
    (
        SELECT MAX(age)
        FROM Employee
    )
);



-- 63. Select the department names along with the total number
-- of projects they are working on, ordered by number of projects
SELECT d.name,
       COUNT(p.project_id) AS total_projects
FROM Department d
LEFT JOIN Project p
ON d.department_id = p.department_id
GROUP BY d.name
ORDER BY total_projects DESC;



-- 64. Select the employee name with the highest salary
-- in each department
SELECT d.name AS department_name,
       e.name AS employee_name,
       e.salary
FROM Employee e
JOIN Department d
ON e.department_id = d.department_id
WHERE e.salary =
(
    SELECT MAX(salary)
    FROM Employee
    WHERE department_id = e.department_id
);



-- 65. Select the names and salaries of employees
-- who are older than the average age of employees
-- in their department
SELECT name, salary
FROM Employee e
WHERE age >
(
    SELECT AVG(age)
    FROM Employee
    WHERE department_id = e.department_id
);