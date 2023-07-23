import Cocoa

// Checkpoint 6 - https://www.hackingwithswift.com/quick-start/beginners/checkpoint-6

struct Car {
    let model: String
    let numberOfSeats: Int
    private(set) var currentGear: Int = 0 {
        didSet {
            print("\(self.model) gear changed to \(currentGear)")
        }
    }
    
    init(model: String, numberOfSeats: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
    }
    
    mutating func changeGear(to gear: Int) {
        if gear < 1 {
            print("Cannot change below gear 1.")
            self.currentGear = 1
        } else if gear > 10 {
            print("Cannot change above gear 10.")
            self.currentGear = 10
        } else {
            self.currentGear = gear
        }
    }
}

var focus = Car(model: "Ford Focus", numberOfSeats: 5)
focus.changeGear(to: 2)
focus.changeGear(to: 11)
focus.changeGear(to: 0)
focus.changeGear(to: 6)
print("\(focus.model) with \(focus.numberOfSeats) is in gear \(focus.currentGear)")
