/*
Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the second highest salary from the Employee table. If there is no second highest salary, return null (return None in Pandas).

The result format is in the following example.

 

Example 1:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| 200                 |
+---------------------+
Example 2:

Input: 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
Output: 
+---------------------+
| SecondHighestSalary |
+---------------------+
| null                |
+---------------------+

My Solution:
*/

# Write your MySQL query statement below
select max(e1.salary) as SecondHighestSalary 
from Employee as e1
where e1.salary < (select max(salary) from Employee)

--Απο τον πινακα Employee θα κρατησω τις εγγραφες που το salary ειναι μικροτερο απο το max salary. Επειτα απο αυτες τις εγγραφες που κρατησα οι οποιες εχουν μικροτερο salary απο το max salary, θα κρατησω το μεγιστο salary το οποιο ειναι το δευτερο μεγαλυτερο συνολικα στον πινακα Employee.