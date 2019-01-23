/*:
 [Previous](@previous)
 ##  Basic Imperative Programming
 In this section, we will look at how we can use swift to define each of the following
 1. Variables
 2. Control Structures
 3. Optionals
 4. Functions
 
 [Next](@next)
 */

import Foundation

/*:
 ### Variables
 Declaring a variable with a name and a type, then initialise it
 * `var <variable-name>:[variable-type] = <initialised-value>`
 */
var x: Int = 24
//: Expressions can be used to mutate/change the variables
x = 25

//: Type is can be inferred, so you can leave it off (most of the time)
var age = 24

/*:
 ### Control Structures
 Program flow can be crontrolled with control structures
 
 `if` statement
 */
if ( x > 24 ) {
    print("x is greater that 24")
} else {
    print("x is less that or equal to 24")
}

//: `for` loops
for y in 1...3 {
    print("y is \(y)")
}

//: `while` loops
var i = 1
while i <= 10 {
    print("i is \(i)")
    i = i + 1
}

//: `repeat` loops
var j = 10
repeat {
    print("j is \(j)")
    j -= 1
} while j > 0

/*:
 ### Optionals
 Not all values are knowable, they can be optionals
 */
var dateOfBirth: Date = Date(timeIntervalSince1970: 12345) // this variable can never be nil/null
var dateOfDeath: Date? = nil // this variable can sometimes be nil, hence is an `Optional`

/*:
 When dealing with optionals; they needs to unwrapped.
 Resulting assigningment will also be optional
 */
var timeSinceDeath: TimeInterval? = dateOfDeath?.timeIntervalSinceNow

//: Optionals can also be unwrapped with defaults
var someOtherDay = dateOfDeath ?? Date()

/*:
 Optionals can be forced unwrapped, leaving the program vulnerable for runtime error
 - Warning: following line - if uncommented - would compile but crash on runtime
 */
// print(timeSinceDeath!)

//: Optionals can be chained like if statements, with a `let` block
if let secondsSinceDeath = dateOfDeath?.timeIntervalSinceNow {
    print("time of death recorded was \(secondsSinceDeath) seconds(s) ago.")
} else {
    print("no time of death recorded.")
}

//: Optionals often needs to be guarded, with a `guard` block to ensure - if needed be - a value is what it needs to be. This is very useful to avoid pyramids of if statements and force unwrappes, typically seen in validation

struct Credentials {
    let username: String?
    let password: String?
}

func attemptSubmission(sumbition: Credentials) {
    guard let username = sumbition.username else {
        print("Username is required")
        return
    }
    
    guard let password = sumbition.password else {
        print("Password is required")
        return
    }
    
    print("username \(username) password: \(password)")
}

attemptSubmission(sumbition: Credentials(username: "admin", password: nil))

/*:
 ### Functions
 Funtions are grouped set of expressions that may takes 0 or more values (parameters) and return 0 or more values (return values)
 
 eg:- Declaring function with a name and a argument, and a return value
 * `func <function-name>([arguments]) : <return-type> { <function-body >}`
 */
func printAge(dob: Date) {
    let age = Int( Date().timeIntervalSince( dob ) ) / (60 * 60 * 24 * 365)
    print("Age is \(age)")
}

/*:
 And can be reused
 - Note: when invoking a function; unlike other programming languages, you need to provide the argument name by default. You can prefix an argument with `_` to make the labels optional on the callsite
 */
printAge(dob: dateOfBirth) // callsite; where the function is called
printAge(dob: Date())

/*:
 Funtion arguments can be defined with default values. If the argument is not provided in the callsite, then the default value is assumed
 
 */
func printAgeTill(dob: Date, till date: Date = Date()) {
    let age = Int( date.timeIntervalSince( dob ) )  / (60 * 60 * 24 * 365)
    print(age)
}

printAgeTill(dob: dateOfBirth) // since the `till` argument not provided, it is defaulted to `Date()`
printAgeTill(dob: dateOfBirth, till: someOtherDay)

//: - Note: the prefix on the date argument (`till` ), gives additional context around the usage of that given argument. This makes both the callsite's and definition's declarations more semantic

//: Functions can return a value back
func getAge(dob: Date, till: Date = Date()) -> Int {
    return Int( dob.timeIntervalSince(till) ) / (60 * 60 * 24 * 365)
}

//: Returned values can be used in assignment
age = getAge(dob: dateOfBirth)

//: with Swift; functions can also return multiple values
func getAgeInYearsAndDays(dob: Date) -> (years: Int, days: Int) {
    let seconds = Int( dob.timeIntervalSince( Date() ) )
    let days = seconds / 60 * 60 * 24
    let years = days / 365
    return (years, days)
}

//: These returned values can be use for expressions, like this
age = getAgeInYearsAndDays(dob: dateOfBirth).years
