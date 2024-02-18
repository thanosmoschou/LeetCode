/*
Given an integer x, return true if x is a palindrome, and false otherwise.


Example 1:

Input: x = 121
Output: true
Explanation: 121 reads as 121 from left to right and from right to left.

Example 2:

Input: x = -121
Output: false
Explanation: From left to right, it reads -121. From right to left, it becomes 121-. Therefore it is not a palindrome.

Example 3:

Input: x = 10
Output: false
Explanation: Reads 01 from right to left. Therefore it is not a palindrome.
 

Constraints:

-231 <= x <= 231 - 1
 

Follow up: Could you solve it without converting the integer to a string?


My Solution:

Let's assume that we have a struct in order to define bool
*/


bool isPalindrome(int x)
{
    if(x < 0)
    {
        return false;
    }

    int tmp = x, digits = 0, nums[10]; //digits works both as an index to my array and total digits of the input number

    while(tmp != 0)
    {
        nums[digits] = tmp % 10;
        digits++;
        tmp = tmp / 10;
    }

    for(int i = 0; i < digits / 2; i++)
    {
        if(nums[i] != nums[digits - i - 1])
            return false;
    }

    return true;
}
