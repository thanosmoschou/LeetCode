/*
Table: Queue

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| person_id   | int     |
| person_name | varchar |
| weight      | int     |
| turn        | int     |
+-------------+---------+
person_id column contains unique values.
This table has the information about all people waiting for a bus.
The person_id and turn columns will contain all numbers from 1 to n, where n is the number of rows in the table.
turn determines the order of which the people will board the bus, where turn=1 denotes the first person to board and turn=n denotes the last person to board.
weight is the weight of the person in kilograms.
 

There is a queue of people waiting to board a bus. However, the bus has a weight limit of 1000 kilograms, so there may be some people who cannot board.

Write a solution to find the person_name of the last person that can fit on the bus without exceeding the weight limit. The test cases are generated such that the first person does not exceed the weight limit.

The result format is in the following example.

 

Example 1:

Input: 
Queue table:
+-----------+-------------+--------+------+
| person_id | person_name | weight | turn |
+-----------+-------------+--------+------+
| 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    |
| 3         | Alex        | 350    | 2    |
| 6         | John Cena   | 400    | 3    |
| 1         | Winston     | 500    | 6    |
| 2         | Marie       | 200    | 4    |
+-----------+-------------+--------+------+
Output: 
+-------------+
| person_name |
+-------------+
| John Cena   |
+-------------+
Explanation: The folowing table is ordered by the turn for simplicity.
+------+----+-----------+--------+--------------+
| Turn | ID | Name      | Weight | Total Weight |
+------+----+-----------+--------+--------------+
| 1    | 5  | Alice     | 250    | 250          |
| 2    | 3  | Alex      | 350    | 600          |
| 3    | 6  | John Cena | 400    | 1000         | (last person to board)
| 4    | 2  | Marie     | 200    | 1200         | (cannot board)
| 5    | 4  | Bob       | 175    | ___          |
| 6    | 1  | Winston   | 500    | ___          |
+------+----+-----------+--------+--------------+


My Solution:
*/

# Write your MySQL query statement below
select person_name
from Queue
where turn = (
    select q1.turn
    from Queue as q1 join Queue as q2 on q1.turn >= q2.turn
    group by q1.turn
    having sum(q2.weight) <= 1000
    order by q1.turn desc
    limit 1
)

/*
Ας χτισουμε σιγα σιγα το query.


select *
from Queue as q1 join Queue as q2 on q1.turn >= q2.turn

Αρχικα θα κανω συζευξη τον πινακα με τον εαυτο του και θα ενωσω τις εγγραφες οπου η σειρα της εγγραφης του δεξιου πινακα θα ειναι μικροτερη ή ιση της σειρας της εγγραφης του αριστερου υποπινακα δηλαδη το ατομο στον αριστερο πινακα να ειναι το τελευταιο που μπαινει. 
Αρα για καθε εγγραφη του αριστερου πινακα με σειρα εστω 5 θα εχω εγγραφες που αριστερα θα εχουν αυτην την εγγραφη του αριστερου πινακα και δεξια θα εχουν εγγραφες οπου η σειρα θα ειναι μικροτερη ή ιση δηλαδη τις εγγραφες απο 1 εως 5

πχ ενα τμημα του τελικου πινακα

| person_id | person_name | weight | turn | person_id | person_name | weight | turn |
| --------- | ----------- | ------ | ---- | --------- | ----------- | ------ | ---- |
| 2         | Marie       | 200    | 4    | 5         | Alice       | 250    | 1    |
| 1         | Winston     | 500    | 6    | 5         | Alice       | 250    | 1    |
| 6         | John Cena   | 400    | 3    | 5         | Alice       | 250    | 1    |
| 3         | Alex        | 350    | 2    | 5         | Alice       | 250    | 1    |
| 4         | Bob         | 175    | 5    | 5         | Alice       | 250    | 1    |
| 5         | Alice       | 250    | 1    | 5         | Alice       | 250    | 1    |
| 1         | Winston     | 500    | 6    | 4         | Bob         | 175    | 5    |
| 4         | Bob         | 175    | 5    | 4         | Bob         | 175    | 5    |
| 2         | Marie       | 200    | 4    | 3         | Alex        | 350    | 2    |


select *
from Queue as q1 join Queue as q2 on q1.turn >= q2.turn
group by q1.turn
having sum(q2.weight) <= 1000

Επειτα ομαδοποιω βασει του q1.turn ωστε να εχω συνδυασμους πελατων με τελευταιο ατομο το ατομο με το q1.turn. Αρα για καθε τιμη q1.turn ξερω και ποιοι ειναι αυτοι που προηγουνται. Θα κρατησω τις εγγραφες του πινακα μονο αν για καθε υποομαδα η στηλη q2.weight δηλαδη τα κιλα των ατομων μεχρι και τον q1.turn να μην ξεπερνουν τα 1000 κιλα.

select q1.turn
from Queue as q1 join Queue as q2 on q1.turn >= q2.turn
group by q1.turn
having sum(q2.weight) <= 1000
order by q1.turn desc
limit 1

Εδω θα κανω ταξινομηση τις εγγραφες βασει του q1.turn σε φθινουσα σειρα και θα εμφανισω τα q1.turn. Ωστοσο επειδη λεω limit 1 θα εμφανισω μονο την πρωτη εγγραφη αρα τον τελευταιο που επιτρεπεται να μπει στο λεωφορειο.


select person_name
from Queue
where turn = (
    select q1.turn
    from Queue as q1 join Queue as q2 on q1.turn >= q2.turn
    group by q1.turn
    having sum(q2.weight) <= 1000
    order by q1.turn desc
    limit 1
)

Τωρα στον πινακα queue θα κρατησω την εγγραφη που το turn ισουται με το turn που θα επιστρεψει το υποσυνολο και απλως θα εμφανισω το ονομα του τελευταιου που μπορει να μπει στο λεωφορειο.
*/