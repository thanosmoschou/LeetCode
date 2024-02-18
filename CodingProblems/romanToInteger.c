/*
Roman numerals are represented by seven different symbols: I, V, X, L, C, D and M.

Symbol       Value
I             1
V             5
X             10
L             50
C             100
D             500
M             1000

For example, 2 is written as II in Roman numeral, just two ones added together. 12 is written as XII, which is simply X + II. The number 27 is written as XXVII, which is XX + V + II.

Roman numerals are usually written largest to smallest from left to right. However, the numeral for four is not IIII. Instead, the number four is written as IV. Because the one is before the five we subtract it making four. The same principle applies to the number nine, which is written as IX. There are six instances where subtraction is used:

I can be placed before V (5) and X (10) to make 4 and 9. 
X can be placed before L (50) and C (100) to make 40 and 90. 
C can be placed before D (500) and M (1000) to make 400 and 900.
Given a roman numeral, convert it to an integer.

 

Example 1:

Input: s = "III"
Output: 3
Explanation: III = 3.

Example 2:

Input: s = "LVIII"
Output: 58
Explanation: L = 50, V= 5, III = 3.

Example 3:

Input: s = "MCMXCIV"
Output: 1994
Explanation: M = 1000, CM = 900, XC = 90 and IV = 4.
 

Constraints:

1 <= s.length <= 15
s contains only the characters ('I', 'V', 'X', 'L', 'C', 'D', 'M').
It is guaranteed that s is a valid roman numeral in the range [1, 3999].


My Solution:
*/

int romanToInt(char * s)
{
    int total = 0;
    char tmp;

    for(int i = 0; i < strlen(s); i++)
    {
        tmp = s[i];
	//You may think that s[i + 1] will exceed the array limits when i reaches the last position. The answer here is short circuit evaluation. My array in the last place has a terminate character that does equal to 'I' so the expression is false from the beginning and compiler does not check the next part of the expression 
        if(tmp == 'I' && s[i + 1] == 'V')
        {
            total += 4;
            i++; //I increase the i both here and before my next loop. As a result it will be increased 2 times, skipping the next letter
            continue;
        }
        else if(tmp == 'I' && s[i + 1] == 'X')
        {
            total += 9;
            i++;
            continue;
        }
        else if(tmp == 'I') //I check the chance of being just a single I at the end
        {
            total++;
            continue;
        }

        if(tmp == 'X' && s[i + 1] == 'L')
        {
            total += 40;
            i++;
            continue;
        }
        else if(tmp == 'X' && s[i + 1] == 'C')
        {
            total += 90;
            i++;
            continue;
        }
        else if(tmp == 'X')
        {
            total += 10;
            continue;
        }

        if(tmp == 'C' && s[i + 1] == 'D')
        {
            total += 400;
            i++;
            continue;
        }
        else if(tmp == 'C' && s[i + 1] == 'M')
        {
            total += 900;
            i++;
            continue;
        }
        else if(tmp == 'C')
        {
            total += 100;
            continue;
        }


        if(tmp == 'V')
            total += 5;
        else if(tmp == 'L')
            total += 50;
        else if(tmp == 'D')
            total += 500;
        else
            total += 1000;

    
    }

    return total;
}
