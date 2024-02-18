/*
Given an integer array nums sorted in non-decreasing order, remove the duplicates in-place such that each unique element appears only once. The relative order of the elements should be kept the same. Then return the number of unique elements in nums.

Consider the number of unique elements of nums to be k, to get accepted, you need to do the following things:

Change the array nums such that the first k elements of nums contain the unique elements in the order they were present in nums initially. The remaining elements of nums are not important as well as the size of nums.
Return k.
Custom Judge:

The judge will test your solution with the following code:

int[] nums = [...]; // Input array
int[] expectedNums = [...]; // The expected answer with correct length

int k = removeDuplicates(nums); // Calls your implementation

assert k == expectedNums.length;
for (int i = 0; i < k; i++) {
    assert nums[i] == expectedNums[i];
}
If all assertions pass, then your solution will be accepted.

Example 1:

Input: nums = [1,1,2]
Output: 2, nums = [1,2,_]
Explanation: Your function should return k = 2, with the first two elements of nums being 1 and 2 respectively.
It does not matter what you leave beyond the returned k (hence they are underscores).
Example 2:

Input: nums = [0,0,1,1,1,2,2,3,3,4]
Output: 5, nums = [0,1,2,3,4,_,_,_,_,_]
Explanation: Your function should return k = 5, with the first five elements of nums being 0, 1, 2, 3, and 4 respectively.
It does not matter what you leave beyond the returned k (hence they are underscores).
 

Constraints:

1 <= nums.length <= 3 * 104
-100 <= nums[i] <= 100
nums is sorted in non-decreasing order.

My Solution:
*/

class Solution {
    public int removeDuplicates(int[] nums) {
        HashSet<Integer> unique = new HashSet<Integer>();
        int k = 0;

        for(int n: nums)
        {
            if(!unique.contains(n))
            {
                unique.add(n);
                nums[k++] = n;
            }
        }
        
        return k;

    }
}

/*

Let's see an example:

nums = [1,1,0,2]
hashset = {}
k = 0

1st iteration:
n = 1
It is not inside the hashset
Add it
hashset = {1}
Now put it at the beginning of the array
nums[k++] = n (k is returned as 0 and then it is increased to 1 so the next unique element will be placed at index 1)

2nd iteration:
n = 1
It is inside the hashset so we move on

3rd iteration:
n = 0
It is not inside the hashset
Add it
hashset = {1, 0}
Now put it at the right position in the array
nums[k++] = n (k is returned as 1 and is increased to 2)

and so on...

To sum up:
We use a hash set to keep track of all the unique items of the array and we have a counter that is returned at the end but also works
as an index to put the unique elements at the beginning of the array.
*/