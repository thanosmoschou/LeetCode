/*
Table: Employee

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
| department  | varchar |
| managerId   | int     |
+-------------+---------+
id is the primary key (column with unique values) for this table.
Each row of this table indicates the name of an employee, their department, and the id of their manager.
If managerId is null, then the employee does not have a manager.
No employee will be the manager of themself.
 

Write a solution to find managers with at least five direct reports.

Return the result table in any order.

The result format is in the following example.

Example 1:

Input: 
Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | None      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+
Output: 
+------+
| name |
+------+
| John |
+------+


My Solution:

Βημα βημα:

Αρχικα δες τον πινακα:

Employee table:
+-----+-------+------------+-----------+
| id  | name  | department | managerId |
+-----+-------+------------+-----------+
| 101 | John  | A          | None      |
| 102 | Dan   | A          | 101       |
| 103 | James | A          | 101       |
| 104 | Amy   | A          | 101       |
| 105 | Anne  | A          | 101       |
| 106 | Ron   | B          | 101       |
+-----+-------+------------+-----------+

Βλεπω οτι το managerId 101 εχει 5 αναφορες αρα ο ανθρωπος με id 101 πρεπει να εμφανιστει. Αφου μου λεει οτι κανενας ανθρωπος δεν ειναι manager του εαυτου του παμε να ενωσουμε τον πινακα με τον εαυτο του με την συνθηκη οτι το managerId του αριστερου πινακα πρεπει να ισουται με καποιο id του δεξιου ωστε να εχω σε καθε γραμμη τοσο τον ανθρωπο οσο και τον manager του. 

select *
from Employee as a left join Employee as b on a.managerId = b.id 

Αποτελεσμα:

| id  | name  | department | managerId | id   | name | department | managerId |
| --- | ----- | ---------- | --------- | ---- | ---- | ---------- | --------- |
| 101 | John  | A          | null      | null | null | null       | null      |
| 102 | Dan   | A          | 101       | 101  | John | A          | null      |
| 103 | James | A          | 101       | 101  | John | A          | null      |
| 104 | Amy   | A          | 101       | 101  | John | A          | null      |
| 105 | Anne  | A          | 101       | 101  | John | A          | null      |
| 106 | Ron   | B          | 101       | 101  | John | A          | null      |


Οποτε τωρα εχω σε καθε γραμμη τον ανθρωπο με τον manager του. Για παραδειγμα στην γραμμη 2 εχω τον Dan με id 102 που εχει manager τον ανθρωπο με managerId 101 (που εχει ιδιες τιμες με το id) αρα ο John ειναι ο manager του. Τον John τον βλεπω και σε αλλες γραμμες. Αρα μπορω να ομαδοποιησω τις εγγραφες μου με βαση το a.managerId και αν η καθε ομαδα εχει τουλαχιστον 5 εγγραφες τοτε να εμφανισω το b.name που ειναι το ονομα του manager οπως φαινεται και στον παραπανω πινακα.

Θελω επισης να εξαλειψω το ενδεχομενο στο ονομα να επιστρεψει Null.

Το τελικο query:
*/

# Write your MySQL query statement below
select b.name
from Employee as a left join Employee as b on a.managerId = b.id 
where a.name is not null and b.name is not null
group by a.managerId
having count(a.managerId) >= 5


--Alternative Solution:

# Write your MySQL query statement below
select name
from Employee 
where id in (
              select managerId
              from Employee
              group by managerId
              having count(managerId) > 4
)


