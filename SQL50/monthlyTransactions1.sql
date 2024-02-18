/*
Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+


My Solution:
*/

# Write your MySQL query statement below
select substr(trans_date, 1, 7) as month, country, count(state) as trans_count,
sum(case 
      when state = 'approved' then 1 
      else 0 
    end
    ) as approved_count, 
sum(amount) as trans_total_amount, 
sum(case 
      when state = 'approved' then amount 
      else 0 
    end) as approved_total_amount
from Transactions as t
group by country, substr(trans_date, 1, 7)

/*
Ας τα παρουμε απο την αρχη:

substr(trans_date, 1, 7) -> Επιστρεφει ενα substring του trans date με αρχη την θεση 1 (τα αλφαριθμητικα στην sql ξεκινανε απο το 1 και οχι απο το 0) και θα επιστρεψει 7 χαρακτηρες.

Παλι κανω ομαδοποιηση βασει χωρας και του μικροτερου αλφαριθμητικου που επιστραφηκε το οποιο μου δειχνει τον μηνα. Αρα κανω ομαδοποιηση βασει χωρας και μηνα.

count(state) as trans_count

Εδω εμφανιζω τις συνολικες κινησεις του μηνα ασχετως αν εγκριθηκαν ή απορριφθηκαν.

sum(case 
      when state = 'approved' then 1 
      else 0 
    end
    ) as approved_count

Εδω δημιουργω ενα νεο συνολο: Αν για την εγγραφη μου η τιμη state ειναι approved, τοτε στο συνολο προσθετω την τιμη 1, αλλιως την τιμη 0. Προσθετω τις τιμες που εχει το συνολο μου για να δω ποσες κινησεις εγιναν δεκτες. 

sum(amount) as trans_total_amount

Εδω θελω το συνολικο φορτιο απο τις κινησεις ασχετως αν εγκριθηκαν ή απορριφθηκαν.
 
sum(case 
      when state = 'approved' then amount 
      else 0 
    end) as approved_total_amount

Εδω τα πραγματα ειναι παρομοια με το παραπανω query απλα αντι για 1 και 0 βαζω το φορτιο της κινησης εφοσον εγινε δεκτη και προσθετω ολα τα φορτια για να δω το συνολικο φορτιο των κινησεων που εγκριθηκαν.


Another similar solution from a user in leetcode:

# Write your MySQL query statement below
SELECT 
SUBSTR(TRANS_DATE,1,7) AS month,
country,
COUNT(1) AS trans_count,
SUM(CASE WHEN STATE='approved' THEN 1 ELSE 0 END) AS approved_count,
SUM(AMOUNT) AS trans_total_amount,
SUM(CASE WHEN STATE='approved' THEN AMOUNT ELSE 0 END) AS approved_total_amount
FROM TRANSACTIONS
GROUP BY 1,2

COUNT(1) AS trans_count
Εδω απλα παιρνει την 1η στηλη που εμφανιζεται στην select και κανει count

GROUP BY 1,2
Εδω απλα κανει ομαδοποιηση βασει της 1ης και 2ης στηλης που εμφανιζονται στην select δηλ. το substr και την χωρα. Η μονη διαφορα εδω ειναι αυτη η συντομογραφια των στηλων με αριθμους βασει της σειρας εμφανισης τους στην select αντι να καθεται και να γραφει τις στηλες.
*/