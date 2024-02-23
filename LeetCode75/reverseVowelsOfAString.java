/*
Given a string s, reverse only all the vowels in the string and return it.

The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lower and upper cases, more than once.

Example 1:

Input: s = "hello"
Output: "holle"

Example 2:

Input: s = "leetcode"
Output: "leotcede"

Constraints:

1 <= s.length <= 3 * 105
s consist of printable ASCII characters.


Disclaimer: My goal here is to implement the solution using streams.
*/

class Solution
{
    StringBuffer strBuffer;
    HashSet<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'));

    public String reverseVowels(String s) 
    {
        List<Character> stringVowels = s.chars()
                                        .mapToObj(c -> (char) c)
                                        .filter(c -> vowels.contains(c))
                                        .collect(Collectors.toList());
        Collections.reverse(stringVowels);

        if(stringVowels.size() == 0)
            return s;
            
        strBuffer = new StringBuffer(s);
        IntStream.range(0, strBuffer.length())
                 .forEach(i -> {
                                   if(vowels.contains(strBuffer.charAt(i)))
                                   {
                                       char newVowel = stringVowels.remove(0);
                                       strBuffer.setCharAt(i, newVowel);
                                   }
                               }
                         );

        return strBuffer.toString();
    }
}

/*
Another easier to understand solution:
*/

class Solution
{
    StringBuffer strBuffer;
    HashSet<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'));

    public String reverseVowels(String s) 
    {
        List<Character> stringVowels = s.chars()
                                        .mapToObj(c -> (char) c)
                                        .filter(c -> vowels.contains(c))
                                        .collect(Collectors.toList());
        Collections.reverse(stringVowels);

        if(stringVowels.size() == 0)
            return s;
            
        strBuffer = new StringBuffer(s);
        
        int ctr = 0;
        for(int i = 0; i < strBuffer.length(); i++)
        {
            if(vowels.contains(strBuffer.charAt(i)))
            {
                strBuffer.setCharAt(i, stringVowels.get(ctr));
                ctr++;
            }

            if(ctr >= stringVowels.size())
                break;
        }

        return strBuffer.toString();
    }
}
