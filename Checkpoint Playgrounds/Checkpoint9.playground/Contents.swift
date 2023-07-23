import Cocoa

// Checkpoint 9 - https://www.hackingwithswift.com/quick-start/beginners/checkpoint-9

let randomNumber = { (_ array: [Int]?) -> Int in array?.randomElement() ?? Int.random(in: 1...100)}

let randomInt = randomNumber(nil)
print(randomInt)

let intInArray = randomNumber([12,4_006,578,65_923])
print(intInArray)

let intInArray2 = randomNumber([42,1_000,555,12_345])
print(intInArray2)

let randomIntEmptyArray = randomNumber([])
print(randomIntEmptyArray)
