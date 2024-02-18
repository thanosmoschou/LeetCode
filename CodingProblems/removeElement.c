/*
Given an integer array nums and an integer val, remove all occurrences of val in nums in-place. The order of the elements may be changed. Then return the number of elements in nums which are not equal to val.

Consider the number of elements in nums which are not equal to val be k, to get accepted, you need to do the following things:

Change the array nums such that the first k elements of nums contain the elements which are not equal to val. The remaining elements of nums are not important as well as the size of nums.
Return k.

Custom Judge:

The judge will test your solution with the following code:

int[] nums = [...]; // Input array
int val = ...; // Value to remove
int[] expectedNums = [...]; // The expected answer with correct length.
                            // It is sorted with no values equaling val.

int k = removeElement(nums, val); // Calls your implementation

assert k == expectedNums.length;
sort(nums, 0, k); // Sort the first k elements of nums
for (int i = 0; i < actualLength; i++) {
    assert nums[i] == expectedNums[i];
}

If all assertions pass, then your solution will be accepted.

 

Example 1:

Input: nums = [3,2,2,3], val = 3
Output: 2, nums = [2,2,_,_]
Explanation: Your function should return k = 2, with the first two elements of nums being 2.
It does not matter what you leave beyond the returned k (hence they are underscores).

Example 2:

Input: nums = [0,1,2,2,3,0,4,2], val = 2
Output: 5, nums = [0,1,4,0,3,_,_,_]
Explanation: Your function should return k = 5, with the first five elements of nums containing 0, 0, 1, 3, and 4.
Note that the five elements can be returned in any order.
It does not matter what you leave beyond the returned k (hence they are underscores).
 

Constraints:

0 <= nums.length <= 100
0 <= nums[i] <= 50
0 <= val <= 100


My Solution:
*/

void swap(int *a, int *b)
{
    int tmp;
    
    tmp = *a;
    *a = *b;
    *b = tmp;
}

int findIndexOfLastDifferentElement(int *nums, int numsSize, int val)
{
    for(int i = numsSize - 1; i >= 0; i--)
        if(nums[i] != val)
            return i;
    
    return 0;
}

int removeElement(int* nums, int numsSize, int val)
{
    int currentIndex, totalRemoveVal = 0, removed = 0;

    //find the total amount of elements I want to remove
    for(int i = 0; i < numsSize; i++)
        if(nums[i] == val)
            totalRemoveVal++;
    
    int i = 0, endIndex;

    while(removed < totalRemoveVal)
    {
        endIndex = findIndexOfLastDifferentElement(nums, numsSize, val);

        //if endIndex is smaller than i, the last element of the array which is not equal to val (specified by the endIndex), is before the elements I want to remove so I can stop because I placed all the elements I want to remove, at the end of the array.
        
        if(endIndex < i)
            break;
        else if(nums[i] == val)
        {
            swap(&nums[i], &nums[endIndex]); //move the item you want to remove, to the end of the array
            removed++;
        }
       
        i++;
    }

    return numsSize - totalRemoveVal;
}
