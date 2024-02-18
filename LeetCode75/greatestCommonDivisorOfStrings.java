// For two strings s and t, we say "t divides s" if and only if s = t + t + t + ... + t + t (i.e., t is concatenated with itself one or more times).

// Given two strings str1 and str2, return the largest string x such that x divides both str1 and str2.

 

// Example 1:

// Input: str1 = "ABCABC", str2 = "ABC"
// Output: "ABC"
// Example 2:

// Input: str1 = "ABABAB", str2 = "ABAB"
// Output: "AB"
// Example 3:

// Input: str1 = "LEET", str2 = "CODE"
// Output: ""
 

// Constraints:

// 1 <= str1.length, str2.length <= 1000
// str1 and str2 consist of English uppercase letters.

class Solution 
{
    public String gcdOfStrings(String str1, String str2) 
    {
        //Take the smallest word as an initial gcd because it may divide both of them.
        String gcdAsAString = (str1.length() < str2.length()) ? str1 : str2, tmpMsg;
        boolean fit1 = true, fit2 = true;

        while(gcdAsAString.length() > 0)
        {
            tmpMsg = "";
            
            //Concatenate the gcd with itself to create a new message
            //until the length becomes equal or greater than the word
            //you want to test.
            //Then check if the created message is equal with the tested string
            //If everything goes well check the other string, otherwise delete the last letter
            //from the gcd in order to find a new one. I continue this procedure until I find
            //a mathing gcd for both strings or its length is greater than 0
            while(tmpMsg.length() < str1.length())
                tmpMsg += gcdAsAString;
            
            if(!tmpMsg.equals(str1))
            {
                fit1 = false;
                gcdAsAString = gcdAsAString.substring(0, gcdAsAString.length() - 1); //it goes up to -2 so I remove the last character
                continue; //if it does not fit this word there is no reason to check if it fits with the other one
            }
            else
                fit1 = true;
            
            tmpMsg = "";

            while(tmpMsg.length() < str2.length())
                tmpMsg += gcdAsAString;
            
            if(!tmpMsg.equals(str2))
            {
                fit2 = false;
                gcdAsAString = gcdAsAString.substring(0, gcdAsAString.length() - 1);
            }
            else
                fit2 = true;

            if(fit1 && fit2)
                return gcdAsAString;
        }

        return gcdAsAString;
    }
}

/*
This code sample from leetcode is better:
 class Solution {
        public String gcdOfStrings(String str1, String str2) {
            if (!(str1 + str2).equals(str2 + str1)) {
                return "";
            }
            return str1.substring(0, gcd(str1.length(), str2.length()));
        }

        private int gcd(int a, int b) {
            return b == 0 ? a : gcd(b, a % b);
        }
    }

 It takes the length of the 2 strings, finds the gcd of these lengths and returns the substring
 from 0 to gcd

 */