import Cocoa

// Checkpoint 5 - https://www.hackingwithswift.com/quick-start/beginners/checkpoint-5

let luckyNumbers = [7,4,38,21,16,15,12,33,31,49]

// 2 possible solutions that I came up with.

print("=== Solution 1 ===")
let _ = luckyNumbers.filter {!$0.isMultiple(of: 2)}
    .sorted()
    .map {"\($0) is a lucky number."}
    .forEach {print($0)}

print("=== Solution 2 ===")
luckyNumbers.filter {!$0.isMultiple(of: 2)}
    .sorted()
    .map {print("\($0) is a lucky number.")}
