/*
Given two strings needle and haystack, return the index of the first occurrence of needle in haystack, or -1 if needle is not part of haystack.

 

Example 1:

Input: haystack = "sadbutsad", needle = "sad"
Output: 0
Explanation: "sad" occurs at index 0 and 6.
The first occurrence is at index 0, so we return 0.
Example 2:

Input: haystack = "leetcode", needle = "leeto"
Output: -1
Explanation: "leeto" did not occur in "leetcode", so we return -1.
 

Constraints:

1 <= haystack.length, needle.length <= 104
haystack and needle consist of only lowercase English characters.


My Solution:
*/

int strStr(char * haystack, char * needle)
{
    int index, isSame;

    //the length of haystack is smaller than needle so there is not a substring
    if(strlen(haystack) < strlen(needle))
        return -1;

    for(int i = 0; i < strlen(haystack); i++)
    {
        //if the current letter of haystack is equal to the first letter of needle
        //I can continue and check if the rest letters of needle
        //match to the corresponding letters of haystack. Otherwise if the first letter
        //of needle is not equal to the current letter of haystack, then
        //it is useless to continue checking for the next letters of needle.
        
        if(haystack[i] == needle[0])
        {
            index = i; //index of the substring index.
            isSame = 1;
            i++; //move to the next letter of haystack
        }
        else
            continue;


        for(int j = 1; j < strlen(needle); j++)
        {            
            if(haystack[i] != needle[j])
            {
                isSame = 0;
                break;
            }
            else
                i++; //move to the next letter of haystack
        }

        //if the nested loop ends successfully, then all letters of needle match
        //some letters of haystack in sequential order. This means I found the first 
        //occurence of needle inside the haystack.

        /*
        index is the first letter of haystack that is equal to the first needle letter
        If there is finally not a match, I will continue with the next letter after the
        letter specified by the index variable

        For example:
        Haystack: leetcode
        Needle: leeto

        I will check: l with l and save the index to 0, e with e, e with e, t with t, c with o
        There is finally not a match. But I will not continue from letter c in leetcode.
        I need to go from index + 1 which is e and see if there is a substring in the rest of the word
        */
        
        if(isSame)
            return index;
        else
            i = index; //i will be increased in the next outside loop
    }

    return -1;
}


//Another user's solution:

int strStr(char * haystack, char * needle){
if (*needle == '\0') {
        return 0;  // If needle is empty, it's always found at index 0
    }

    int haystackLen = strlen(haystack);
    int needleLen = strlen(needle);

    for (int i = 0; i <= haystackLen - needleLen; ++i) {
        if (strncmp(&haystack[i], needle, needleLen) == 0) {
            return i;
        }
    }

    return -1;  // Needle not found

};