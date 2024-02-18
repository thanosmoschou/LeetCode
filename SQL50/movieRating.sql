/*
Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
 

Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 
 

Write a solution to:

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.
The result format is in the following example.

 

Example 1:

Input: 
Movies table:
+-------------+--------------+
| movie_id    |  title       |
+-------------+--------------+
| 1           | Avengers     |
| 2           | Frozen 2     |
| 3           | Joker        |
+-------------+--------------+
Users table:
+-------------+--------------+
| user_id     |  name        |
+-------------+--------------+
| 1           | Daniel       |
| 2           | Monica       |
| 3           | Maria        |
| 4           | James        |
+-------------+--------------+
MovieRating table:
+-------------+--------------+--------------+-------------+
| movie_id    | user_id      | rating       | created_at  |
+-------------+--------------+--------------+-------------+
| 1           | 1            | 3            | 2020-01-12  |
| 1           | 2            | 4            | 2020-02-11  |
| 1           | 3            | 2            | 2020-02-12  |
| 1           | 4            | 1            | 2020-01-01  |
| 2           | 1            | 5            | 2020-02-17  | 
| 2           | 2            | 2            | 2020-02-01  | 
| 2           | 3            | 2            | 2020-03-01  |
| 3           | 1            | 3            | 2020-02-22  | 
| 3           | 2            | 4            | 2020-02-25  | 
+-------------+--------------+--------------+-------------+
Output: 
+--------------+
| results      |
+--------------+
| Daniel       |
| Frozen 2     |
+--------------+
Explanation: 
Daniel and Monica have rated 3 movies ("Avengers", "Frozen 2" and "Joker") but Daniel is smaller lexicographically.
Frozen 2 and Joker have a rating average of 3.5 in February but Frozen 2 is smaller lexicographically.

My Solution:
*/

# Write your MySQL query statement below
select name as results
from Users
where name = (
  select u.name
  from Users as u join MovieRating as m on u.user_id = m.user_id 
  group by u.user_id
  order by count(movie_id) desc, u.name
  limit 1)

union all

select title as results
from Movies
where title = (
  select m1.title
  from Movies as m1 join MovieRating as m2 on m1.movie_id = m2.movie_id
  where substr(m2.created_at, 1, 7) = '2020-02'
  group by m1.movie_id
  order by avg(m2.rating) desc, title
  limit 1)

/*
Ας αναλυσουμε το query:

Αρχικα ζηταει να βρουμε τον χρηστη που εκανε τις περισσοτερες κριτικες και επειτα να βρουμε την ταινια με τον καλυτερο μεσο ορο κριτικων για τον μηνα Φεβρουαριο. Αρα καταλαβαινω οτι θελω μιας μορφης ενωση.

Παμε για το πρωτο σκελος:

select name as results
from Users
where name = (
  select u.name
  from Users as u join MovieRating as m on u.user_id = m.user_id 
  group by u.user_id
  order by count(movie_id) desc, u.name
  limit 1)

Θελω απο τον πινακα Users τα ονοματα οπου ισουται με μια τιμη που θα επιστραφει απο το υποερωτημα. Τι θα επιστρεψει το υποερωτημα?
Αρχικα παει στον πινακα Users, κανει συζευξη με τον MovieRating βασει του user_id, κανει ομαδοποιηση βασει του user id ωστε να ξερει για καθε χρηστη ποσες κριτικες εχει κανει. Μετα απλα κανει ταξινομηση βασει του count(movie_id) το οποιο για καθε διαφορετικο user id επιστρεφει ποσες τιμες εχει η στηλη movie id δηλαδη ποσες κριτικες σε ταινιες εχει κανει ο καθε χρηστης. Η ταξινομηση γινεται σε φθινουσα σειρα γιατι θελω να επιστρεψω τον χρηστη με τις περισσοτερες κριτικες. Σε περιπτωση ισοβαθμιας επιστρεφω το μικροτερο λεξικογραφικα ονομα οπως οριζει η ασκηση. Τελος με το limit 1 επιστρεφω το ονομα με τις περισσοτερες κριτικες βασει των κριτηριων που ορισα. Τελος στο εξωτερικο ερωτημα θα παραμεινει μονο ενα ονομα καθως τα ονοματα στους πινακες υπαρχουν μια φορα.


Με παρομοιο τροπο λειτουργει και το δευτερο σκελος:

select title as results
from Movies
where title = (
  select m1.title
  from Movies as m1 join MovieRating as m2 on m1.movie_id = m2.movie_id
  where substr(m2.created_at, 1, 7) = '2020-02'
  group by m1.movie_id
  order by avg(m2.rating) desc, title
  limit 1)

Απο τον πινακα Movies θελω να κρατησω τις ταινιες οπου ο τιτλος ισουται με την τιμη που θα επιστρεψει το υποερωτημα. Τι τιμη επιστρεφει?
Αρχικα κανει συζευξη του πινακα Movies με τον MovieRating βασει movie id, κραταει τις εγγραφες οπου η κριτικη εγινε τον μηνα Φεβρουαριο (substr που δεχεται την τιμη created_ad, ξεκιναει απο την αρχη του αλφαριθμητικου δηλ την τιμη 1 και εξαγει 7 χαρακτηρες), επειτα κανει ομαδοποιηση βασει του movie_id ωστε να γνωριζω ποσες κριτικες εχει συγκεντρωσει μια ταινια. Επειτα κανει ταξινομηση βασει του μεσου ορου κριτικων που εχει η καθε ταινια παλι σε φθινουσα διαταξη και παλι σε περιπτωση ισοβαθμιας επιστρεφεται ο μικροτερος τιτλος λεξικογραφικα (με το limit 1)

Τελος απλα κανω ενα union των αποτελεσματων. Θυμησου οτι το select name as results απλα δημιουργει μια στηλη results και προσθετει μεσα την τιμη απο την στηλη name που εχει επιστραφει.

Μια διαφορετικη υλοποιηση:

# Write your MySQL query statement below
(
select u.name as results
from Users as u join MovieRating as m on u.user_id = m.user_id 
group by u.user_id
order by count(movie_id) desc, u.name
limit 1
)
union all
(
select m1.title as results
from Movies as m1 join MovieRating as m2 on m1.movie_id = m2.movie_id
where substr(m2.created_at, 1, 7) = '2020-02'
group by m1.movie_id
order by avg(m2.rating) desc, title
limit 1
)

Αρχικα ετσι πηγα να το κανω και εγω απλως δεν ειχα βαλει παρενθεσεις και μου εμφανιζε συντακτικο σφαλμα.
*/