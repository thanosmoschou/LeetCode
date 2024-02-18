/*
Table: Signups

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
+----------------+----------+
user_id is the primary key for this table.
Each row contains information about the signup time for the user with ID user_id.
 

Table: Confirmations

+----------------+----------+
| Column Name    | Type     |
+----------------+----------+
| user_id        | int      |
| time_stamp     | datetime |
| action         | ENUM     |
+----------------+----------+
(user_id, time_stamp) is the primary key for this table.
user_id is a foreign key with a reference to the Signups table.
action is an ENUM of the type ('confirmed', 'timeout')
Each row of this table indicates that the user with ID user_id requested a confirmation message at time_stamp and that confirmation message was either confirmed ('confirmed') or expired without confirming ('timeout').
 

The confirmation rate of a user is the number of 'confirmed' messages divided by the total number of requested confirmation messages. The confirmation rate of a user that did not request any confirmation messages is 0. Round the confirmation rate to two decimal places.

Write an SQL query to find the confirmation rate of each user.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Signups table:
+---------+---------------------+
| user_id | time_stamp          |
+---------+---------------------+
| 3       | 2020-03-21 10:16:13 |
| 7       | 2020-01-04 13:57:59 |
| 2       | 2020-07-29 23:09:44 |
| 6       | 2020-12-09 10:39:37 |
+---------+---------------------+
Confirmations table:
+---------+---------------------+-----------+
| user_id | time_stamp          | action    |
+---------+---------------------+-----------+
| 3       | 2021-01-06 03:30:46 | timeout   |
| 3       | 2021-07-14 14:00:00 | timeout   |
| 7       | 2021-06-12 11:57:29 | confirmed |
| 7       | 2021-06-13 12:58:28 | confirmed |
| 7       | 2021-06-14 13:59:27 | confirmed |
| 2       | 2021-01-22 00:00:00 | confirmed |
| 2       | 2021-02-28 23:59:59 | timeout   |
+---------+---------------------+-----------+
Output: 
+---------+-------------------+
| user_id | confirmation_rate |
+---------+-------------------+
| 6       | 0.00              |
| 3       | 0.00              |
| 7       | 1.00              |
| 2       | 0.50              |
+---------+-------------------+
Explanation: 
User 6 did not request any confirmation messages. The confirmation rate is 0.
User 3 made 2 requests and both timed out. The confirmation rate is 0.
User 7 made 3 requests and all were confirmed. The confirmation rate is 1.
User 2 made 2 requests where one was confirmed and the other timed out. The confirmation rate is 1 / 2 = 0.5.


My Solution:
*/

# Write your MySQL query statement below
select tab1.user_id, 
case
  when tab2.tries = 0 then 0
  else round(tab1.tries / tab2.tries, 2)
end as confirmation_rate
from
(select s.user_id, count(c.action) as tries
from Signups as s left join Confirmations as c on s.user_id = c.user_id and c.action = 'confirmed'
group by s.user_id) as tab1,
(select t.user_id, count(b.action) as tries
from Signups as t left join Confirmations as b on t.user_id = b.user_id
group by t.user_id) as tab2
where tab1.user_id = tab2.user_id

--Ας τα παρουμε ενα ενα:

(select s.user_id, count(c.action) as tries
from Signups as s left join Confirmations as c on s.user_id = c.user_id and c.action = 'confirmed'
group by s.user_id) as tab1,

--Εδω κανω κλασικη αριστερη συζευξη των πινακων με την προυποθεση στην στηλη action να υπαρχει confirmed, αλλιως το πεδιο παιρνει την τιμη null. Στην στηλη αυτη θα εχει null γιατι κανω αριστερη συζευξη και οσες εγγραφες του αριστερου πινακα δεν κανουν match με εγγραφες του δεξιου πινακα μεσω των συνθηκων που οριζω στο on, στα αντιστοιχα πεδια του δεξιου πινακα θα εχουν τιμη null. Ετσι και εδω αν δεν υπαρχει στον αριστερο καποιο user id που να υπαρχει και στον δεξι πινακα, ή η στηλη δεν εχει τιμη confirmed, τοτε η στηλη action θα εχει τιμη null. Ομαδοποιω βασει του user id ωστε να δω ποσες πραξεις εκανε ο καθε χρηστης και στο τελος επιστρεφω το id και τον συνολικο αριθμο των προσπαθειων του οι οποιες ομως ειναι confirmed. Αν στην στηλη action εχει null το count θα επιστρεψει τιμη 0. Επισης ονομαζω τον τελικο πινακα που επιστρεφει το query tab1. Προσεξε το , γτ δεν κανω καμια συζευξη. Εχω απλο γινομενο πινακων.

(select t.user_id, count(b.action) as tries
from Signups as t left join Confirmations as b on t.user_id = b.user_id
group by t.user_id) as tab2

--Μια απο τα ιδια απλα εδω ενδιαφερομαι τοσο για τις confirmed οσο και για τις timeout.

where tab1.user_id = tab2.user_id

--Κραταω τις εγγραφες που εχουν ιδιο user id στα δυο πεδια ωστε να αναφερομαι στον ιδιο χρηστη και οχι σε 2 τυχαιους.

select tab1.user_id, 
case
  when tab2.tries = 0 then 0
  else round(tab1.tries / tab2.tries, 2)
end as confirmation_rate
from

--Εδω κανω select με μια case στην οποια απλα ελεγχω για καθε εγγραφη, αν ο συνολικος αριθμος προσπαθειων που εκανε ο χρηστης, οι οποιες προσδιοριζονται απο το tab2, ειναι 0 τοτε σιγουρα και οι confirmed θα ειναι 0 αρα θα εχω 0/0 και δεν οριζεται. Αρα απλα επιστρεφω τιμη 0 χωρις να κανω καμια διαιρεση. Διαφορετικα κανω την διαιρεση και κανω στρογγυλοποιηση 2 δεκαδικων. Ονομαζω την στηλη που μου επιστρεφει η select confirmation_rate.


--Another Solution from a user in leetcode:

select s.user_id , ROUND(AVG(if(c.action = "confirmed", 1 , 0)),2) as confirmation_rate
from Signups as s left join Confirmations as c
on s.user_id = c.user_id
group by user_id;

--Εδω κανω συζευξη οπως κανω εγω στα 2 μικροτερα queries μου, group by user id και μετα απλα για καθε χρηστη παει και βλεπει αν
--η καθε εγγραφη με το αντιστοιχο user id ειναι confirmed, με το αποτελεσμα τοτε να ειναι ισο με 1 αλλιως 0 και στο συνολο που δημιουργει για καθε χρηστη, βρισκει τον μεσο ορο (ποτε δεν θα ειναι το αποτελεσμα μεγαλυτερο του 1 καθως μιλαμε για πιθανοτητες).
