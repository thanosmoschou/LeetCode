/*
Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Accounts table:
+------------+--------+
| account_id | income |
+------------+--------+
| 3          | 108939 |
| 2          | 12747  |
| 8          | 87709  |
| 6          | 91796  |
+------------+--------+
Output: 
+----------------+----------------+
| category       | accounts_count |
+----------------+----------------+
| Low Salary     | 1              |
| Average Salary | 0              |
| High Salary    | 3              |
+----------------+----------------+
Explanation: 
Low Salary: Account 2.
Average Salary: No accounts.
High Salary: Accounts 3, 6, and 8.

My Solution:
*/

# Write your MySQL query statement below
select 'Low Salary' as category, count(income) as accounts_count
from Accounts
where income < 20000
union
select 'Average Salary', count(income) as accounts_count
from Accounts
where income between 20000 and 50000
union
select 'High Salary', count(income) as accounts_count
from Accounts
where income > 50000

--Ας το αναλυσουμε:

select 'Low Salary' as category, count(income) as accounts_count
from Accounts
where income < 20000

--Εδω παμε στον πινακα Accounts και κραταμε τις εγγραφες που το income ειναι μικροτερο απο 20000. Μετα απλα εμφανιζουμε εναν πινακα που θα εχει 2 στηλες. Μια στηλη 'Low Salary' με τιμη Low Salary (1 τιμη στην στηλη καθως μια τιμη παιρνω απο το count στην select) και διπλα μια στηλη count με τιμη τον συνολικο αριθμο λογαριασμων. Αν τρεξω το query χωρις aliases θα προκυψει:

/*
| Low Salary | count(income) |
| ---------- | ------------- |
| Low Salary | 1             |

Οπως σε προηγουμενη ασκηση λεγαμε
*/
select 10
from A

--και αυτο θα εφτιαχνε μια στηλη με ονομα 10 και τιμες τοσα 10 οσα και οι εγγραφες του πινακα μου ετσι και το πιο πανω ερωτημα
--θα δημιουργησει μια στηλη Low Salary με τιμη Low Salary. Ωστοσο επειδη το count διπλα επιστρεφει μονο εναν αριθμο, για να υπαρχει ομοιομορφια στο αποτελεσμα (η select δεν μπορει να επιστρεψει 2 στηλες με την μια να περιεχει 10 τιμες και την αλλη να περιεχει 5 τιμες. Πρεπει να περιεχουν τον ιδιο αριθμο τιμων), η στηλη Low Salary θα περιεχει και αυτη μια τιμη. Αν τωρα εχω aliases θα ονομασω την στηλη αντι για Low Salary category και θα εχει τιμη Low Salary.

--Με αναλογο τροπο λειτουργουν και τα υπολοιπα μερη του ερωτηματος. Ωστοσο στα επομενα μερη με την ενωση δεν χρειαζεται να δωσω ψευδονυμο στην στηλη καθως η τελικη στηλη παιρνει το ονομα της απο το πρωτο select.