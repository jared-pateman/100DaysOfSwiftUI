//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Jared Pateman on 02/08/2023.
//

import SwiftUI

struct ContentView: View {
    let possibleMoves = ["✊", "✋", "✌️"]
    @State private var computersMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var userScore = 0
    @State private var currentRound = 1
    @State private var showGameOver: Bool = false
    
    var correctAnswer: Int {
        if shouldWin == true {
            switch computersMove {
            case 2:
                return 0
            default:
                return computersMove + 1
            }
        } else {
            switch computersMove {
            case 0:
                return 2
            default:
                return computersMove - 1
            }
        }
    }
    
    var body: some View {
        ZStack {
            LinearGradient(stops: [
                .init(color: .red, location: 0.1),
                .init(color: .blue, location: 0.9)],
                startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            VStack {
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle.bold())
                    .foregroundColor(.primary)
                
                Spacer()
                
                Text("Round \(currentRound)/10")
                    .font(.title.weight(.semibold))
                    .foregroundColor(.primary)
                    .padding()
                
                VStack {
                    
                    Text("Current score: \(userScore)")
                        .font(.title.weight(.semibold))
                        .foregroundColor(.secondary)
                        .padding()
                    
                    Divider()
                                    
                    Group {
                        Text("Computer has chosen")
                        Text(possibleMoves[computersMove])
                            .font(.system(size: 75))
                        Text("Your aim is to \(shouldWin ? "win" : "lose")")
                            .padding()
                    }
                    .font(.system(size: 35).weight(.semibold))
                    .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    HStack {
                        ForEach(possibleMoves, id: \.self) { move in
                            Button(move) {
                                checkSelection(move)
                            }
                            .font(.system(size: 100))
                        }
                    }
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
            }
            .alert("Game Over!", isPresented: $showGameOver) {
                Button("New Game", action: restart)
            } message: {
                Text("You finished with a score of \(userScore)/10")
            }
            .padding()
        }
    }
    
    func checkSelection(_ userChoice: String) {
        var choiceValue = 0
        switch userChoice {
        case "✊":
            choiceValue = 0
        case "✋":
            choiceValue = 1
        case "✌️":
            choiceValue = 2
        default:
            choiceValue = 0
        }
        
        if choiceValue == correctAnswer {
            userScore += 1
        } else {
            userScore -= 1
        }
        
        if currentRound != 10 {
            newRound()
        } else {
            showGameOver.toggle()
        }
    }
    
    func newRound() {
        currentRound += 1
        computersMove = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func restart() {
        userScore = 0
        currentRound = 0
        newRound()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
