/*
Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order.

The result format is in the following example.

 

Example 1:

Input: 
Customer table:
+-------------+--------------+--------------+-------------+
| customer_id | name         | visited_on   | amount      |
+-------------+--------------+--------------+-------------+
| 1           | Jhon         | 2019-01-01   | 100         |
| 2           | Daniel       | 2019-01-02   | 110         |
| 3           | Jade         | 2019-01-03   | 120         |
| 4           | Khaled       | 2019-01-04   | 130         |
| 5           | Winston      | 2019-01-05   | 110         | 
| 6           | Elvis        | 2019-01-06   | 140         | 
| 7           | Anna         | 2019-01-07   | 150         |
| 8           | Maria        | 2019-01-08   | 80          |
| 9           | Jaze         | 2019-01-09   | 110         | 
| 1           | Jhon         | 2019-01-10   | 130         | 
| 3           | Jade         | 2019-01-10   | 150         | 
+-------------+--------------+--------------+-------------+
Output: 
+--------------+--------------+----------------+
| visited_on   | amount       | average_amount |
+--------------+--------------+----------------+
| 2019-01-07   | 860          | 122.86         |
| 2019-01-08   | 840          | 120            |
| 2019-01-09   | 840          | 120            |
| 2019-01-10   | 1000         | 142.86         |
+--------------+--------------+----------------+
Explanation: 
1st moving average from 2019-01-01 to 2019-01-07 has an average_amount of (100 + 110 + 120 + 130 + 110 + 140 + 150)/7 = 122.86
2nd moving average from 2019-01-02 to 2019-01-08 has an average_amount of (110 + 120 + 130 + 110 + 140 + 150 + 80)/7 = 120
3rd moving average from 2019-01-03 to 2019-01-09 has an average_amount of (120 + 130 + 110 + 140 + 150 + 80 + 110)/7 = 120
4th moving average from 2019-01-04 to 2019-01-10 has an average_amount of (130 + 110 + 140 + 150 + 80 + 110 + 130 + 150)/7 = 142.86

My Solution:
*/

# Write your MySQL query statement below
select a.visited_on, sum(b.amount) as amount, round(sum(b.amount) / 7, 2) as average_amount
from (select visited_on, sum(amount) as amount from Customer group by visited_on) as a,
     (select visited_on, sum(amount) as amount from Customer group by visited_on) as b
where datediff(a.visited_on, b.visited_on) between 0 and 6 
and a.visited_on - 6 >= (select min(visited_on) from Customer)
group by a.visited_on
order by a.visited_on

/*
Ας το αναλυσουμε:

from (select visited_on, sum(amount) as amount from Customer group by visited_on) as a,
     (select visited_on, sum(amount) as amount from Customer group by visited_on) as b

Παω στον πινακα των πελατων, κανω ομαδοποιηση βασει της ημερας επισκεψης και για καθε μερα επιστρεφω το συνολικο ποσο που ξοδευτηκε. Ονομαζω τον πινακα μου a και κανω το ιδιο και ονομαζω τον πινακα μου b. Τωρα θα κρατησω τις εγγραφες οπου το a.visited_on και το b.visited_on ειναι στο επιθυμητο ευρος 7 ημερων που θελω για να υπολογισω τους μεσους ορους.

where datediff(a.visited_on, b.visited_on) between 0 and 6 
and a.visited_on - 6 >= (select min(visited_on) from Customer)

Επισης θελω στο αριστερο κομματι του πινακα δηλαδη στο a.visited_on να υπαρχει η τελικη ημερομηνια του καθε διαστηματος οποτε θελω η εκαστοτε ημερομηνια - 6 ημερες να μην ειναι μικροτερη απο την αρχικη ημερομηνια που υπαρχει στον πινακα μου.

Αν πχ εχω

| 1           | Jhon         | 2019-01-01   | 100         |
| 2           | Daniel       | 2019-01-02   | 110         |
| 3           | Jade         | 2019-01-03   | 120         |
| 4           | Khaled       | 2019-01-04   | 130         |
| 5           | Winston      | 2019-01-05   | 110         | 
| 6           | Elvis        | 2019-01-06   | 140         | 
| 7           | Anna         | 2019-01-07   | 150         |
| 8           | Maria        | 2019-01-08   | 80          |
| 9           | Jaze         | 2019-01-09   | 110         | 
| 1           | Jhon         | 2019-01-10   | 130         | 
| 3           | Jade         | 2019-01-10   | 150         | 
+-------------+--------------+--------------+-------------+

τοτε θελω να εχω ημερομηνιες απο 2019-01-07 και μετα καθως αν πχ αφαιρεσω απο την 2019-01-03 6 ημερες τοτε η ημερομηνια που θα προκυψει δεν θα υπαρχει στον πινακα μου.

Αρα εχω εγγραφες που εχουν στο αριστερο τμημα του πινακα την τελικη ημερομηνια και δεξια εχουν ολες τις μικροτερες που ομως ανηκουν στο επιθυμητο διαστημα.

Τωρα θα ομαδοποιησω βασει της τελικης ημερομηνιας και ετσι θα εχω για καθε τελικη ημερομηνια και ομαδοποιημενες ολες τις μικροτερες που ανηκουν στο διαστημα μου.

select a.visited_on, sum(b.amount) as amount, round(sum(b.amount) / 7, 2) as average_amount

Θα εμφανισω την τελικη ημερομηνια μου, το συνολικο ποσο που υπαρχει στην στηλη b.amount για καθε τελικη ημερομηνια. Στην πραγματικοτητα αφου ομαδοποιησα τις ημερομηνιες βασει των τελικων, για καθε τελικη ξερω και τις προηγουμενες και τα ποσα που ξοδευτηκαν στις μικροτερες ημερομηνιες του διαστηματος υπαρχουν στην στηλη b.amount (μαζι με την τελικη ημερομηνια μου). Αρα εμφανιζω το αθροισμα και τον μεσο ορο 7 ημερων.
*/