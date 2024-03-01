/*
Given an integer array nums, move all 0's to the end of it while maintaining the relative order of the non-zero elements.

Note that you must do this in-place without making a copy of the array.

Example 1:

Input: nums = [0,1,0,3,12]
Output: [1,3,12,0,0]

Example 2:

Input: nums = [0]
Output: [0]
 

Constraints:

1 <= nums.length <= 104
-231 <= nums[i] <= 231 - 1
 

Follow up: Could you minimize the total number of operations done?
*/

class Solution 
{
    public void moveZeroes(int[] nums) 
    {
        int ctr;

        for(int i = 0; i < nums.length; i++)
        {
            ctr = indexOfFirstNonZeroElement(i + 1, nums);

            if(ctr < i) //all the non zero elements are before 0's'
                break;

            if(nums[i] == 0)
            {
                nums[i] = nums[ctr];
                nums[ctr] = 0;
            }
        }
    }

    private int indexOfFirstNonZeroElement(int start, int[] nums)
    {
        for(int i = start; i < nums.length; i++)
            if(nums[i] != 0)
                return i;
        return 0;
    }
}