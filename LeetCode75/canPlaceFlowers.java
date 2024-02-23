/*
You have a long flowerbed in which some of the plots are planted, and some are not. However, flowers cannot be planted in adjacent plots.

Given an integer array flowerbed containing 0's and 1's, where 0 means empty and 1 means not empty, and an integer n, return true if n new flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule and false otherwise.

Example 1:

Input: flowerbed = [1,0,0,0,1], n = 1
Output: true

Example 2:

Input: flowerbed = [1,0,0,0,1], n = 2
Output: false

Constraints:

1 <= flowerbed.length <= 2 * 104
flowerbed[i] is 0 or 1.
There are no two adjacent flowers in flowerbed.
0 <= n <= flowerbed.length

*/

class Solution 
{
    public boolean canPlaceFlowers(int[] flowerbed, int n) 
    {
        int flowerCtr = 0, arrayCtr = 0;

        if(flowerbed.length == 1)
        {
            if(flowerbed[0] == 0) //1 or 0 flowers can be planted
                return n <= 1;
            else
                return n == 0;
        }

        while(arrayCtr < flowerbed.length)
        {
            if(flowerbed[arrayCtr] == 1)
            {
                arrayCtr += 2; //we cannot increase it by 1 because we cannot plant a flower in the next plot due to the fact that it is adjacent
                continue;
            }
            else //this place has a 0 so I need to check the adjacent positions
            {
                //Check if we are at the beginning of the array. If we are
                //then check if we can plant a flower.
                //Do the same to check if we are at the last place of the array
                if(arrayCtr == 0)
                {
                    if(flowerbed[arrayCtr + 1] == 1)
                    {
                        arrayCtr += 3; //not by 2 because we would still be in an adjacent position
                        continue;
                    }
                    else
                    {
                        flowerCtr++;
                        arrayCtr += 2;
                        continue;
                    }
                }
                else if(arrayCtr == flowerbed.length - 1)
                {
                    //We are at the last place so after this check we can exit the loop
                    if(flowerbed[arrayCtr - 1] == 1) //We cannot plant here so we exit because the previous plot is planted already
                        break;
                    else
                    {
                        flowerCtr++;
                        break;
                    }
                }
                else
                {
                    if(flowerbed[arrayCtr - 1] == 0 && flowerbed[arrayCtr + 1] == 0)
                    {
                        flowerCtr++;
                        arrayCtr += 2;
                        continue;
                    }
                    else if(flowerbed[arrayCtr + 1] == 0) //now check which condition broke the previous check in order to move accordingly
                    {
                        arrayCtr += 1;
                        continue;
                    }
                    else if(flowerbed[arrayCtr + 1] == 1)
                    {
                        arrayCtr += 3;
                        continue;
                    }
                }
            }
        }

        return flowerCtr >= n; //If the flower ctr is bigger this means that we can plant more than n flowers. I need at least n
    }
}

