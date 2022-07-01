########Arguments
$0 specifies the name of the script to be invoked.
$1-$9 stores the names of the first 9 arguments or can be used as the arguments positions.
$# specifies the total number (count) of arguments passed to the script.
$*(postional parameter) stores all the command line arguments by joining them together.
$@ stores the list of arguments as an array or treated as sperate arguments.
$? specifies the exit status of the last command or the most recent execution process.
$$ specifies the process ID of the current script..
$! shows ID of the last background job.

###############opertional-condition########
Operator	Description	Example
+ (Addition)	Adds values on either side of the operator	`expr $a + $b` will give 30
- (Subtraction)	Subtracts right hand operand from left hand operand	`expr $a - $b` will give -10
* (Multiplication)	Multiplies values on either side of the operator	`expr $a \* $b` will give 200
/ (Division)	Divides left hand operand by right hand operand	`expr $b / $a` will give 2
% (Modulus)	Divides left hand operand by right hand operand and returns remainder	`expr $b % $a` will give 0
= (Assignment)	Assigns right operand in left operand	a = $b would assign value of b into a
== (Equality)	Compares two numbers, if both are same then returns true.	[ $a == $b ] would return false.
!= (Not Equality)	Compares two numbers, if both are different then returns true.	[ $a != $b ] would return true.

It is very important to understand that all the conditional expressions should be inside square braces with spaces around them, for example [ $a == $b ] is correct whereas, [$a==$b] is incorrect.
All the arithmetical calculations are done using long integers.
Relational Operators
Bourne Shell supports the following relational operators that are specific to numeric values. These operators do not work for string values unless their value is numeric.
For example, following operators will work to check a relation between 10 and 20 as well as in between "10" and "20" but not in between "ten" and "twenty".
Assume variable a holds 10 and variable b holds 20 then −
Show Examples
Operator	Description	Example
-eq	Checks if the value of two operands are equal or not; if yes, then the condition becomes true.	[ $a -eq $b ] is not true.
-ne	Checks if the value of two operands are equal or not; if values are not equal, then the condition becomes true.	[ $a -ne $b ] is true.
-gt	Checks if the value of left operand is greater than the value of right operand; if yes, then the condition becomes true.	[ $a -gt $b ] is not true.
-lt	Checks if the value of left operand is less than the value of right operand; if yes, then the condition becomes true.	[ $a -lt $b ] is true.
-ge	Checks if the value of left operand is greater than or equal to the value of right operand; if yes, then the condition becomes true.	[ $a -ge $b ] is not true.
-le	Checks if the value of left operand is less than or equal to the value of right operand; if yes, then the condition becomes true.	[ $a -le $b ] is true.
It is very important to understand that all the conditional expressions should be placed inside square braces with spaces around them. For example, [ $a <= $b ] is correct whereas, [$a <= $b] is incorrect.

Boolean Operators
The following Boolean operators are supported by the Bourne Shell.
Assume variable a holds 10 and variable b holds 20 then −
Show Examples
Operator	Description	Example
!	This is logical negation. This inverts a true condition into false and vice versa.	[ ! false ] is true.
-o	This is logical OR. If one of the operands is true, then the condition becomes true.	[ $a -lt 20 -o $b -gt 100 ] is true.
-a	This is logical AND. If both the operands are true, then the condition becomes true otherwise false.	[ $a -lt 20 -a $b -gt 100 ] is false.

String Operators
The following string operators are supported by Bourne Shell.
Assume variable a holds "abc" and variable b holds "efg" then −
Show Examples
Operator	Description	Example
=	Checks if the value of two operands are equal or not; if yes, then the condition becomes true.	[ $a = $b ] is not true.
!=	Checks if the value of two operands are equal or not; if values are not equal then the condition becomes true.	[ $a != $b ] is true.
-z	Checks if the given string operand size is zero; if it is zero length, then it returns true.	[ -z $a ] is not true.
-n	Checks if the given string operand size is non-zero; if it is nonzero length, then it returns true.	[ -n $a ] is not false.
str	Checks if str is not the empty string; if it is empty, then it returns false.	[ $a ] is not false.

File Test Operators
We have a few operators that can be used to test various properties associated with a Unix file.
Assume a variable file holds an existing file name "test" the size of which is 100 bytes and has read, write and execute permission on −
Show Examples
Operator	Description	Example
-b file	Checks if file is a block special file; if yes, then the condition becomes true.	[ -b $file ] is false.
-c file	Checks if file is a character special file; if yes, then the condition becomes true.	[ -c $file ] is false.
-d file	Checks if file is a directory; if yes, then the condition becomes true.	[ -d $file ] is not true.
-f file	Checks if file is an ordinary file as opposed to a directory or special file; if yes, then the condition becomes true.	[ -f $file ] is true.
-g file	Checks if file has its set group ID (SGID) bit set; if yes, then the condition becomes true.	[ -g $file ] is false.
-k file	Checks if file has its sticky bit set; if yes, then the condition becomes true.	[ -k $file ] is false.
-p file	Checks if file is a named pipe; if yes, then the condition becomes true.	[ -p $file ] is false.
-t file	Checks if file descriptor is open and associated with a terminal; if yes, then the condition becomes true.	[ -t $file ] is false.
-u file	Checks if file has its Set User ID (SUID) bit set; if yes, then the condition becomes true.	[ -u $file ] is false.
-r file	Checks if file is readable; if yes, then the condition becomes true.	[ -r $file ] is true.
-w file	Checks if file is writable; if yes, then the condition becomes true.	[ -w $file ] is true.
-x file	Checks if file is executable; if yes, then the condition becomes true.	[ -x $file ] is true.
-s file	Checks if file has size greater than 0; if yes, then condition becomes true.	[ -s $file ] is true.
-e file	Checks if file exists; is true even if file is a directory but exists.
###The if...else statements
If else statements are useful decision-making statements which can be used to select an option from a given set of options.
Unix Shell supports following forms of if…else statement −
if...fi statement

if...else...fi statement
if...elif...else...fi statement
##Loops
A loop is a powerful programming tool that enables you to execute a set of commands repeatedly. In this chapter, we will examine the following types of loops available to shell programmers −
The while loop
The for loop
The until loop
The select loop
You will use different loops based on the situation. For example, the while loop executes the given commands until the given condition remains true;
the until loop executes until a given condition becomes true.
Once you have good programming practice you will gain the expertise and thereby, start using appropriate loop based on the situation. 
Here, while and for loops are available in most of the other programming languages like C, C++ and PERL, etc.
#Nesting Loops
All the loops support nesting concept which means you can put one loop inside another similar one or different loops. 
This nesting can go up to unlimited number of times based on your requirement.
Here is an example of nesting while loop. The other loops can be nested based on the programming requirement in a similar way −Nesting while Loops.
It is possible to use a while loop as part of the body of another while loop.
Syntax
while command1 ; # this is loop1, the outer loop
do
   Statement(s) to be executed if command1 is true

   while command2 ; # this is loop2, the inner loop
   do
      Statement(s) to be executed if command2 is true
   done

   Statement(s) to be executed if command1 is true
done
Example
#####Here is a simple example of loop nesting. Let's add another countdown loop inside the loop that you used to count to nine −
##!/bin/sh
#a=0
while [ "$a" -lt 10 ]    # this is loop1
do
   b="$a"
   while [ "$b" -ge 0 ]  # this is loop2
   do
      echo -n "$b "
      b=`expr $b - 1`
   done
   echo
   a=`expr $a + 1`
done

#In this chapter, we will discuss shell loop control in Unix. So far you have looked at creating loops and working with loops to accomplish
different tasks. Sometimes you need to stop a loop or skip iterations of the loop.
In this chapter, we will learn following two statements that are used to control shell loops− The break statement
The continue statement
The infinite Loop
All the loops have a limited life and they come out once the condition is false or true depending on the loop.
A loop may continue forever if the required condition is not met.
 A loop that executes forever without terminating executes for an infinite number of times. For this reason, such loops are called infinite loops.
Example
Here is a simple example that uses the while loop to display the numbers zero to nine −
#!/bin/sh
a=10
until [ $a -lt 10 ]
do
   echo $a
   a=`expr $a + 1`
done
#This loop continues forever because a is always greater than or equal to 10 and it is never less than 10.
The break Statement
The break statement is used to terminate the execution of the entire loop, after completing the execution of all of the lines of code up to the break statement. 
It then steps down to the code following the end of the loop.
Syntax
The following break statement is used to come out of a loop −
break
The break command can also be used to exit from a nested loop using this format −
break n
Here n specifies the nth enclosing loop to the exit from.
Example
Here is a simple example which shows that loop terminates as soon as a becomes 5 −
#!/bin/sh
a=0
while [ $a -lt 10 ]
do
   echo $a
   if [ $a -eq 5 ]
   then
      break
   fi
   a=`expr $a + 1`
done
Upon execution, you will receive the following result −
0
1
2
3
4
5
Here is a simple example of nested for loop. This script breaks out of both loops if var1 equals 2 and var2 equals 0 −
Live Demo
#!/bin/sh
for var1 in 1 2 3
do
   for var2 in 0 5
   do
      if [ $var1 -eq 2 -a $var2 -eq 0 ]
      then
         break 2
      else
         echo "$var1 $var2"
      fi
   done
done
Upon execution, you will receive the following result. In the inner loop, you have a break command with the argument 
2. This indicates that if a condition is met you should break out of outer loop and ultimately from the inner loop as well.
1 0
1 5
The continue statement
The continue statement is similar to the break command, except that it causes the current iteration of the loop to exit, rather than the entire loop.
This statement is useful when an error has occurred but you want to try to execute the next iteration of the loop.
Syntax
continue
Like with the break statement, an integer argument can be given to the continue command to skip commands from nested loops.
continue n
Here n specifies the nth enclosing loop to continue from.
Example
The following loop makes use of the continue statement which returns from the continue statement and starts processing the next statement −
Live Demo
#!/bin/sh
NUMS="1 2 3 4 5 6 7"
for NUM in $NUMS
do
   Q=`expr $NUM % 2`
   if [ $Q -eq 0 ]
   then
      echo "Number is an even number!!"
      continue
   fi
   echo "Found odd number"
done
Upon execution, you will receive the following result 