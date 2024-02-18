/*
Table: RequestAccepted

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| requester_id   | int     |
| accepter_id    | int     |
| accept_date    | date    |
+----------------+---------+
(requester_id, accepter_id) is the primary key (combination of columns with unique values) for this table.
This table contains the ID of the user who sent the request, the ID of the user who received the request, and the date when the request was accepted.
 

Write a solution to find the people who have the most friends and the most friends number.

The test cases are generated so that only one person has the most friends.

The result format is in the following example.

 

Example 1:

Input: 
RequestAccepted table:
+--------------+-------------+-------------+
| requester_id | accepter_id | accept_date |
+--------------+-------------+-------------+
| 1            | 2           | 2016/06/03  |
| 1            | 3           | 2016/06/08  |
| 2            | 3           | 2016/06/08  |
| 3            | 4           | 2016/06/09  |
+--------------+-------------+-------------+
Output: 
+----+-----+
| id | num |
+----+-----+
| 3  | 3   |
+----+-----+
Explanation: 
The person with id 3 is a friend of people 1, 2, and 4, so he has three friends in total, which is the most number than any others.
 

Follow up: In the real world, multiple people could have the same most number of friends. Could you find all these people in this case?

My Solution:
*/

# Write your MySQL query statement below
select id, sum(num) as num
from ((
select requester_id as id, count(requester_id) as num
from RequestAccepted 
group by requester_id
)
union all
(
select accepter_id as id, count(accepter_id) as num
from RequestAccepted
group by accepter_id
)) as t
group by id
order by num desc
limit 1

/*
Ας το αναλυσουμε:

Αρχικα κανω ενωση 2 πινακες:

(
select requester_id as id, count(requester_id) as num
from RequestAccepted 
group by requester_id
)
union all
(
select accepter_id as id, count(accepter_id) as num
from RequestAccepted
group by accepter_id
)

Στο πρωτο select παω στον πινακα RequestAccepted, ομαδοποιω βασει requester και για καθε διαφορετικο requester βλεπω ποσες φορες εμφανιζεται στην στηλη requester id δηλαδη ποσους φιλους απεκτησε κανοντας αυτος request. 
Στο δευτερο κανω ακριβως την ιδια διαδικασια απλα τωρα βλεπω ποσες φορες εμφανιζεται ενας accepter δηλαδη ποσους φιλους απεκτησε καποιος κανοντας αποδοχη αιτηματος.
Χρησιμοποιω union all γιατι μπορει πχ για ενα id εστω το 17, να εμφανιζεται 5 φορες στον εναν πινακα και 5 στον αλλον οποτε αν ειχα σκετο union αυτες οι εγγραφες θα θεωρουνταν διπλοτυπες και θα κρατουσε μονο την μια. Τελος ονομαζω τον πινακα που προεκυψε απο την ενωση. Εγω τον ονομασα t.

Οποτε τωρα για να κανω λιγο πιο ευκολη την εξηγηση θα παραλειψω το κομματι της ενωσης και θα γραφω σκετο t. Δηλαδη αντι για 

select id, sum(num) as num
from ((
select requester_id as id, count(requester_id) as num
from RequestAccepted 
group by requester_id
)
union all
(
select accepter_id as id, count(accepter_id) as num
from RequestAccepted
group by accepter_id
)) as t
group by id
order by num desc
limit 1

θα το γραφω ως

select id, sum(num) as num
from t
group by id
order by num desc
limit 1

Τωρα εχω εναν πινακα με μια στηλη id και μια στηλη num. Αρκει να κανω ομαδοποιηση βασει id και για καθε id να προσθεσω τις τιμες που υπαρχουν στην στηλη num ωστε να βρω τους φιλους του. Προσοχη δεν θελω count γιατι η ενωση μου επεστρεψε ποσες φορες εκανε καποιος αιτημα και ποσες αποδεχτηκε καποιο αιτημα αρα θελω να προσθεσω ολες αυτες τις φορες.
*/