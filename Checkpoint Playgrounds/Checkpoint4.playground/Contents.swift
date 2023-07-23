import Cocoa

// Checkpoint 4 - https://www.hackingwithswift.com/quick-start/beginners/checkpoint-4

enum numberError: Error {
    case outOfBounds, noRoot
}

func findSquareRoot(of number: Int) throws -> Int {
    if number < 1 || number > 10_000 {
        throw numberError.outOfBounds
    }
    for i in 1...100 {
        if i * i == number {
            return i
        }
    }
    throw numberError.noRoot
}

let numbersToTry: [Int] = [144, 7, 10_001, -2]
for number in numbersToTry {
    do {
        let result = try findSquareRoot(of: number)
        print("Square root of \(number) is \(result)")
    } catch numberError.noRoot {
        print("\(number) has no root!")
    } catch numberError.outOfBounds {
        print("\(number) is out of bounds! Please enter a number between 1 & 10,000")
    } catch {
        print("An unexpected error occurred.")
    }
}
