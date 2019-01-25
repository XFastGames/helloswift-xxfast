/*:
 ## Task 1
 
 ### 1.1 Collecting your data
 Silly Name Tester - A swifty throwback
 
 Create a program that reads the user's name and then responds with a message based on the given name. It shall do the following
 
 1. Print `What's your name?`
 2. Read the user's input
 3. If the name matches your name, then print `Awesome name`
 4. Otherwise, print `<name> is a silly, silly silly silly`(... 100 more times) ` name`
 */

import Foundation

print("What's your name? \t:")
var input:String = readLine() ?? "isuru"
if(input == "isuru"){
    print("Awesome name!")
}else{
    print("\(input) is a ", terminator:"")
    for _ in 1...99 {
        print("silly, ", terminator:"")
    }
    print("silly name")
}

/*:
 ### 1.2 Packaging your data
 
 structs are often used as data classes, of which the only purpose is to passively contain data with no business login associated with the given type.
 
 Extend the previous program and ask extra information from the user. Store the collected information inside of the following data structure. Additionally, implement the validate function with use a `guard` to ensure that the age is greater than or equal to 18 and less than 999
 */

struct Profile {
    let firstName: String
    let lastName: String
    let age: Int?
}

func validate(firstName: String, lastName:String, age:Int?) -> Profile? {
    guard let providedAge = age else {
        print("No age is provided")
        return nil
    }
    guard providedAge >= 18, providedAge < 999 else {
        print("Age is not in the required range")
        return nil
    }
    
    return Profile(firstName: firstName, lastName: lastName, age: providedAge)
}

print("What's your last name? \t:")
var lastName:String = readLine() ?? ""
print("What's your age? \t:")
var ageString:String = readLine() ?? ""
var age: Int? = Int(ageString)
let profile = validate(firstName: input, lastName: lastName, age: age)

if let validProfile = profile {
    print(validProfile)
} else {
    print("invalid profile")
}

/*:
 ## Task 2 Schrodinger's Cat 😼
 
 Schrodinger's Cat is a thought experiment physicists use to explain the uncertain nature of quantum states. According to [Wikipedia](https://en.wikipedia.org/wiki/Schrodinger%27s_cat),
 
 * Experiment:
 Schrödinger's cat; a **cat**, a **flask of poison**, and a radioactive source are placed in a **sealed box**. If an internal monitor (e.g. Geiger counter) detects radioactivity (i.e. a single atom decaying), the flask is shattered, releasing the poison, which kills the cat. The Copenhagen interpretation of quantum mechanics implies that after a while, the cat is simultaneously alive and dead. Yet, when one looks in the box, one sees the cat either alive or dead not both alive and dead. This poses the question of when exactly quantum superposition ends and reality collapses into one possibility or the other.
 
 - SeeAlso: watch this video explanation by [minute phyics](https://www.youtube.com/watch?v=IOYyCHGWJq4)
 
 For this task, we will adopt the Einstein's version of this famous thought experiment - i.e instead of the sealed box, it will be a sound-proof bunker; instead of the poison, it will be randomly detonated explosives. The cat will still be a cat however 🙀
 
 ### 2.1 Design the experiment
 1. You've been provided with a struct for the `Cat` and protocols for `Explosive` and `Bunker`. Use these protocols and complete the implementation.
 2. Implement the method body for `checkIfTheCatIsAlive` function
 */

struct Cat {
    let name: String
    //: - Note: nil to represent that cat is in a super-position, true and false means the cat is alive and not respectively.
    var isAlive: Bool?
}

protocol Explosive {
    //: - TODO: when detonated, the explosives should go off 50% of the time
    func detonate () -> Bool
}

protocol Bunker {
    //: - TODO: when initialising cat's `isAlive` should be set to nil, to represent that cat is in a super-position
    init(occupent: Cat, explosive: Explosive)
    
    var occupent: Cat { get set }
    var explosive: Explosive { get }
    
    //: - TODO: By the mere action of opening the bunker door, determines the state of the cat's life.
    func open()
}

func checkIfTheCatIsAlive(cat: Cat) {
    if let isTheCatAlive = cat.isAlive {
        if(isTheCatAlive){
            print("Its alive!!! 😸")
        } else {
            print("Oh no 😿")
        }
    } else {
        print("Its cat-tum superposition! 🤷‍♂️😼")
    }
}

class TNT : Explosive {
    func detonate() -> Bool {
        return arc4random_uniform(2) == 0
    }
}

class QuantumBunker : Bunker {
    
    var occupent: Cat
    var explosive: Explosive
    
    required init(occupent: Cat, explosive: Explosive) {
        self.occupent = occupent
        self.occupent.isAlive = nil
        self.explosive = explosive
    }
    
    func open() {
        occupent.isAlive = !explosive.detonate()
    }
}

/*:
 ### 2.2 Run the experiment
 Using the implementations of the protocols and the functions, write the following program
 
 Your program should do the following
 1. Create a 'living' cat named "Jellie"
 2. Create a TNT
 3. Create a Bunker and place Jellie and the TNT inside of the bunker,
 4. Query the state of the cat
 - Note:  at this point, the cat should be neither alive nor dead.
 5. Open the bunker to find out whether the explosives exploded or not (wave function collapsed!)
 6. Query the state of the cat,
 * if the cat is alive, print `Its alive!!!`
 * if the cat is dead, print `Oh no :(`
 - Note:  at this point, the cat should be either alive or dead; but not both
 */

let cat = Cat(name: "jellie", isAlive: true)
let tnt = TNT()
let bunker = QuantumBunker(occupent: cat, explosive: tnt)
checkIfTheCatIsAlive(cat: bunker.occupent)
bunker.open()
checkIfTheCatIsAlive(cat: bunker.occupent)

/*:
 ### 2.3 Tweaking the Experiment
 
 Implement the following protocol for `DangerousBunker` and re-write the program to make use of the new `DangerousBunker`'s implementation
 
 - Note: The difference of `DangerousBunker` compared to `Bunker` should be that,
 * The DangerousBunker takes in more than just one explosive
 * When one explosive is exploded on detonation, all explosives will explode as a chain reaction
 */

protocol DangerousBunker {
    init(occupent: Cat, explosives: [Explosive])
    var occupent: Cat { get set }
    var explosives: [Explosive] { get }
    func open()
}

//: - Note: Extra points if made use of higher order functions such as `.map` and `.reduce` to make the `open()` function as *functional* as possible

class DangerousQuantumBunker : DangerousBunker {
    
    required init(occupent: Cat, explosives: [Explosive]) {
        self.occupent = occupent
        self.occupent.isAlive = nil
        self.explosives = explosives
    }
    
    var occupent: Cat
    var explosives: [Explosive]
    
    func open() {
        occupent.isAlive = explosives
            .map { (explosive) -> Bool in explosive.detonate() }
            .reduce(true, { (result, outcome) -> Bool in
                result && !outcome
            })
    }
}

let tnts = [tnt, TNT(),TNT()]
let dangerousbunker = DangerousQuantumBunker(occupent: cat, explosives: [tnt])
checkIfTheCatIsAlive(cat: dangerousbunker.occupent)
dangerousbunker.open()
checkIfTheCatIsAlive(cat: dangerousbunker.occupent)
