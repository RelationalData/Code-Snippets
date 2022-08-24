/*
Given a positive sorted array a = [ 3, 4, 6, 9, 10, 12, 14, 15, 17, 19, 21 ];
Define a function f(a, x) that returns x, the next smallest number, or -1 for errors.

Define at least 8 test conditions, i.e. f(a, 12) = 12 or f(a, 13) = 12 (You can use these two, so only 6 left! :) )
--======================================================================================

--===================================C#=================================================
using System;
 
class GFG {
 
    /* prints element and NSE pair for
    all elements of arr[] of size n */
    static void printNSE(int[] arr, int n)
    {
        int next, i, j;
        for (i = 0; i < n; i++) {
            next = -1;
            for (j = i + 1; j < n; j++) {
                if (arr[i] > arr[j]) {
                    next = arr[j];
                    break;
                }
            }
            Console.WriteLine(arr[i] + " -- " + next);
        }
    }
 
    // driver code
    public static void Main()
    {
        int[] arr = { 11, 13, 21, 3 };
        int n = arr.Length;
 
        printNSE(arr, n);
    }
}
--===================================C#=================================================
*/
/*==================================T-SQL=============================================== 

Given a positive sorted array a = [ 3, 4, 6, 9, 10, 12, 14, 15, 17, 19, 21 ];
Define a function f(a, x) that returns x, the next smallest number, or -1 for errors.
*/
USE master
GO
DROP FUNCTION IF EXISTS dbo.InterviewQuestion;
GO
CREATE FUNCTION dbo.InterviewQuestion
	(@Array varchar(max), @Input int)
RETURNS int
AS
--======================DEBUG====================================

--SELECT dbo.InterviewQuestion('3,4,6,9,10,12,14,15,17,19,21', 11);

--===============================================================
BEGIN
	DECLARE @Answer int = -1, @Low0 int, @High0 int, @Low1 int, @High1 int;
	DECLARE @Table0 TABLE (id int IDENTITY(1,1), Item int)
	DECLARE @Item0 int, @Item1 int;

	INSERT INTO @Table0
		(Item)
	SELECT CAST(value AS int)
		FROM STRING_SPLIT(@Array, ',')
	ORDER BY CAST(value AS int);
	SELECT @High0 = COUNT(1) FROM @Table0;
	SET @Low0 = 1;

	IF EXISTS(SELECT 1 FROM @Table0 WHERE Item = @Input)
		BEGIN
		SELECT @Answer = @Input;
		RETURN (@Answer);
		END
	ELSE
		BEGIN
		IF EXISTS(SELECT 1 FROM @Table0 WHERE Item < @Input)
			BEGIN
			SELECT @Answer = MAX(Item) FROM @Table0 WHERE Item < @Input;
			RETURN (@Answer);		
			END;
		END;
	SET @Answer = -1	
	RETURN(@Answer);
END;

--==================================T-SQL=============================================== 
/*
=================================Java===================================================
Java

1. Initialize a stack and array.
2. Traverse the array from the end.
3. Update the monotonic stack as explained above.
4. Add the next smaller element in the array. If the stack is empty, i.e., no element is present, then add -1.
5. Add the current element to the stack.

===================================================================================
import java.util.Stack;
 
public class Main {
  // Function to display the next smaller elements
  private static void smallerElement(int[] arr) {
    Stack<Integer> stack = new Stack<>();
    int nextSmallerElement[] = new int[arr.length];
 
    System.out.println("Next Smaller Element: ");
    
    // Traverse from end
    for (int i = arr.length - 1; i >= 0; i--) {
      if (!stack.empty()) {
        // Remove elements that are greater than the array element
        while (!stack.empty() && stack.peek() >= arr[i]) {
          stack.pop();
        }
      }
      
      // Add the next smaller element in the array
      nextSmallerElement[i] = stack.empty() ? -1 : stack.peek();
      
      // Add the current element to the stack
      stack.push(arr[i]);
    }
    for (int i = 0; i < arr.length; i++)
      System.out.print(nextSmallerElement[i] + " ");
  }
 
  public static void main(String[] args) {
    int[] arr = new int[] { 2, 1, 4, 3 };
    smallerElement(arr);
  }
}
=================================Java===================================================
*/



/*
function f(a, x) { 
  if (a == null || a.length == 0) return -1;
  var answer = -1;
  var low = 0;
  var high = a.length - 1;
  while(low <= high) {
    var mid = Math.floor((low + high) / 2);
    if (a[mid] == x) { 
      return x; 
    } else if (a[mid] < x) { 
      answer = a[mid];
      low = mid + 1;
    } else {
      high = mid - 1;
    }
  } 
  return answer;
}
*/