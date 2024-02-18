/*
You are given an array prices where prices[i] is the price of a given stock on the ith day.

You want to maximize your profit by choosing a single day to buy one stock and choosing a different day in the future to sell that stock.

Return the maximum profit you can achieve from this transaction. If you cannot achieve any profit, return 0.

Example 1:

Input: prices = [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
Note that buying on day 2 and selling on day 1 is not allowed because you must buy before you sell.
Example 2:

Input: prices = [7,6,4,3,1]
Output: 0
Explanation: In this case, no transactions are done and the max profit = 0.
 

Constraints:

1 <= prices.length <= 105
0 <= prices[i] <= 104

My solution:
*/

class Solution {
    public int maxProfit(int[] prices) {
        int maxProf = 0;
        int minPrice = Integer.MAX_VALUE;
        int currProf = 0;

        /*Each time we check if the current value is the smallest one so far.
        If yes then we store it as the smallest value to buy our stock.
        We subtract the minimum value from the current stock price 
        to check if there is a bigger profit than before
        */
        for(int i = 0; i < prices.length; i++)
        {
            if(prices[i] < minPrice) //we find a new smaller value to buy stock
                minPrice = prices[i];

            //if I find a new smallest value, then the profit of selling it today is 0
            currProf = prices[i] - minPrice; 

            if(currProf > maxProf)
                maxProf = currProf;
        }

        return maxProf;
    }
}