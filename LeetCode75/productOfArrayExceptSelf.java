/*
Given an integer array nums, return an array answer such that answer[i] is equal to the product of all the elements of nums except nums[i].

The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.

You must write an algorithm that runs in O(n) time and without using the division operation.

Example 1:

Input: nums = [1,2,3,4]
Output: [24,12,8,6]

Example 2:

Input: nums = [-1,1,0,-3,3]
Output: [0,0,9,0,0]
 

Constraints:

2 <= nums.length <= 105
-30 <= nums[i] <= 30
The product of any prefix or suffix of nums is guaranteed to fit in a 32-bit integer.
 

Follow up: Can you solve the problem in O(1) extra space complexity? 
(The output array does not count as extra space for space complexity analysis.)
*/

class Solution 
{
    public int[] productExceptSelf(int[] nums) 
    {
        int[] result = new int[nums.length];
        int product = 1;

        for(int i = 0; i < result.length; i++)
            result[i] = 0;

        /*
         * In each iteration we calculate the product of all numbers before the i position. Then we update the product
         * by multiplying the current product with the number in i position of the nums array in order to place this
         * product to the next position of the result array.
         * 
         * Then we traverse the nums array from right to left but now we update the current product in each place of the
         * result array by multiplying the existing product with the product of all numbers after the i position.
         */
        for(int i = 0; i < nums.length; i++)
        {
            result[i] = product;
            product *= nums[i];
        }

        product = 1;
        for(int i = nums.length - 1; i >= 0; i--)
        {
            result[i] *= product;
            product *= nums[i];
        }

        return result;
    }
}
