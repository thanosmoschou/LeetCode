/*
Given two binary strings a and b, return their sum as a binary string.

Example 1:

Input: a = "11", b = "1"
Output: "100"
Example 2:

Input: a = "1010", b = "1011"
Output: "10101"
 

Constraints:

1 <= a.length, b.length <= 104
a and b consist only of '0' or '1' characters.
Each string does not contain leading zeros except for the zero itself.

My Solution:

First I tried converting the binary strings to integers, then add those integers together and convert the sum back to a binary string
but it did not worked for very large numbers due to overflow.

My approach was to apply the basic add rules for binary numbers:
*/

class Solution {
    public String addBinary(String a, String b) {

        int ctr1 = a.length() - 1, ctr2 = b.length() - 1, remain = 0;
        String sum = "";
        char cur1, cur2;

        while(ctr1 >= 0 && ctr2 >= 0)
        {
            cur1 = a.charAt(ctr1);
            cur2 = b.charAt(ctr2);
            
            if((cur1 == '0' && cur2 == '0') && remain == 0)
            {
                sum = "0" + sum;
            }
            else if((cur1 == '0' && cur2 == '0') && remain == 1)
            {
                sum = "1" + sum;
                remain = 0;
            }
            else if(((cur1 == '0' && cur2 == '1') || (cur1 == '1' && cur2 == '0')) && remain == 0)
            {
                sum = "1" + sum;
            }
            else if(((cur1 == '0' && cur2 == '1') || (cur1 == '1' && cur2 == '0')) && remain == 1)
            {
                sum = "0" + sum;
                remain = 1;
            }
            else if((cur1 == '1' && cur2 == '1') && remain == 0)
            {
                sum = "0" + sum;
                remain = 1;
            }
            else if((cur1 == '1' && cur2 == '1') && remain == 1)
            {
                sum = "1" + sum;
                remain = 1;
            }

            ctr1--;
            ctr2--;
        }

        while(ctr1 >= 0) //b string was smaller so it finished first and I have remaining digits in a string
        {
            cur1 = a.charAt(ctr1);

            if(remain == 0)
            {
                if(cur1 == '0')
                {
                    sum = "0" + sum;
                }
                else
                {
                    sum = "1" + sum;
                }
            }
            else
            {
                if(cur1 == '0')
                {
                    sum = "1" + sum;
                    remain = 0;
                }
                else
                {
                    sum = "0" + sum;
                    remain = 1;
                }
            }

            ctr1--;
        }

	//do the same for b string if a string was smaller
        while(ctr2 >= 0) 
        {
            cur2 = b.charAt(ctr2);
            
            if(remain == 0)
            {
                if(cur2 == '0')
                {
                    sum = "0" + sum;
                }
                else
                {
                    sum = "1" + sum;
                }
            }
            else
            {
                if(cur2 == '0')
                {
                    sum = "1" + sum;
                    remain = 0;
                }
                else
                {
                    sum = "0" + sum;
                    remain = 1;
                }
            }

            ctr2--;
        }

        if(remain == 1) //check if there is a remainder left at the end
            sum = "1" + sum;

        return sum;
   
    }
}


/*
//This is kinda slow due to all those conditions.

//Here is another solution from a user in leetcode which I liked:

class Solution {
    public String addBinary(String a, String b) {
        int length = Math.max(a.length(), b.length());
        StringBuffer result = new StringBuffer();

        int unitFromLastDegree = 0;
        for (int i = a.length() - 1, z = b.length() - 1; length > 0; i--, z--, length--) {
            int x = (i >= 0) ? Character.getNumericValue(a.charAt(i)) : 0;
            int y = (z >= 0) ? Character.getNumericValue(b.charAt(z)) : 0;

            int localSum = unitFromLastDegree + x + y;
            result.append(localSum%2);
            unitFromLastDegree = localSum/2;
        }
        if(unitFromLastDegree == 1) result.append("1");

        return result.reverse().toString();
    }
}


It uses StringBuffer which is an alternative to String. The difference is that String is immutable. This means that I cannot modify its contents and I have to create a new object.

This user gets the max length of those 2 strings, he initializes i (in my solution this was ctr1) and z (ctr2 in my solution) and he checks if the bigger word is over (length > 0). Then he checks if i is bigger than 0 so the string has some digits left. If yes then he gets the numeric value of this character, otherwise he passes 0 to the x variable. He does the same for y. Then he adds together x + y plus the remainder from previous calculation. Then he passes to the stringbuffer the modulo of localsum % 2 and as a remainder of this calculation it passes to the remainder variable (unitFromLastDegree) the div result. As you can understand, he tries to convert each time the integer to a binary number (with mod 2 and div 2 just like we convert integers to binaries). Then he returns the reverse string (as you know the convertion from integer to binary keeps the modulos in reverse order so if you want to have the correct number in binary you have to return your result in reverse order).

For example if I have in binary: 1 + 1 (with previous remainder of 0)
he converts those numbers to integers (which are also 1)
so 1 + 1 = 2
In binary I would have 1 + 1 = 10 (which is also 2) so I would keep the 0 and I would take 1 as a remainder.
This is exactly what this user does: 
2 % 2 = 0 so he keeps 0 to the result
2 / 2 = 1 so he keeps 1 as the remainder
*/