/*
You are given the heads of two sorted linked lists list1 and list2.

Merge the two lists into one sorted list. The list should be made by splicing together the nodes of the first two lists.

Return the head of the merged linked list.

Input: list1 = [1,2,4], list2 = [1,3,4]
Output: [1,1,2,3,4,4]
Example 2:

Input: list1 = [], list2 = []
Output: []
Example 3:

Input: list1 = [], list2 = [0]
Output: [0]
 

Constraints:

The number of nodes in both lists is in the range [0, 50].
-100 <= Node.val <= 100
Both list1 and list2 are sorted in non-decreasing order.


My Solution:
*/

/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     struct ListNode *next;
 * };
 */

struct ListNode* mergeTwoLists(struct ListNode* list1, struct ListNode* list2)
{
    struct ListNode *head, *currNode1, *currNode2, *tail;

    currNode1 = list1;
    currNode2 = list2;

    head = tail = NULL;

    if(currNode1 == NULL) return list2;
    if(currNode2 == NULL) return list1;

    while(currNode1 != NULL && currNode2 != NULL)
    {
        if(currNode1->val < currNode2->val)
        {
            if(head == NULL)
            {
               head = currNode1; //make head and tail the first node of the first list
               tail = currNode1;
            }
            else
            {
                tail->next = currNode1; //make the next of tail to show to the new node and make the new node the new tail
                tail = currNode1;
            }

            currNode1 = currNode1->next;
        }
        else
        {
            if(head == NULL)
            {
                head = currNode2;
                tail = currNode2;
            }
            else
            {
                tail->next = currNode2;
                tail = currNode2;
            }

            currNode2 = currNode2->next;
        }

    }

    while(currNode1 != NULL)
    {
        tail->next = currNode1;
        tail = currNode1;
        currNode1 = currNode1->next;
    }

    
    while(currNode2 != NULL)
    {
        tail->next = currNode2;
        tail = currNode2;
        currNode2 = currNode2->next;
    }
    
    return head;
}