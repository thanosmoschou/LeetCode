/*
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
 

Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places. In other words, you need to count the number of players that logged in for at least two consecutive days starting from their first login date, then divide that number by the total number of players.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+-----------+-----------+------------+--------------+
| player_id | device_id | event_date | games_played |
+-----------+-----------+------------+--------------+
| 1         | 2         | 2016-03-01 | 5            |
| 1         | 2         | 2016-03-02 | 6            |
| 2         | 3         | 2017-06-25 | 1            |
| 3         | 1         | 2016-03-02 | 0            |
| 3         | 4         | 2018-07-03 | 5            |
+-----------+-----------+------------+--------------+
Output: 
+-----------+
| fraction  |
+-----------+
| 0.33      |
+-----------+
Explanation: 
Only the player with id 1 logged back in after the first day he had logged in so the answer is 1/3 = 0.33

My Solution:
*/

# Write your MySQL query statement below
select round(count(distinct player_id) / (select count(distinct player_id) from Activity), 2) as fraction
from Activity
where (player_id, event_date) in (
                    select player_id, min(event_date)
                    from Activity
                    group by player_id
) and adddate(event_date, interval 1 day) in (
                                                select event_date 
                                                from Activity as tmp
                                                where tmp.player_id = Activity.player_id
)


/*
Ας τα παρουμε με την σειρα:

Θελω απο τον πινακα Activity να κρατησω τις εγγραφες για τις οποιες ισχυουν 2 συνθηκες ταυτοχρονα. Οι συνθηκες ειναι:
1 -> Το ζευγος τιμων του εξωτερικου πινακα (player id, event date) να υπαρχει σε ενα συνολο. Αυτο το συνολο ειναι η πρωτη ημερομηνια συνδεσης καθε χρηστη:

select player_id, min(event_date)
from Activity
group by player_id

2 -> Η επομενη μερα απο την πρωτη μερα συνδεσης: adddate(event_date, interval 1 day) να υπαρχει σε ενα συνολο. Αυτο το συνολο ειναι ολες οι ημερομηνιες που συνδεθηκε καποιος συγκεκριμενος χρηστης:

select event_date 
from Activity as tmp
where tmp.player_id = Activity.player_id

Εφοσον ισχυουν ταυτοχρονα οι 2 συνθηκες κραταω τις εγγραφες. Μετα απλα θελω να διαιρεσω τον συνολικο αριθμο τιμων που περιεχει η στηλη player id του τελικου μου πινακα, με τον συνολικο αριθμο παιχτων. Παλι κανω στρογγυλοποιηση:

round(count(distinct player_id) / (select count(distinct player_id) from Activity), 2)


Μια διαφορετικη υλοποιηση ενος χρηστη στο leetcode:

# Write your MySQL query statement below
SELECT ROUND(COUNT(t2.player_id)/COUNT(t1.player_id),2) AS fraction
FROM
(SELECT player_id, MIN(event_date) AS first_login FROM Activity GROUP BY player_id) t1 LEFT JOIN Activity t2
ON t1.player_id = t2.player_id AND DATEDIFF(t2.event_date , t1.first_login)=1 

Παιρνει ως πινακα την στηλη player id μαζι με την πρωτη ημερομηνια συνδεσης καθε χρηστη:

(SELECT player_id, MIN(event_date) AS first_login FROM Activity GROUP BY player_id)

επειτα κανει αριστερη συζευξη με τον Activity και ενωνει τις γραμμες των 2 πινακων μονο οταν ισχυουν οι συνθηκες:
ON t1.player_id = t2.player_id AND DATEDIFF(t2.event_date , t1.first_login)=1 

Δηλαδη οπως θα γινει γινομενο πινακων στην συζευξη, θα ενωθουν οι γραμμες του αριστερου με τις γραμμες του δεξιου πινακα αντιστοιχα. Θα επιστραφει ενας πινακας με στηλες ολες τις στηλες και των 2 πινακων. Ως αποτελεσμα θα ειναι ολες οι γραμμες του αριστερου ενωμενες με οσες γραμμες του δεξιου κανουν match με τις συνθηκες που οριζει και οι γραμμες του αριστερου που δεν ταιριαζουν με τις γραμμες του δεξιου, θα περιεχουν null στα πεδια του δεξιου πινακα (παντα για το τελικο αποτελεσμα μιλαμε)

Θυμησου οταν κανουμε γινομενο πινακων (ή συζευξη κτλ) ο τελικος πινακας εχει τοσες στηλες οσες εχει ο πινακας1 + οσες εχει ο πινακας2 και τα ονοματα των στηλων ειναι τα ιδια με αυτα των πινακων. Οποτε αν θελω να εμφανισω μια στηλη που υπαρχει και στους 2 πινακες, τοτε θα πρεπει να αναφερθω και στο ονομα του πινακα απο την οποια προηρθε. Αν κανεις φυσικη συζευξη (που βασιζεται στο κυριο και ξενο κλειδι) τοτε ο τελικος πινακας εχει μονο ενα αντιγραφο της κοινης στηλης.

πχ ο πινακας1 εχει μια στηλη ονομα και το ιδιο ισχυει και για τον πινακα2.
Κανω συζευξη τους πινακες

select something
from πινακας1 left join πινακας2 on condition

Τωρα ο πικανας που προκυπτει απο την συζευξη εχει 2 στηλες ονομα. Την πινακας1.ονομα και την πινακας2.ονομα
Αρα αν εμφανισω σκετο ονομα θα προκυψει μπερδεμα. Οποτε πρεπει να αναφερθω σε αυτες ως πινακας1.ονομα ή πινακας2.ονομα ομως θα αναφερομαι στις στηλες του τελικου μου πινακα και οχι σε αυτες των 2 αρχικων γτ η select δεν τροποποιει τον πινακα. Απλως μου εμφανιζει ενα αποτελεσμα βασει φιλτραρισματος. Απλως να θυμασαι οτι στην τελικη εμφανιση του πινακα δεν θα λεει πινακας1.ονομα αλλα σκετο ονομα
*/