/*
Table: Queries

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The position column has a value from 1 to 500.
The rating column has a value from 1 to 5. Query with rating less than 3 is a poor query.
 

We define query quality as:

The average of the ratio between query rating and its position.

We also define poor query percentage as:

The percentage of all queries with rating less than 3.

Write a solution to find each query_name, the quality and poor_query_percentage.

Both quality and poor_query_percentage should be rounded to 2 decimal places.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
Output: 
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+
Explanation: 
Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
Dog queries poor_ query_percentage is (1 / 3) * 100 = 33.33

Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
Cat queries poor_ query_percentage is (1 / 3) * 100 = 33.33


My Solution:
*/

# Write your MySQL query statement below
select query_name, round(avg(rating/position), 2) as quality, 
round((select count(rating) from Queries as tmp where tmp.query_name = q.query_name and tmp.rating < 3) * 100 /
(select count(rating) from Queries as tmp where q.query_name = tmp.query_name), 2) as poor_query_percentage
from Queries as q
group by query_name

/*
Ας αναλυσουμε το query:

Ας πουμε οτι εχω 
select something
from Queries as q
group by query_name

Αυτο μεχρι εδω ειναι κατανοητο. Απλως ομαδοποιω τις εγγραφες βασει του query_name.

Παμε τωρα στο select:

select query_name ειναι κατανοητο

round(avg(rating/position), 2) as quality -> Αφου καναμε ομαδοποιηση τοτε για καθε εγγραφη παιρνω rating/position και ολα αυτα τα βαζω στην avg. Κανω και στρογγυλοποιηση 2 δεκαδικων.

round((select count(rating) from Queries as tmp where tmp.query_name = q.query_name and tmp.rating < 3) * 100 /
(select count(rating) from Queries as tmp where q.query_name = tmp.query_name), 2) as poor_query_percentage

Αυτο αποτελειται απο 2 μικροτερα subqueries:

(select count(rating) from Queries as tmp where tmp.query_name = q.query_name and tmp.rating < 3) * 100

Παμε στον πινακα Queries και κραταμε οσες εγγραφες εχουν query_name που ισουται με την τιμη που εχει το query_name στην εκαστοτε εγγραφη του εξωτερικου query και επισης οσες γραμμες εχουν rating < 3. Ο πολλαπλασιασμος γινεται για να μου βγει ποσοστο επι τοις 100 στην διαιρεση. 

(select count(rating) from Queries as tmp where q.query_name = tmp.query_name)

Ιδιο με πριν αλλα κραταω ολα τα query που ισουται το query name με το query name της εξωτερικης εγγραφης ασχετως rating. Αυτα μετα τα διαιρω.

Αλλα αφου εχω συλλεξει τις εγγραφες βασει ομαδοποιησης ειναι αχρηστα τα subqueries:

# Write your MySQL query statement below
select query_name, round(avg(rating/position), 2) as quality, round(
avg(
  case
    when rating < 3 then 1
    else 0
  end) * 100, 2) as poor_query_percentage
from Queries as q
group by query_name

Απλα δημιουργω ενα συνολο μεσω της στηλης rating. Το συνολο θα περιλαμβανει την τιμη 1 αν η εκαστοτε τιμη στην στηλη rating ειναι μικροτερη απο 3, αλλιως η αντιστοιχη τιμη στο συνολο μου μεσω της case θα ειναι ιση με 0. Μετα βασει ολων των 1 και 0 που δημιουργησα, παιρνω τον μεσο ορο του συνολου αυτου και πολλαπλασιαζω επι 100 για ποσοστο.
*/