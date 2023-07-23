import Cocoa

// Checkpoint 8 - https://www.hackingwithswift.com/quick-start/beginners/checkpoint-8

protocol Building {
    var numberOfRooms: Int { get set }
    var price: Int { get set }
    var estateAgent: String { get set }
    func salesSummary()
}

extension Building {
    func salesSummary() {
        print("\(Self.self) with \(numberOfRooms) rooms for sale by \"\(estateAgent)\". Price: £\(price)")
    }
}

struct House: Building {
    var numberOfRooms: Int
    var price: Int
    var estateAgent: String
}

let houseForSale = House(numberOfRooms: 4, price: 250_000, estateAgent: "Homes 4 Sale")
houseForSale.salesSummary()


struct Office: Building {
    var numberOfRooms: Int
    var price: Int
    var estateAgent: String
}

let officeForSale = Office(numberOfRooms: 50, price: 500_000, estateAgent: "Offices 4 U")
officeForSale.salesSummary()
