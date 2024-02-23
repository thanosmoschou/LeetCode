/*
There are n kids with candies. You are given an integer array candies, where each candies[i] represents 
the number of candies the ith kid has, and an integer extraCandies, denoting the number of extra candies that you have.

Return a boolean array result of length n, where result[i] is true if, after giving the ith kid all the extraCandies, 
they will have the greatest number of candies among all the kids, or false otherwise.

Note that multiple kids can have the greatest number of candies.

Example 1:

Input: candies = [2,3,5,1,3], extraCandies = 3
Output: [true,true,true,false,true] 
Explanation: If you give all extraCandies to:
- Kid 1, they will have 2 + 3 = 5 candies, which is the greatest among the kids.
- Kid 2, they will have 3 + 3 = 6 candies, which is the greatest among the kids.
- Kid 3, they will have 5 + 3 = 8 candies, which is the greatest among the kids.
- Kid 4, they will have 1 + 3 = 4 candies, which is not the greatest among the kids.
- Kid 5, they will have 3 + 3 = 6 candies, which is the greatest among the kids.

Example 2:

Input: candies = [4,2,1,1,2], extraCandies = 1
Output: [true,false,false,false,false] 
Explanation: There is only 1 extra candy.
Kid 1 will always have the greatest number of candies, even if a different kid is given the extra candy.

Example 3:

Input: candies = [12,1,12], extraCandies = 10
Output: [true,false,true]
 

Constraints:

n == candies.length
2 <= n <= 100
1 <= candies[i] <= 100
1 <= extraCandies <= 50

*/

class Solution 
{
    public List<Boolean> kidsWithCandies(int[] candies, int extraCandies) 
    {
        int maxCandy = Arrays.stream(candies).max().getAsInt();
        List<Boolean> result = new ArrayList<>();

        for(int candy : candies)
            result.add(candy + extraCandies >= maxCandy); //each element will be a true or false value
        
        return result;
    }
}

 /*
  * Some theory from official java documentation: 

    Stream: A sequence of elements supporting sequential and parallel aggregate operations. 

    The following example illustrates an aggregate operation using Stream and IntStream:

    int sum = widgets.stream()
                     .filter(w -> w.getColor() == RED)
                     .mapToInt(w -> w.getWeight())
                     .sum();
 
    In this example, widgets is a Collection<Widget>. We create a stream of Widget objects via Collection.stream(), 
    filter it to produce a stream containing only the red widgets, and then transform it into a stream of int values 
    representing the weight of each red widget. Then this stream is summed to produce a total weight.

    In addition to Stream, which is a stream of object references, there are primitive specializations for IntStream, 
    LongStream, and DoubleStream, all of which are referred to as "streams" and conform to the characteristics and restrictions described here.

    To perform a computation, stream operations are composed into a stream pipeline. 
    A stream pipeline consists of a source (which might be an array, a collection, a generator function, an I/O channel, etc), 
    zero or more intermediate operations (which transform a stream into another stream, such as filter(Predicate)), 
    and a terminal operation (which produces a result or side-effect, such as count() or forEach(Consumer)). 
    Streams are lazy; computation on the source data is only performed when the terminal operation is initiated, 
    and source elements are consumed only as needed.

    Collections and streams, while bearing some superficial similarities, have different goals. 

    Collections are primarily concerned with the efficient management of, and access to, their elements. 

    By contrast, streams do not provide a means to directly access or manipulate their elements, 
    and are instead concerned with declaratively describing their source and the computational operations which will be 
    performed in aggregate on that source. 
    
    However, if the provided stream operations do not offer the desired functionality, 
    the BaseStream.iterator() and BaseStream.spliterator() operations can be used to perform a controlled traversal.

    A stream pipeline, like the "widgets" example above, can be viewed as a query on the stream source. 
    Unless the source was explicitly designed for concurrent modification (such as a ConcurrentHashMap), 
    unpredictable or erroneous behavior may result from modifying the stream source while it is being queried.

    Most stream operations accept parameters that describe user-specified behavior, such as the lambda 
    expression w -> w.getWeight() passed to mapToInt in the example above. 
    
    To preserve correct behavior, these behavioral parameters:
    must be non-interfering (they do not modify the stream source); 
    and
    in most cases must be stateless (their result should not depend on any state that might change during execution of the stream pipeline).

    Such parameters are always instances of a functional interface such as Function, and are often lambda expressions or method references. 
    Unless otherwise specified these parameters must be non-null.

    A stream should be operated on (invoking an intermediate or terminal stream operation) only once. This rules out, for example, 
    "forked" streams, where the same source feeds two or more pipelines, or multiple traversals of the same stream. A stream 
    implementation may throw IllegalStateException if it detects that the stream is being reused. However, since some stream 
    operations may return their receiver rather than a new stream object, it may not be possible to detect reuse in all cases.

    Streams have a BaseStream.close() method and implement AutoCloseable, but nearly all stream instances do not actually need 
    to be closed after use. Generally, only streams whose source is an IO channel (such as those returned by Files.lines(Path, Charset)) 
    will require closing. Most streams are backed by collections, arrays, or generating functions, which require no special resource management. 
    (If a stream does require closing, it can be declared as a resource in a try-with-resources statement.)

    Stream pipelines may execute either sequentially or in parallel. This execution mode is a property of the stream. Streams are created 
    with an initial choice of sequential or parallel execution. (For example, Collection.stream() creates a sequential stream, 
    and Collection.parallelStream() creates a parallel one.) This choice of execution mode may be modified by the BaseStream.sequential() 
    or BaseStream.parallel() methods, and may be queried with the BaseStream.isParallel() method.
  */