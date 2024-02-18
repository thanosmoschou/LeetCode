/*
Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
 

Write an SQL query to find the prices of all products on 2019-08-16. Assume the price of all products before any change is 10.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Products table:
+------------+-----------+-------------+
| product_id | new_price | change_date |
+------------+-----------+-------------+
| 1          | 20        | 2019-08-14  |
| 2          | 50        | 2019-08-14  |
| 1          | 30        | 2019-08-15  |
| 1          | 35        | 2019-08-16  |
| 2          | 65        | 2019-08-17  |
| 3          | 20        | 2019-08-18  |
+------------+-----------+-------------+
Output: 
+------------+-------+
| product_id | price |
+------------+-------+
| 2          | 50    |
| 1          | 35    |
| 3          | 10    |
+------------+-------+


My Solution:
*/

# Write your MySQL query statement below
select product_id, new_price as price
from Products
where (product_id, change_date) in
(
    select product_id, max(change_date) as change_date
    from Products 
    where change_date <= '2019-08-16'
    group by product_id
)
union
select product_id, 10 as price
from Products
where product_id not in 
(
    select product_id
    from Products
    where change_date <= '2019-08-16'
    group by product_id
)

/*
Ας τα παρουμε με την σειρα:

Ειπαμε οτι το union ενωνει τα αποτελεσματα απο 2 ή περισσοτερες select.

select product_id, new_price as price
from Products
where (product_id, change_date) in
(
    select product_id, max(change_date) as change_date
    from Products 
    where change_date <= '2019-08-16'
    group by product_id
)

Εδω παω στον πινακα Products και θελω να κρατησω μονο τις εγγραφες για τις οποιες το product_id και το change date υπαρχουν ταυτοχρονα σε ενα συνολο: Το συνολο ειναι τα product id και η μεγαλυτερη ημερομηνια αλλαγης τιμης για καθε product (group by product id), η οποια ομως ειναι μικροτερη ή ιση της '2019-08-16'. Επειτα εμφανιζω το product id και την τελευταια τιμη.


select product_id, 10 as price
from Products
where product_id not in 
(
    select product_id
    from Products
    where change_date <= '2019-08-16'
    group by product_id
)

Εδω τα πραγματα ειναι αρκετα ομοια με πριν απλως παω στον πινακα Products και θα κρατησω τις εγγραφες του πινακα για τις οποιες το product id δεν ειναι σε ενα συνολο: Αρχικα παω στον Products, ομαδοποιω βασει προϊόντος, κραταω τις εγγραφες που η ημερομηνια αλλαγης ειναι μικροτερη ή ιση απο αυτην που οριζω και τελος θα επιστρεψω μονο την στηλη με τα product id που θα ειναι και το συνολο που θελω.
Εδω ομως θα εμφανισω το product id και αντι για μια τιμη θα εμφανισω την τιμη 10 υποτιθεται οτι μεχρι την ημερομηνια που θελω, αυτα τα προϊόντα δεν ειχαν αλλαγη στην τιμη τους.


Info:
Στην select εμφανιζω στηλες. Απλα λεω

select ονομαΣτηλης
from πινακας

και εμφανιζεται. Μπορω ομως αντι για ονομα στηλης να γραψω πχ εναν αριθμο

select 10
from πινακας

Εδω θα εμφανισει παλι μια στηλη που αντι για τιμες του πινακα, θα ειναι γεματη με την τιμη 10. Ποσα 10 θα εχει συνολικα; Οσες ειναι και οι εγγραφες του πινακα μου. Αν ο πινακας εχει 10 εγγραφες, τοτε η select θα επιστρεψει μια στηλη που θα εχει δεκα τιμες 10. Η στηλη που θα εμφανιστει θα εχει το ιδιο ονομα με την στηλη στον πινακα μου.

πχ
select name
from A

Τοτε θα εμφανισει την στηλη name του πινακα A. Μπορω να βαλω alias και να μην πω την στηλη name στο τελικο αποτελεσμα

select name as t
from A

Τωρα η στηλη που θα εμφανιστει θα εχει ονομα t παρολο που ειναι η στηλη name του πινακα A.

Στην περιπτωση

select 10
from A

Η στηλη θα ονομαστει 10 και θα περιεχει τιμες 10. Αξιζει να τονιστει πως δεν υπαρχει τετοια στηλη στον πινακα μου για αυτο και την ονομαζει οπως την ζητησα εγω στην select και περιεχει τοσα 10 οσες και οι εγγραφες του πινακα. 

Αρα αν εγω πω 
select randomThing
from A

πχ

select 10
from A

Θα ονομασει μια στηλη 10 και θα εχει τοσα 10 ως τιμες, οσες και οι εγγραφες του πινακα. Αρα το 10 εχει διπλο ρολο εδω μιας και τετοια στηλη δεν υπαρχει στον πινακα μου.

Αν τωρα πω

select 10 as val
from A

Τοτε το αποτελεσμα θα ειναι το ιδιο με πριν απλως αντι να ονομαστει η στηλη 10 θα ονομαστει val.
*/