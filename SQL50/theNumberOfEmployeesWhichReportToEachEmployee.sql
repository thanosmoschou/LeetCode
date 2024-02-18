/*
Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the primary key for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write an SQL query to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.

The query result format is in the following example.

 

Example 1:

Input: 
Employees table:
+-------------+---------+------------+-----+
| employee_id | name    | reports_to | age |
+-------------+---------+------------+-----+
| 9           | Hercy   | null       | 43  |
| 6           | Alice   | 9          | 41  |
| 4           | Bob     | 9          | 36  |
| 2           | Winston | null       | 37  |
+-------------+---------+------------+-----+
Output: 
+-------------+-------+---------------+-------------+
| employee_id | name  | reports_count | average_age |
+-------------+-------+---------------+-------------+
| 9           | Hercy | 2             | 39          |
+-------------+-------+---------------+-------------+
Explanation: Hercy has 2 people report directly to him, Alice and Bob. Their average age is (41+36)/2 = 38.5, which is 39 after rounding it to the nearest integer.


My Solution:
*/

# Write your MySQL query statement below
select e2.employee_id, e2.name, count(e1.reports_to) as reports_count, round(avg(e1.age)) as average_age
from Employees as e1 left join Employees as e2 on e1.reports_to = e2.employee_id
group by e1.reports_to
having count(e1.reports_to) > 0
order by e2.employee_id

--Εχω 2 πινακες Employees. Ενωνω τις γραμμες τους και καθε γραμμη του αριστερου, θα συνδυαζεται με μια γραμμη του δεξιου που θα δειχνει τον manager του υπαλληλου του αριστερου πινακα. Ομαδοποιω βασει του e1.reports_to που δειχνει τον manager του καθε υπαλληλου. Θελω να κρατησω οσους managers εχουν τουλαχιστον 1 υπαλληλο να μανατζαρουν. Ταξινομω βασει του ονοματος του manager.