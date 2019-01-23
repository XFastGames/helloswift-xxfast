/*:
 [Previous](@previous)
 ##  Data Structures Programming
 In this section, we will look at how we can use swift to structure your data
 1. Structs, classes and enumerations
 2. Collections
 3. Generics
 
 [Next](@next)
 */
import Foundation

/*:
 Data often needs to be structured.
 Structs are used to introduce a hieracial structure
 - Note: Unlike objects; structs are statically defined and creates no object references are generated
 */
struct PersonStruct {
    var name: String
    var age: Int
    var dob: Date
    var dod: Date? = nil
}

//: Initialising a struct with set of values
var isuru = PersonStruct(name: "isuru", age: 24, dob: Date(), dod:nil)

//: These structs are not encapsulated, it's inner values can easily be accessed
isuru.dod = Date()

//: Enumeratables types are a set of nominal values, and defined like this
enum AgeGroup { case Infant, Child, Teen, Adult, Senior }

//: Values can/should be encapsulated, like with classes
class Human {
    
    // all properties are public by default
    let name: String
    
    // properties can be made private
    private let dob: Date
    let dod: Date?
    
    // Not all values needs to be stored
    var age: Int {
        // They can be computed properties (derived), read-only in this case
        get {
            let till: Date = dod ?? Date()
            return Int(dob.timeIntervalSince(till)) / (60 * 60 * 24 * 365)
        }
    }
    
    // Properties usually reflect internal state/values, without exposing the interal state/values
    var ageGroup: AgeGroup {
        get {
            switch age {
            case ..<5:
                return AgeGroup.Infant
            case 6...10:
                return AgeGroup.Child
            case 11...19:
                return AgeGroup.Teen
            case 20...59:
                return AgeGroup.Adult
            default:
                return AgeGroup.Senior
            }
        }
    }
    
    // lazy properties are not initialised until invoked
    lazy var firstName: String? = name.split(separator: " ").first.toString()
    lazy var lastName: String? = name.split(separator: " ").last.toString()
    
    // Constructors usually take in all required fields.
    // We can also define default values, just like functions
    init(name: String, dob: Date, dod: Date? = nil) {
        self.name = name
        self.dob = dob
        self.dod = dod
    }
    
    // Methods are essentially functions associated with a particular type, such as `Human`
    func say(message:String) {
        print("\(self.name)\t: \(message)")
    }
}

// Instantiating the object using the `Human` class definition
let human = Human(name: "isuru", dob: Date())

// publicly available members can be invoked/accessed, like this method
human.say(message: "Hello swift!")

// privately available members cannot be accessed outside of the defined scope
//human.age

// Arrays hold multiple values of a given type
var numbers: Array<Int> = Array([1,2,3,4])
// Shortened form is also valid
let names: [String] = ["Jamie", "Romy", "Oliver", "Baria"]

// Arrays can be defined with objects as well
let people: [Human] = [Human(name: "Chris", dob: Date.from("1977-03-02")!),
                       Human(name: "Guy", dob: Date.from("1978-04-12")!),
                       Human(name: "Jonny", dob: Date.from("1977-09-11")!),
                       Human(name: "Will", dob: Date.from("1978-07-31")!)]

// Accessing the array elements
let jamie = people[0]

// Generics allows you to handle types as templates
class Box<T> {
    var value: T?
    
    init(value: T? = nil) {
        self.value = value
    }
}

// Storing anything in the box
var intBox: Box<Int> = Box(value: 1)
var stringBox: Box<String> = Box(value: "1")
var boolBox: Box<Bool> = Box(value: true)

//: [Next](@next)
