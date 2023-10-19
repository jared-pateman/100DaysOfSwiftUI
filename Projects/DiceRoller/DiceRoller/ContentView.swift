//
//  ContentView.swift
//  DiceRoller
//
//  Created by Jared Pateman on 18/10/2023.
//

import SwiftUI

struct DiceResults: Identifiable, Codable {
    var id = UUID()
    var rolls: [Int] = []
    var date = Date()
    var total: Int {
        var sum = 0
        for roll in rolls {
            sum += roll
        }
        return sum
    }
}

struct ContentView: View {
    @State private var possibleDice = [4, 6, 8, 10, 12, 20]
    @State private var numberOfDice: Double = 1
    @State private var diceSelection: Int = 0
    @State private var results: [DiceResults] = []
    @State private var currentRoll: [Int] = []
    
    var currentRollTotal: Int {
        var sum = 0
        for roll in currentRoll {
            sum += roll
        }
        return sum
    }
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("DiceRolls")
    
    var numberOfFaces: Int {
        possibleDice[diceSelection]
    }

    var body: some View {
        NavigationView {
            Form {
                Section("Settings") {
                    Picker("Number of Faces", selection: $diceSelection) {
                        ForEach(0..<possibleDice.count, id: \.self) { dice in
                            Text("\(possibleDice[dice])")
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Number of Dice: \(numberOfDice.formatted())")
                        Slider(value: $numberOfDice, in: 1...20, step: 1)
                    }
                    
                    
                    Button("Roll Dice") {
                        currentRoll = []
                        var newDiceRoll = DiceResults()
                        for _ in 1...Int(numberOfDice) {
                            let newResult = Int.random(in: 1...numberOfFaces)
                            currentRoll.append(newResult)
                        }
                        newDiceRoll.rolls = currentRoll
                        results.append(newDiceRoll)
                    }
                }
                
                if currentRoll != [] {
                    Section("Results") {
                        VStack {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                                ForEach(0..<currentRoll.count, id: \.self) { roll in
                                    DiceView(roll: currentRoll[roll])
                                }
                            }
                            
                            Text("Total rolled: \(currentRollTotal)")
                        }
                    }
                }
                
                Section("Previous Results") {
                    ForEach(results) { result in
                        VStack(alignment: .leading) {
                            LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
                                ForEach(0..<result.rolls.count, id: \.self) { roll in
                                    DiceView(roll: result.rolls[roll])
                                }
                            }
                            Text("Date: \(result.date.formatted(date: .long, time: .omitted))")
                            Text("Time: \(result.date.formatted(date: .omitted, time: .standard))")
                            Text("Total Rolled: \(result.total)")
                        }
                    }
                }
            }
            .navigationTitle("Dice Roller")
        }
    }
    
    func saveData() {
        do {
            let data = try JSONEncoder().encode(results)
            try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            results = try JSONDecoder().decode([DiceResults].self, from: data)
        } catch {
            results = []
        }
    }
}

#Preview {
    ContentView()
}
