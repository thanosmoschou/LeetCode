/*
Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.

You may assume that each input would have exactly one solution, and you may not use the same element twice.

You can return the answer in any order.


Example 1:

Input: nums = [2,7,11,15], target = 9
Output: [0,1]
Explanation: Because nums[0] + nums[1] == 9, we return [0, 1].

Example 2:

Input: nums = [3,2,4], target = 6
Output: [1,2]

Example 3:

Input: nums = [3,3], target = 6
Output: [0,1]
 

Constraints:

2 <= nums.length <= 104
-109 <= nums[i] <= 109
-109 <= target <= 109
Only one valid answer exists.
 

Follow-up: Can you come up with an algorithm that is less than O(n2) time complexity?

My solution:

*/

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

int* twoSum(int *nums, int numsSize, int target, int *returnSize)
{
    int *returnArray = (int *)malloc(*returnSize * sizeof(int)); //the dimension is specified by the caller
    int ctr = 0;

    for(int i = 0; i < numsSize; i++)
    {
        for(int j = i + 1; j < numsSize; j++)
        {
            if(nums[i] + nums[j] ==  target)
            {
                returnArray[ctr] = i;
                returnArray[++ctr] = j;
                return returnArray; //the exercise wanted an array of 2 numbers
            }  
        }
    }

    return NULL;
}

//A better approach:

/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

int* twoSum(int *nums, int numsSize, int target, int *returnSize)
{
    int *returnArray = (int *) malloc(*returnSize * sizeof(int)); 
    int ctr, fixNumber, complement;

    for(int i = 0; i < numsSize; i++)
    {
        ctr = 0; //reset in every loop because I want an array with 2 positions
        fixNumber = nums[i];
        complement = target - fixNumber;
        returnArray[ctr] = i; //save the index of the fix number to the wanted array
        
        for(int j = i + 1; j < numsSize; j++)
        {
	    //I save time with the complement variable because if I have an equation like nums[i] + nums[j] I need to go to these 	     	    //positions in the nums array (go to memory) in every single loop which is time consuming.
            if(nums[j] == complement) 
            {
                returnArray[++ctr] = j;
                return returnArray;
            }
        }
    }

    return NULL;
}


//I did an approach where I check if compiler allocated memory (In the previous approaches I was getting a lot of runtime errors for inaccessible memory addresses. This means that I was trying to access memory that was not allocated for the program.)


/**
 * Note: The returned array must be malloced, assume caller calls free().
 */

int* twoSum(int *nums, int numsSize, int target, int *returnSize)
{
    int *returnArray = (int *) malloc(*returnSize * sizeof(int)); 
    int ctr, fixNumber, complement;

    if(returnArray != NULL)
    {
        for(int i = 0; i < numsSize - 1; i++)
        {
            ctr = 0;
            fixNumber = nums[i];
            complement = target - fixNumber;
            returnArray[ctr] = i;

            for(int j = i + 1; j < numsSize; j++)
            {
                if(nums[j] == complement)
                {
                    returnArray[++ctr] = j;
                    return returnArray;
                }
            }
        }
    }

    return NULL;
}

