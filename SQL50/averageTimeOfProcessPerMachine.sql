/*
Table: Activity

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| machine_id     | int     |
| process_id     | int     |
| activity_type  | enum    |
| timestamp      | float   |
+----------------+---------+
The table shows the user activities for a factory website.
(machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
machine_id is the ID of a machine.
process_id is the ID of a process running on the machine with ID machine_id.
activity_type is an ENUM (category) of type ('start', 'end').
timestamp is a float representing the current time in seconds.
'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
The 'start' timestamp will always be before the 'end' timestamp for every (machine_id, process_id) pair.
 

There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.

The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.

The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.

Return the result table in any order.

The result format is in the following example.

 

Example 1:

Input: 
Activity table:
+------------+------------+---------------+-----------+
| machine_id | process_id | activity_type | timestamp |
+------------+------------+---------------+-----------+
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
| 2          | 0          | start         | 4.100     |
| 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.500     |
| 2          | 1          | end           | 5.000     |
+------------+------------+---------------+-----------+
Output: 
+------------+-----------------+
| machine_id | processing_time |
+------------+-----------------+
| 0          | 0.894           |
| 1          | 0.995           |
| 2          | 1.456           |
+------------+-----------------+
Explanation: 
There are 3 machines running 2 processes each.
Machine 0's average time is ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
Machine 1's average time is ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995
Machine 2's average time is ((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456


My Solution:

Δες τον πινακα:

Activity table:
+------------+------------+---------------+-----------+
| machine_id | process_id | activity_type | timestamp |
+------------+------------+---------------+-----------+
| 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.520     |
| 0          | 1          | start         | 3.140     |
| 0          | 1          | end           | 4.120     |
| 1          | 0          | start         | 0.550     |
| 1          | 0          | end           | 1.550     |
| 1          | 1          | start         | 0.430     |
| 1          | 1          | end           | 1.420     |
| 2          | 0          | start         | 4.100     |
| 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.500     |
| 2          | 1          | end           | 5.000     |
+------------+------------+---------------+-----------+

Ενωνω τον πινακα με τον εαυτο του δηλαδη ενωνω τις γραμμες τους. Αλλα δεν θα κρατησω ολες τις γραμμες του αποτελεσματος

Ενα απλο query που κανω join 2 πινακες:

select *
from Activity as a join Activity as b 

Αποτελεσμα:

| machine_id | process_id | activity_type | timestamp | machine_id | process_id | activity_type | timestamp |
| ---------- | ---------- | ------------- | --------- | ---------- | ---------- | ------------- | --------- |
| 2          | 1          | end           | 5         | 0          | 0          | start         | 0.712     |
| 2          | 1          | start         | 2.5       | 0          | 0          | start         | 0.712     |
| 2          | 0          | end           | 4.512     | 0          | 0          | start         | 0.712     |
| 2          | 0          | start         | 4.1       | 0          | 0          | start         | 0.712     |
| 1          | 1          | end           | 1.42      | 0          | 0          | start         | 0.712     |
| 1          | 1          | start         | 0.43      | 0          | 0          | start         | 0.712     |
| 1          | 0          | end           | 1.55      | 0          | 0          | start         | 0.712     |
| 1          | 0          | start         | 0.55      | 0          | 0          | start         | 0.712     |
| 0          | 1          | end           | 4.12      | 0          | 0          | start         | 0.712     |
| 0          | 1          | start         | 3.14      | 0          | 0          | start         | 0.712     |
| 0          | 0          | end           | 1.52      | 0          | 0          | start         | 0.712     |
| 0          | 0          | start         | 0.712     | 0          | 0          | start         | 0.712     |
| 2          | 1          | end           | 5         | 0          | 0          | end           | 1.52      |
| 2          | 1          | start         | 2.5       | 0          | 0          | end           | 1.52      |
| 2          | 0          | end           | 4.512     | 0          | 0          | end           | 1.52      |
| 2          | 0          | start         | 4.1       | 0          | 0          | end           | 1.52      |
| 1          | 1          | end           | 1.42      | 0          | 0          | end           | 1.52      |
| 1          | 1          | start         | 0.43      | 0          | 0          | end           | 1.52      |
| 1          | 0          | end           | 1.55      | 0          | 0          | end           | 1.52      |
| 1          | 0          | start         | 0.55      | 0          | 0          | end           | 1.52      |
| 0          | 1          | end           | 4.12      | 0          | 0          | end           | 1.52      |
| 0          | 1          | start         | 3.14      | 0          | 0          | end           | 1.52      |
| 0          | 0          | end           | 1.52      | 0          | 0          | end           | 1.52      |
| 0          | 0          | start         | 0.712     | 0          | 0          | end           | 1.52      |
| 2          | 1          | end           | 5         | 0          | 1          | start         | 3.14      |
| 2          | 1          | start         | 2.5       | 0          | 1          | start         | 3.14      |
| 2          | 0          | end           | 4.512     | 0          | 1          | start         | 3.14      |
| 2          | 0          | start         | 4.1       | 0          | 1          | start         | 3.14      |
| 1          | 1          | end           | 1.42      | 0          | 1          | start         | 3.14      |
| 1          | 1          | start         | 0.43      | 0          | 1          | start         | 3.14      |
| 1          | 0          | end           | 1.55      | 0          | 1          | start         | 3.14      |
| 1          | 0          | start         | 0.55      | 0          | 1          | start         | 3.14      |
| 0          | 1          | end           | 4.12      | 0          | 1          | start         | 3.14      |
| 0          | 1          | start         | 3.14      | 0          | 1          | start         | 3.14      |
| 0          | 0          | end           | 1.52      | 0          | 1          | start         | 3.14      |
| 0          | 0          | start         | 0.712     | 0          | 1          | start         | 3.14      |
| 2          | 1          | end           | 5         | 0          | 1          | end           | 4.12      |
| 2          | 1          | start         | 2.5       | 0          | 1          | end           | 4.12      |
| 2          | 0          | end           | 4.512     | 0          | 1          | end           | 4.12      |
| 2          | 0          | start         | 4.1       | 0          | 1          | end           | 4.12      |
| 1          | 1          | end           | 1.42      | 0          | 1          | end           | 4.12      |
| 1          | 1          | start         | 0.43      | 0          | 1          | end           | 4.12      |
| 1          | 0          | end           | 1.55      | 0          | 1          | end           | 4.12      |
| 1          | 0          | start         | 0.55      | 0          | 1          | end           | 4.12      |
| 0          | 1          | end           | 4.12      | 0          | 1          | end           | 4.12      |
| 0          | 1          | start         | 3.14      | 0          | 1          | end           | 4.12      |
| 0          | 0          | end           | 1.52      | 0          | 1          | end           | 4.12      |
| 0          | 0          | start         | 0.712     | 0          | 1          | end           | 4.12      |
| 2          | 1          | end           | 5         | 1          | 0          | start         | 0.55      |
| 2          | 1          | start         | 2.5       | 1          | 0          | start         | 0.55      |
| 2          | 0          | end           | 4.512     | 1          | 0          | start         | 0.55      |
| 2          | 0          | start         | 4.1       | 1          | 0          | start         | 0.55      |
| 1          | 1          | end           | 1.42      | 1          | 0          | start         | 0.55      |
| 1          | 1          | start         | 0.43      | 1          | 0          | start         | 0.55      |
| 1          | 0          | end           | 1.55      | 1          | 0          | start         | 0.55      |
| 1          | 0          | start         | 0.55      | 1          | 0          | start         | 0.55      |
| 0          | 1          | end           | 4.12      | 1          | 0          | start         | 0.55      |
| 0          | 1          | start         | 3.14      | 1          | 0          | start         | 0.55      |
| 0          | 0          | end           | 1.52      | 1          | 0          | start         | 0.55      |
| 0          | 0          | start         | 0.712     | 1          | 0          | start         | 0.55      |
| 2          | 1          | end           | 5         | 1          | 0          | end           | 1.55      |
| 2          | 1          | start         | 2.5       | 1          | 0          | end           | 1.55      |
| 2          | 0          | end           | 4.512     | 1          | 0          | end           | 1.55      |
| 2          | 0          | start         | 4.1       | 1          | 0          | end           | 1.55      |
| 1          | 1          | end           | 1.42      | 1          | 0          | end           | 1.55      |
| 1          | 1          | start         | 0.43      | 1          | 0          | end           | 1.55      |
| 1          | 0          | end           | 1.55      | 1          | 0          | end           | 1.55      |
| 1          | 0          | start         | 0.55      | 1          | 0          | end           | 1.55      |
| 0          | 1          | end           | 4.12      | 1          | 0          | end           | 1.55      |
| 0          | 1          | start         | 3.14      | 1          | 0          | end           | 1.55      |
| 0          | 0          | end           | 1.52      | 1          | 0          | end           | 1.55      |
| 0          | 0          | start         | 0.712     | 1          | 0          | end           | 1.55      |
| 2          | 1          | end           | 5         | 1          | 1          | start         | 0.43      |
| 2          | 1          | start         | 2.5       | 1          | 1          | start         | 0.43      |
| 2          | 0          | end           | 4.512     | 1          | 1          | start         | 0.43      |
| 2          | 0          | start         | 4.1       | 1          | 1          | start         | 0.43      |
| 1          | 1          | end           | 1.42      | 1          | 1          | start         | 0.43      |
| 1          | 1          | start         | 0.43      | 1          | 1          | start         | 0.43      |
| 1          | 0          | end           | 1.55      | 1          | 1          | start         | 0.43      |
| 1          | 0          | start         | 0.55      | 1          | 1          | start         | 0.43      |
| 0          | 1          | end           | 4.12      | 1          | 1          | start         | 0.43      |
| 0          | 1          | start         | 3.14      | 1          | 1          | start         | 0.43      |
| 0          | 0          | end           | 1.52      | 1          | 1          | start         | 0.43      |
| 0          | 0          | start         | 0.712     | 1          | 1          | start         | 0.43      |
| 2          | 1          | end           | 5         | 1          | 1          | end           | 1.42      |
| 2          | 1          | start         | 2.5       | 1          | 1          | end           | 1.42      |
| 2          | 0          | end           | 4.512     | 1          | 1          | end           | 1.42      |
| 2          | 0          | start         | 4.1       | 1          | 1          | end           | 1.42      |
| 1          | 1          | end           | 1.42      | 1          | 1          | end           | 1.42      |
| 1          | 1          | start         | 0.43      | 1          | 1          | end           | 1.42      |
| 1          | 0          | end           | 1.55      | 1          | 1          | end           | 1.42      |
| 1          | 0          | start         | 0.55      | 1          | 1          | end           | 1.42      |
| 0          | 1          | end           | 4.12      | 1          | 1          | end           | 1.42      |
| 0          | 1          | start         | 3.14      | 1          | 1          | end           | 1.42      |
| 0          | 0          | end           | 1.52      | 1          | 1          | end           | 1.42      |
| 0          | 0          | start         | 0.712     | 1          | 1          | end           | 1.42      |
| 2          | 1          | end           | 5         | 2          | 0          | start         | 4.1       |
| 2          | 1          | start         | 2.5       | 2          | 0          | start         | 4.1       |
| 2          | 0          | end           | 4.512     | 2          | 0          | start         | 4.1       |
| 2          | 0          | start         | 4.1       | 2          | 0          | start         | 4.1       |
| 1          | 1          | end           | 1.42      | 2          | 0          | start         | 4.1       |
| 1          | 1          | start         | 0.43      | 2          | 0          | start         | 4.1       |
| 1          | 0          | end           | 1.55      | 2          | 0          | start         | 4.1       |
| 1          | 0          | start         | 0.55      | 2          | 0          | start         | 4.1       |
| 0          | 1          | end           | 4.12      | 2          | 0          | start         | 4.1       |
| 0          | 1          | start         | 3.14      | 2          | 0          | start         | 4.1       |
| 0          | 0          | end           | 1.52      | 2          | 0          | start         | 4.1       |
| 0          | 0          | start         | 0.712     | 2          | 0          | start         | 4.1       |
| 2          | 1          | end           | 5         | 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.5       | 2          | 0          | end           | 4.512     |
| 2          | 0          | end           | 4.512     | 2          | 0          | end           | 4.512     |
| 2          | 0          | start         | 4.1       | 2          | 0          | end           | 4.512     |
| 1          | 1          | end           | 1.42      | 2          | 0          | end           | 4.512     |
| 1          | 1          | start         | 0.43      | 2          | 0          | end           | 4.512     |
| 1          | 0          | end           | 1.55      | 2          | 0          | end           | 4.512     |
| 1          | 0          | start         | 0.55      | 2          | 0          | end           | 4.512     |
| 0          | 1          | end           | 4.12      | 2          | 0          | end           | 4.512     |
| 0          | 1          | start         | 3.14      | 2          | 0          | end           | 4.512     |
| 0          | 0          | end           | 1.52      | 2          | 0          | end           | 4.512     |
| 0          | 0          | start         | 0.712     | 2          | 0          | end           | 4.512     |
| 2          | 1          | end           | 5         | 2          | 1          | start         | 2.5       |
| 2          | 1          | start         | 2.5       | 2          | 1          | start         | 2.5       |
| 2          | 0          | end           | 4.512     | 2          | 1          | start         | 2.5       |
| 2          | 0          | start         | 4.1       | 2          | 1          | start         | 2.5       |
| 1          | 1          | end           | 1.42      | 2          | 1          | start         | 2.5       |
| 1          | 1          | start         | 0.43      | 2          | 1          | start         | 2.5       |
| 1          | 0          | end           | 1.55      | 2          | 1          | start         | 2.5       |
| 1          | 0          | start         | 0.55      | 2          | 1          | start         | 2.5       |
| 0          | 1          | end           | 4.12      | 2          | 1          | start         | 2.5       |
| 0          | 1          | start         | 3.14      | 2          | 1          | start         | 2.5       |
| 0          | 0          | end           | 1.52      | 2          | 1          | start         | 2.5       |
| 0          | 0          | start         | 0.712     | 2          | 1          | start         | 2.5       |
| 2          | 1          | end           | 5         | 2          | 1          | end           | 5         |
| 2          | 1          | start         | 2.5       | 2          | 1          | end           | 5         |
| 2          | 0          | end           | 4.512     | 2          | 1          | end           | 5         |
| 2          | 0          | start         | 4.1       | 2          | 1          | end           | 5         |
| 1          | 1          | end           | 1.42      | 2          | 1          | end           | 5         |
| 1          | 1          | start         | 0.43      | 2          | 1          | end           | 5         |
| 1          | 0          | end           | 1.55      | 2          | 1          | end           | 5         |
| 1          | 0          | start         | 0.55      | 2          | 1          | end           | 5         |
| 0          | 1          | end           | 4.12      | 2          | 1          | end           | 5         |
| 0          | 1          | start         | 3.14      | 2          | 1          | end           | 5         |
| 0          | 0          | end           | 1.52      | 2          | 1          | end           | 5         |
| 0          | 0          | start         | 0.712     | 2          | 1          | end           | 5         |

Εχω περιττη πληροφορια. Θελω να κρατησω τις γραμμες που εχουν ιδιο machine_id και ταυτοχρονα να εχουν ιδιο process_id και απλα να αλλαζει το activity_type και το timestamp. Ετσι θα αναφερομαι στην ιδια διεργασια και σε 1 γραμμη θα εχω πληροφοριες τοσο για το ποτε αρχισε οσο και για το ποτε τελειωσε.

Παμε να δουμε το query:

select *
from Activity as a join Activity as b on a.machine_id = b.machine_id and a.process_id = b.process_id and a.activity_type = 'start' and b.activity_type = 'end'

Αποτελεσμα:


| machine_id | process_id | activity_type | timestamp | machine_id | process_id | activity_type | timestamp |
| ---------- | ---------- | ------------- | --------- | ---------- | ---------- | ------------- | --------- |
| 0          | 0          | start         | 0.712     | 0          | 0          | end           | 1.52      |
| 0          | 1          | start         | 3.14      | 0          | 1          | end           | 4.12      |
| 1          | 0          | start         | 0.55      | 1          | 0          | end           | 1.55      |
| 1          | 1          | start         | 0.43      | 1          | 1          | end           | 1.42      |
| 2          | 0          | start         | 4.1       | 2          | 0          | end           | 4.512     |
| 2          | 1          | start         | 2.5       | 2          | 1          | end           | 5         |

Αρα τωρα ξερω οτι εχω 3 μηχανες που στην καθε μηχανη τρεχουν συνολικα 2 διεργασιες. Τωρα θελω να ξερω τον μεσο ορο που κανουν οι διεργασιες να τρεξουν σε καθε μηχανημα.
Αρα πρεπει να ομαδοποιησω με βαση τα μηχανηματα. Ταυτοχρονα αφου εχω κανει ομαδοποιηση, για καθε εγγραφη του καθε μηχανηματος, θα κανω αφαιρεση για να δω ποσο χρονο κανει η καθε διεργασια για να τρεξει στο καθε μηχανημα.
Παραλληλα θα αθροισω αυτα τα αποτελεσματα και θα διαιρεσω με τον συνολικο αριθμο των διεργασιων που υπαρχουν σε καθε μηχανημα. Επισης θελω στρογγυλοποιηση 3 ψηφιων.
*/

# Write your MySQL query statement below

select a.machine_id, round(sum(b.timestamp - a.timestamp) / count(a.process_id), 3) as processing_time
from Activity as a join Activity as b on a.machine_id = b.machine_id and a.process_id = b.process_id and a.activity_type = 'start' and b.activity_type = 'end'
group by a.machine_id

--Αρα εδω ας πουμε οτι ομαδοποιησα τις εγγραφες βασει του a.machine_id. Αρα δημιουργηθηκαν ομαδες εγγραφων. Το dbms παει και βλεπει για καθε εγγραφη που εχω σε ποια ομαδα ανηκει και παιρνει την διαφορα b.timestamp-a.timestamp. 
--πχ για τον πινακα εδω:
--Για την ομαδα με machine_id 0
--Βλεπει οτι η πρωτη εγγραφη εχει a.machine_id ισο με 0 αρα η εγγραφη ανηκει στην ομαδα. Κανει την αφαιρεση. Παει στην δευτερη εγγραφη. Βλεπει οτι ανηκει και αυτη στην ομαδα οποτε κανει την αφαιρεση. Μετα προσθετει αυτα τα αποτελεσματα και τα διαιρει με τον συνολικο αριθμο διεργασιων. Αυτη η ομαδα εχει 2 διεργασιες αρα διαιρει με το 2.

--Για καθε ομαδα που εχει προσθετει αυτα τα αποτελεσματα και τελος διαιρει το αποτελεσμα με τον συνολικο αριθμο διεργασιων που εχει το καθε μηχανημα. Αρα βασει της ομαδοποιησης παει και βλεπει καθε ομαδα ποσα διαφορετικα process_id εχει.


--Other Solution:

select a.machine_id, round(avg(b.timestamp - a.timestamp), 3) as processing_time
from Activity as a join Activity as b on a.machine_id = b.machine_id and a.process_id = b.process_id and a.activity_type = 'start' and b.activity_type = 'end'
group by a.machine_id



