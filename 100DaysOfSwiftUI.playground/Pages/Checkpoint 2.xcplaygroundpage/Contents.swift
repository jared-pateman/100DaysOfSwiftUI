import SwiftUI

// Checkpoint 2 - https://www.hackingwithswift.com/quick-start/beginners/checkpoint-2

let gameOfThronesNames: [String] = [
    "Jon",
    "Arya",
    "Sansa",
    "Eddard",
    "Robert",
    "Joffrey",
    "Jon",
    "Eddard",
    "Catelyn",
    "Daenarys",
    "Sansa"
]

print("There are \(gameOfThronesNames.count) Game of Thrones names in the array.")

let uniqueGameOfThronesNames = Set(gameOfThronesNames)

print("There are \(uniqueGameOfThronesNames.count) unique Game of Thrones names in the array.")
