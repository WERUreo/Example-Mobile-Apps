//: ## Pattern Match Operator
//:
//: Typically, when you are trying you see if a number is between a range, you would do something like this:

import UIKit

var number = 75

if number >= 0 && number <= 100
{
    print("\(number) is in range")
}

//: And that works perfectly fine.  But Swift offers an operator called the Pattern Match Operator (```~=```).
//: With this operator, you can accomplish the same task with this simple bit of code:

if 0...100 ~= number
{
    print("\(number) is in range")
}
