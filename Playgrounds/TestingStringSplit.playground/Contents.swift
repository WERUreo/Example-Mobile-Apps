//: ## Splitting a String of Numbers Into an Array of Numbers
//: ----
//: I had a little side project I was working on where I was getting a string of 6 different numbers from a JSON object.
//: I needed to take those numbers out of the string and put them into an array of Int so that I could use them later on.
//: In Objective-C, the process was a little cumbersome:
//:
//:    + (NSMutableArray *)numberArrayFromString:(NSString *)numberString
//:      {
//:          NSMutableArray *numberArray = [NSMutableArray array];
//:          NSArray *numberStringArray = [numberString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//:          for (NSString *numString in numberStringArray)
//:          {
//:              NSNumber *num = [self numberFromString:numString];
//:              [numberArray addObject:num];
//:          }
//:
//:          return numberArray;
//:      }
//:
//: In Swift, accomplishing the same thing can be done in just one line:
import UIKit

let numberString = "2 4 6 14 35 7"
// This is the one line :)
let numberArray = numberString.characters.split(" ").map(String.init).map { Int($0)! }
print(numberArray)

//: Let's break that one line down into its individual parts.
//: First, we take the number string and split its characters out into a String array
let numberStringArray = numberString.characters.split(" ").map(String.init)
print(numberStringArray)

//: Basically, that line of code takes the characters in the String (```.characters```) and splits them into individual subsequences using a single space as the delimiter (```.split(" ")```)
//: Then, it uses the ```.map()``` function to transform those sub sequences into Strings and places them into an array.
//:
//: Once we have that array of characters (really they are Strings of length 1), we can use the ```.map()``` function again, along with a trailing closure, to transform the individual Strings into Ints.

let numbers = numberStringArray.map { Int($0)! }
print(numbers)

//: And that's it!