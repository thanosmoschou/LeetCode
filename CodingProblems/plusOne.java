/*
You are given a large integer represented as an integer array digits, where each digits[i] is the ith digit of the integer. The digits are ordered from most significant to least significant in left-to-right order. The large integer does not contain any leading 0's.

Increment the large integer by one and return the resulting array of digits.

Example 1:

Input: digits = [1,2,3]
Output: [1,2,4]
Explanation: The array represents the integer 123.
Incrementing by one gives 123 + 1 = 124.
Thus, the result should be [1,2,4].
Example 2:

Input: digits = [4,3,2,1]
Output: [4,3,2,2]
Explanation: The array represents the integer 4321.
Incrementing by one gives 4321 + 1 = 4322.
Thus, the result should be [4,3,2,2].
Example 3:

Input: digits = [9]
Output: [1,0]
Explanation: The array represents the integer 9.
Incrementing by one gives 9 + 1 = 10.
Thus, the result should be [1,0].
 

Constraints:

1 <= digits.length <= 100
0 <= digits[i] <= 9
digits does not contain any leading 0's.

My Solution:
*/

class Solution {
    public int[] plusOne(int[] digits) {

        int remain = 0;

        //increase the last element. If it becomes 10 (because it was 9) I make it 0 and save 
        //a remainder of 1 for the next digits element
        digits[digits.length - 1]++;

        if(digits[digits.length - 1] == 10)
        {
            digits[digits.length - 1] = 0;
            remain = 1;
        }

        //check the remaining elements of the array (array is a pointer to the elements in the memory...it does not copy the values inside the method so I can modify it inside my method)
        //if I have a remainder then I add it to the current digits element and make the remainder 0.
        //Then I check again if the element is a 10 and if it is I make it 0 and save a remainder of 1 for the next element
        for(int i = digits.length - 2; i >= 0; i--)
        {
            if(remain == 1)
            {
                digits[i] += remain;
                remain = 0;
            }

            if(digits[i] == 10)
            {
                digits[i] = 0;
                remain = 1;
            }
        }

        //if the remainder is 1 at the end of the loop then the first digit of the number became 0 so I need
        //a bigger array (1 position more) to place the remainder of 1 at the beginning of the array
        //else I will return the address of the already modified array
        if(remain == 1)
        {
            int[] nums = new int[digits.length + 1];
            int ctr = 1;

            nums[0] = remain;

            for(int i = 0; i < digits.length; i++)
            {
                nums[ctr] = digits[i];
                ctr++;
            }

            return nums;
        }
        else
            return digits;
    }
}