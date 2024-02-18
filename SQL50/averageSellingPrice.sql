/*
Table: Prices

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| start_date    | date    |
| end_date      | date    |
| price         | int     |
+---------------+---------+
(product_id, start_date, end_date) is the primary key for this table.
Each row of this table indicates the price of the product_id in the period from start_date to end_date.
For each product_id there will be no two overlapping periods. That means there will be no two intersecting periods for the same product_id.
 

Table: UnitsSold

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| purchase_date | date    |
| units         | int     |
+---------------+---------+
There is no primary key for this table, it may contain duplicates.
Each row of this table indicates the date, units, and product_id of each product sold. 
 

Write an SQL query to find the average selling price for each product. average_price should be rounded to 2 decimal places.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Prices table:
+------------+------------+------------+--------+
| product_id | start_date | end_date   | price  |
+------------+------------+------------+--------+
| 1          | 2019-02-17 | 2019-02-28 | 5      |
| 1          | 2019-03-01 | 2019-03-22 | 20     |
| 2          | 2019-02-01 | 2019-02-20 | 15     |
| 2          | 2019-02-21 | 2019-03-31 | 30     |
+------------+------------+------------+--------+
UnitsSold table:
+------------+---------------+-------+
| product_id | purchase_date | units |
+------------+---------------+-------+
| 1          | 2019-02-25    | 100   |
| 1          | 2019-03-01    | 15    |
| 2          | 2019-02-10    | 200   |
| 2          | 2019-03-22    | 30    |
+------------+---------------+-------+
Output: 
+------------+---------------+
| product_id | average_price |
+------------+---------------+
| 1          | 6.96          |
| 2          | 16.96         |
+------------+---------------+
Explanation: 
Average selling price = Total Price of Product / Number of products sold.
Average selling price for product 1 = ((100 * 5) + (15 * 20)) / 115 = 6.96
Average selling price for product 2 = ((200 * 15) + (30 * 30)) / 230 = 16.96


My Solution:
*/
# Write your MySQL query statement below
select p.product_id, round(sum(p.price * u.units) / sum(u.units), 2) as average_price
from Prices as p left join UnitsSold as u on p.product_id = u.product_id and u.purchase_date between
p.start_date and p.end_date
group by p.product_id

--Αριστερη συζευξη του prices με τον units sold με τα product id να ειναι ιδια σε καθε γραμμη του αποτελεσματος και η ημερομηνια αγορας να ειναι αναμεσα στα start date, end date. Μετα ομαδοποιηση βασει του product id και μετα για καθε γραμμη βασει του id, παιρνω γινομενο price * units που μου βγαζει ποσο κερδος ειχε το προιον σε εκεινη την τιμη. Για ολα τα γινομενα που κανω, παιρνω την sum ωστε να βρω τα συνολικα κερδη του προιοντος ανεξαρτητου τιμης (και μοναδων πωλησης). Σε καθε γραμμη εχει ποσα units πουλησε το προιον με βαση καποια συγκεκριμενη τιμη. Παιρνω το αθροισμα ολων των μοναδων που πουλησε ενα προιον (βασει του id που εχω κανει ομαδοποιηση) ανεξαρτητου τιμης και τωρα αφου εχω 2 sums, τα διαιρω ωστε να δω την μεση τιμη πωλησης του καθε προιοντος.


--Απο την στιγμη που δεν χρειαζομαι τα null values που θα προεκυπταν απο την αριστερη συζευξη (εαν προεκυπταν) μπορω να εχω σκετο join ωστε να μην υπαρχουν

# Write your MySQL query statement below
select p.product_id, round(sum(p.price * u.units) / sum(u.units), 2) as average_price
from Prices as p join UnitsSold as u on p.product_id = u.product_id and u.purchase_date between
p.start_date and p.end_date
group by p.product_id