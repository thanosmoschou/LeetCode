/*
Given a sorted array of distinct integers and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You must write an algorithm with O(log n) runtime complexity.

Example 1:

Input: nums = [1,3,5,6], target = 5
Output: 2
Example 2:

Input: nums = [1,3,5,6], target = 2
Output: 1
Example 3:

Input: nums = [1,3,5,6], target = 7
Output: 4
 

Constraints:

1 <= nums.length <= 104
-104 <= nums[i] <= 104
nums contains distinct values sorted in ascending order.
-104 <= target <= 104

My Solution:
*/

class Solution {
    public int searchInsert(int[] nums, int target) {
        int i = 0, j = nums.length - 1;
        int mid = (i + j) / 2;

        while(i <= j)
        {
            if(nums[mid] == target)
                return mid;
            else if(nums[mid] > target)
            {
                j = mid - 1;
                mid = (i + j) / 2;
            }
            else
            {
                i = mid + 1;
                mid = (i + j) / 2;
            }

        }

        //if i becomes bigger than j then I do not have some other elements to scan so just return i which is
        //where the target would be placed in the array
        return i; 
    }
}

/*

Let's see an example:
Example 2:

Input: nums = [1,3,5,6], target = 2
Output: 1

1st loop: i = 0, j = 3, mid = (0+3)/2 = 1 -> nums[mid] = 3 > target = 2 so i stays the same and j = mid - 1 = 1 - 1 = 0
2nd loop: i = 0, j = 0, mid = 0 -> nums[mid] = 1 < target = 2 so i = mid + 1 = 0 + 1 = 1 and j stays the same
3rd loop: i is bigger than j so it will not run a third loop

Now i is bigger than j so 1 is the position where target should be placed in this sorted array. In binary search I always cut the array to the half and scan the one part. The iteration will stop when i becomes bigger than j which means that I cannot cut the array anymore. Now that i is bigger than j, i is the position where the target should be placed because when i is equal to j, it is the last element of the array that I can scan. So if this last value is bigger than target, then j is decreased and i is bigger than j and it shows where the target would be placed. If the last value is smaller than target, then i is increased and i is now bigger than j and again it shows where the target should be placed (the next place after the last element I scanned).
*/