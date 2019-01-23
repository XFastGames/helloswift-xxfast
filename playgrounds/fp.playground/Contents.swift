/*:
 [Previous](@previous)
 ##  Basic Functional Programming
 In this section, we will look at how we can use swift in a functional programming paradigm
 1. Constants
 2. Pure/Stateless Functions
 3. Closure
 4. Higher-order Functions
 
 [Next](@next)
 */

import Foundation

/*:
 ### Constants
 In the [previous](@previous) section we learned `Variables` - which simply means the value **can** change after declaration.
 
 `Constants` however - means once its set, the value can **not** change
 
 eg:- Declaring constants with a name and a type, and initialised
 * `let <constant-name>:[constant-type] = <only-value>`
 */
let name = "isuru"

//: Once declared, constants cannot change its value
//: - Warning: following line - if uncommented - would not compile
// name = "ian"

/*:
 The problem with variable is that it's *mutable* state. Mutable states often leads to side-effects, especially in a large object-oriented concurrent system.
 
 In the example below, we've have a age variable
 */
var age: Int = 10
print(age) // <- value of age is 10
age = age + 1
print(age) // <- value of age is 11

/*:
 By making this property a variable, we've effectively just introduced a factor of time to this particular property, which make the value of `age` deterministed by the order of execution/time
 */
func mainThread() {
    var age: Int = 10
    
    // thread 1
    func workerThread(){
        age = age + 1
    }
    
    // thread 2
    func renderThread(){
        print(age)
    }
}

/*:
 By moving the print method to a different thread, we've made the value of `age` quite unpredictable, because the fact that we don't know which thread get to execute first
 
 This is why a more functional programming paradigm can be more useful
 */

/*:
 ### Pure/Stateless functions
 In the [previous](@previous) section we learned `Functions` - which simply may takes 0 or values (parameters) and return 0 or more values (return values)
 
 `Pure functions` are functions that doesn't **mutate** any values outside of the defined scope
 */
func calculateAge(dob: Date) -> Int {
    let age = Int( Date().timeIntervalSince( dob ) ) / (60 * 60 * 24 * 365)
    return age
}

/*:
 Eg:- Writing a function to get people aged more than 18
 */
struct Person {
    var name: String
    var age: Int
}

let theXx = [Person(name: "Jamie", age: 30),
             Person(name: "Romy", age: 31),
             Person(name: "Oliver", age: 32)]

func filterByAge(people: [Person], age: Int) -> [Person] {
    var adults:[Person] = []
    for person in people {
        if person.age > age {
            adults.append(person)
        }
    }
    return adults
}

filterByAge(people: theXx, age: 30)

/*: We can make use of the function `.filter` provided with collections
 - Note: `.filter` is an higher order function. Other higher order functions will be discussed later
 */
func filterAdults(people: [Person], age: Int) -> [Person] {
    return people.filter { (person) -> Bool in
        person.age > age
    }
}

//: this is okay, but this wouldn't work if we had dynamic conditions

/*:
 ### Closure
 Self-contained functions that are defined only with the arguments and returns
 
 - Note: Closures are commonly known as blocks / lamdas in other programming languages
 
 eg:- Declaring a closure that takes in and `A` and  returns a `B`
 * `var <name>: (<[args]>) -> <[returns]> = { ([<input-name>]) in <body> }`
 */
var checkAgeClosure: (Int) -> Bool = { (input) in input > 18 }
var checkAdultClosure: (Person) -> Bool = { (person) in person.age > 18 }

checkAgeClosure(17)
checkAdultClosure(Person(name: "Baria", age: 29))

/*:
 Closures are often used in place of arguments, where functional logic needs to be replaced dynamicaly
 
 Here, our filter condition can be passed in as a closure
 */
func filterBy(_ people: [Person], condition: (Person) -> Bool) -> [Person] {
    return people.filter { (person) in condition(person) }
}

// With closures, we can
filterBy(theXx, condition: { (person) -> Bool in person.age > 18 })

// closures looks nice if we lift it out of the function call
filterBy(theXx) { (person) -> Bool in person.age > 18 }

// this is good, but we can do better.

// This function works best as an extention on `[Human]`
// Extentions allows to extend functionality without inheriting the given type
extension Array where Element == Person {
    func filterBy(condition: (Person) -> Bool) -> [Person] {
        return self.filter { (person) in condition(person) }
    }
}

/*:
 extensions by default are availablein the scope they are defined in. They also can be imported
 */
theXx.filterBy { (person) -> Bool in person.age > 18 }

/*:
 ### Higher-order functions
 Just like pure functions, higher order functions are TODO()
 To facilitate a functional design paradigm, swift is equiped with a some higher-order functions.
 
 Some of these are
 1. `.map`
 2. `.reduce`
 3. `.filter`
 */

/*:
 #### 1. `.map`
 Converts one value of one type to another value of another type with the provided operation
 */
struct Identification {
    var id: String
}

let ids = theXx.map { (person) -> Identification in
    Identification(id: "\(person.name) xx")
}


/*:
 #### 2. `.reduce`
 Collects all values of a collection to a single value
 */
let ageSum = theXx.reduce(0) { (sum, person) -> Int in
    sum + person.age
}

/*:
 #### 2. `.filter`
 Covered [here](@next)
 */
