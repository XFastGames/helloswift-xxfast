/*:
 [Previous](@previous)
 ##  Object-oriented Programming
 In this section, we will look at how we can use swift in a object-oriented programming paradigm
 1. Protocols
 2. Inheritance
 3. Encapsulation
 4. Polymorphism
 
 [Next](@next)
 */
import Foundation

/*:
 ### Protocols
 protocols are abstract definitions that define sets of values, properties and/or methods. They are also called interfaces in other languages
 
 - Note: Protocols are purly signature definitions, no implementations!
 */

protocol Person {
    var name : String { get } // to denote that this property is read-only
    var inventory: [Any] { get set } // to denote that this property is read-write
    func say(message: String)
}

/*:
 An protocol needs to be implemented to be used
 * `<concrete-class> : <Protocol> { <class-body> }`
 
 Since `Human` is a `Person`, Human has to have a property for `name`, `inventory` and method implementation for `say`
 */

class Human : Person {
    var name: String
    var inventory: [Any] = []
    
    init(name:String) {
        self.name = name
    }
    
    func say(message: String) {
        print("\(name)\t: \(message)")
    }
}

/*:
 ### Inheritance
 Provides means of extending a defined class definitions
 * `<child-class> : <parent-class> { <class-body> }`
 */

class Caveman : Human {
    
    //: - Note: `Caveman` is extending `Human`, which already has the properties like `name` & `inventory` and implementation for methods for like `say`. Hence `Caveman` need not to redeclare it
    
    //: You can override any implementation (including the constructor) with a different implementation
    override init(name: String) {
        super.init(name: name)
        inventory = ["Club"]
    }
    
    /*:
     ### Encapsulation
     Members of a class definition can be encapsulated using the access modifiers.
     
     By default, all members are public and can be accessed outside of the defined scope
     */
    var tribe: String?
    
    //: They can be made private. by which these are no longer available outside the defined scope
    private var nails: Int = 2
    
    /*:
     Override is not limited to the constructor, any method implementations can be overriden to behave polymophic
     More on that later..
     */
    override func say(message: String) {
        super.say(message: "\(message).. i got \(nails) nails")
    }
}

/*:
 ### Polymorphism
 Any group of classes that has a **common** protocol and *implement that protocol **different** to one-another*, is said to be a polymorphic group of classes
 */
class Robot : Person {
    
    var name: String
    var inventory: [Any] = []
    
    init(name: String) {
        self.name = name
    }
    
    func say(message: String) {
        let sounds = message.split(separator: " ").joined(separator: " ** beep ** ")
        print("\(self.name)\t: \(sounds) * boop **")
    }
}

//: - Note: The reason why `Caveman` and `Robot` is polymorphic - because they both inherit/adhere to the `Person` protocl and implement protocol different to one-another, in this case with slightly different implementation for `say` method

//: Polymorphsim allows you to handle objects with their general types, yet let them behave with their specific implementations

let hosts: [Person] = [Caveman(name: "brady"), Robot(name: "grey")]

for host in hosts {
    host.say(message: "haha haha")
}
//: [Next](@next)
