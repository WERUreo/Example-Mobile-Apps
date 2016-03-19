import UIKit

//: ## Exercise
//: 1. Create an empty array of type Int called oddNumbers
//: 2. Using a standard for loop add all odd numbers less than or equal to 100 to the oddNumbers array
//: 3. Create a second array called sums of type Int
//: 4. Using a for each loop, iterate through oddNumbers array and add the current iteration value + 5 to the sums array
//: 5. Using a repat while loop, iterate through the sums array and print "The sum is: x" where x is the current value of the iteration (ie The sum is: 15)
//: In the end, if done correctly, the sums array should print as follows:
//:
//: ```print(sums)```
//:
//: ```[6, 8, 10, 12, 14, 16, 18, 20., 22, 24, 26, 28, 30, 32, 34, 36, 38, 40, 42, 44, 46, 48, 50, 52, 54, 56, 58, 60, 62, 64, 66, 68, 70, 72, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98, 100, 102, 104]```
var oddNumbers = [Int]()
for (var i = 0; i <= 100; i++)
{
    if i % 2 != 0
    {
        oddNumbers.append(i)
    }
}

var sums = [Int]()
for num in oddNumbers
{
    sums.append(num + 5)
}

var x = 0
repeat
{
    print("The sum is: \(sums[x])")
    x++
} while x < sums.count

print(sums)

