/*
Write a function to find the longest common prefix string amongst an array of strings.

If there is no common prefix, return an empty string "".


Example 1:

Input: strs = ["flower","flow","flight"]
Output: "fl"

Example 2:

Input: strs = ["dog","racecar","car"]
Output: ""
Explanation: There is no common prefix among the input strings.
 

Constraints:

1 <= strs.length <= 200
0 <= strs[i].length <= 200
strs[i] consists of only lowercase English letters.


My Solution:
*/

char *longestCommonPrefix(char ** strs, int strsSize)
{
    //char strs[] is a char array
    //char *strs is a pointer to a string
    //char *strs[] is an array of pointers to a string
    //I know that the name of an array is a pointer to its first element so char *strs[] is equal to 
    //char **strs

    if(strsSize < 1) //empty input array
        return "";
    else if(strsSize == 1) //the array has only one element
        return strs[0];
    
    char *prefix = (char *)calloc(201, sizeof(char)); //one extra place for \0
    int ctr = 0; //index for the heap memory

    if(prefix == NULL) //something went wrong with calloc
        return "";

    //take as fix word the first one and compare its letters with the letters of all the next words
    for(int j = 0; j < strlen(strs[0]); j++)
    {
        for(int i = 1; i < strsSize; i++)
        {
            //this letter is not contained to all the input words so I need to return
            if(strs[0][j] != strs[i][j]) 
                return prefix;
        }

        //the letter is contained to all input words so I concatenate it to the prefix
        prefix[ctr++] = strs[0][j];
        //ctr++;        
    }
    
    return prefix;
}   
