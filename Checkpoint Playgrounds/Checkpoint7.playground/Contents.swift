import Cocoa

// Checkpoint 7 - https://www.hackingwithswift.com/quick-start/beginners/checkpoint-7

class Animal {
    let numberOfLegs: Int
    
    init(numberOfLegs: Int) {
        self.numberOfLegs = numberOfLegs
    }
}

let spider = Animal(numberOfLegs: 8)
print("A spider has \(spider.numberOfLegs) legs")


class Dog: Animal {
    func speak() {
        print("Woof!")
    }
    
    init() {
        super.init(numberOfLegs: 4)
    }
}

let dog = Dog()
dog.speak()
print("A dog has \(dog.numberOfLegs) legs")


class Poodle: Dog {
    override func speak() {
        print("Yap Yap!")
    }
}

let poodle = Poodle()
poodle.speak()
print("A poodle has \(poodle.numberOfLegs) legs")


class Corgi: Dog {
    override func speak() {
        print("Bark Bark!")
    }
}

let corgi = Corgi()
corgi.speak()
print("A corgi has \(corgi.numberOfLegs) legs")


class Cat: Animal {
    let isTame: Bool
    
    func speak() {
        print("Meow!")
    }
    
    init(isTame: Bool) {
        self.isTame = isTame
        super.init(numberOfLegs: 4)
    }
}

let cat = Cat(isTame: true)
cat.speak()
print("""
Cat
Tame: \(cat.isTame)
Number of Legs: \(cat.numberOfLegs)
""")


class Persian: Cat {
    override func speak() {
        print("Hiss!")
    }
    
    init() {
        super.init(isTame: true)
    }
}

let persian = Persian()
persian.speak()
print("""
Persian
Tame: \(persian.isTame)
Number of Legs: \(persian.numberOfLegs)
""")


class Lion: Cat {
    override func speak() {
        print("Roar!")
    }
    
    init() {
        super.init(isTame: false)
    }
}

let lion = Lion()
lion.speak()
print("""
Lion
Tame: \(lion.isTame)
Number of Legs: \(lion.numberOfLegs)
""")
