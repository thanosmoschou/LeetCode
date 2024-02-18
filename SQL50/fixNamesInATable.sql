/*
Table: Users

+----------------+---------+
| Column Name    | Type    |
+----------------+---------+
| user_id        | int     |
| name           | varchar |
+----------------+---------+
user_id is the primary key (column with unique values) for this table.
This table contains the ID and the name of the user. The name consists of only lowercase and uppercase characters.
 

Write a solution to fix the names so that only the first character is uppercase and the rest are lowercase.

Return the result table ordered by user_id.

The result format is in the following example.

 

Example 1:

Input: 
Users table:
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | aLice |
| 2       | bOB   |
+---------+-------+
Output: 
+---------+-------+
| user_id | name  |
+---------+-------+
| 1       | Alice |
| 2       | Bob   |
+---------+-------+

My Solution:
*/

# Write your MySQL query statement below
select user_id, concat(upper(substr(name, 1, 1)), lower(substr(name, 2))) as name
from Users
order by user_id

/*
Info:

The SUBSTR() function extracts a substring from a string (starting at any position).

Note: The SUBSTR() and MID() functions equals to the SUBSTRING() function.

Syntax

SUBSTR(string, start, length)

OR:

SUBSTR(string FROM start FOR length)

Parameter Values
Parameter	Description
string		Required. The string to extract from
start		Required. The start position. Can be both a positive or negative number. If it is a positive number, this function extracts from the beginning of the string. If it is a negative number, this function extracts from the end of the string
length		Optional. The number of characters to extract. If omitted, the whole string will be returned (from the start position)
*/