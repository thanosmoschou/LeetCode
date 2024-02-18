/*
Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

An input string is valid if:

Open brackets must be closed by the same type of brackets.
Open brackets must be closed in the correct order.
Every close bracket has a corresponding open bracket of the same type.
 

Example 1:

Input: s = "()"
Output: true

Example 2:

Input: s = "()[]{}"
Output: true

Example 3:

Input: s = "(]"
Output: false
 

Constraints:

1 <= s.length <= 104
s consists of parentheses only '()[]{}'.


My Solution:
*/

bool isValid(char * s)
{
    int size = strlen(s), top = -1; //top shows the top element of the stack
    char curr;
    char *stack = (char *)malloc(size);

    if(stack == NULL)
        return false;

    if(size <= 1) //only one element which is wrong
    {
        free(stack);
        return false;
    }

    for(int i = 0; i < size; i++)
    {
        curr = s[i];

        //if something opens, put it to the top of the stack
        //if something closes, check if top of the stack has the equivalent opening parenthesis
        //if yes then pop it from the stack, else return false because the closing order is not correct

        if(curr == '(' || curr == '[' || curr == '{')
        {
            top++;
            stack[top] = curr;
        }
        else if( (top == -1) || (curr == ')' && stack[top] != '(') || (curr == ']' && stack[top] != '[') || (curr == '}' && stack[top] != '{') ) //the s[i] is the first element and is a closing parenthesis which is wrong
        {
            free(stack);
            return false;
        }
        else
            top--; //move the top of the stack one place down
        
    }

    free(stack);

    if(top == -1) //stack is empty so the closing order is correct
        return true;
    else
        return false;
}
