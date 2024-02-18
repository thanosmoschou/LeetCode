/*
Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
id is a continuous increment.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Seat table:
+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+
Output: 
+----+---------+
| id | student |
+----+---------+
| 1  | Doris   |
| 2  | Abbot   |
| 3  | Green   |
| 4  | Emerson |
| 5  | Jeames  |
+----+---------+
Explanation: 
Note that if the number of students is odd, there is no need to change the last one's seat.

My Solution:
*/

# Write your MySQL query statement below
select
case
  when s.id % 2 != 0 and s.id = (select count(id) from Seat) then s.id
  when s.id % 2 = 0 then s.id - 1
  else s.id + 1
end as id, student
from Seat as s
order by id

/*
Εδω απλα αλλαζουμε τα id στο τελικο αποτελεσμα. Αν το id ειναι μονος αριθμος και ισουται με τον συνολικο αριθμο τιμων στην στηλη id (δηλ αν εχω 5 εγγραφες οι τιμες id θα ειναι απο 1 ως 5. Αρα η τελευταια εγγραφη ειναι με id = 5) τοτε την αφηνω ως εχει. Αλλιως αν το id ειναι ζυγος ξερω οτι θελω να αλλαξω την θεση με τον προηγουμενο που εχει μονό αριθμό id. Αλλιως ειναι μονός αριθμος και ξερω οτι θελω να αλλαξω την θεση με τον επομενο ζυγο. Τελος απλα κανω ταξινομηση βασει του id.

Για παραδειγμα:

+----+---------+
| id | student |
+----+---------+
| 1  | Abbot   |
| 2  | Doris   |
| 3  | Emerson |
| 4  | Green   |
| 5  | Jeames  |
+----+---------+

Η πρωτη εχει id = 1. Αρα στον τελικο πινακα το κανω 2. Η δευτερη εχει id = 2 αρα το κανω 1 κτλ. Την τελευταια την αφηνω ως εχει. Αρα προκυπτει το εξης

+----+---------+
| id | student |
+----+---------+
| 2  | Abbot   |
| 1  | Doris   |
| 4  | Emerson |
| 3  | Green   |
| 5  | Jeames  |
+----+---------+

Τωρα απλα κανω ταξινομηση και ειμαι οκ.
*/