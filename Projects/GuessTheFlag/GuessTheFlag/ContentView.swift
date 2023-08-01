//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jared Pateman on 28/07/2023.
//

import SwiftUI

struct FlagImage: View {
    var flagName: String
    
    var body: some View {
        Image(flagName)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingSummary = false
    @State private var scoreTitle = ""
    @State private var currentScore = 0
    @State private var questionsAsked = 1
    
    @State private var countries = [
        "Estonia",
        "France",
        "Germany",
        "Ireland",
        "Italy",
        "Nigeria",
        "Poland",
        "Russia",
        "Spain",
        "UK",
        "US"
    ].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)],
                center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Question \(questionsAsked)/8")
                            .foregroundStyle(.secondary)
                            .font(.title3.weight(.heavy))
                            .padding()
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(flagName: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score \(currentScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(currentScore)")
        }
        .alert("Game Over!", isPresented: $showingSummary) {
            Button("Restart", action: restartGame)
        } message: {
            Text("You finished with a score of \(currentScore).\n\(judgeScore())")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            currentScore += 1
            scoreTitle = "Correct! That is the flag of \(countries[number])"
        } else {
            currentScore -= 1
            scoreTitle = "Wrong! That is the flag of \(countries[number])"
        }
        
        if questionsAsked == 8 {
            showingSummary = true
        } else {
            showingScore = true
        }
    }
    
    func askQuestion() {
        questionsAsked += 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func restartGame() {
        questionsAsked = 0
        currentScore = 0
        askQuestion()
    }
    
    func judgeScore() -> String {
        switch currentScore {
        case ...0:
            return "You need to do some flag revision!"
        case 1...3:
            return "Not bad, but you can do better."
        case 4...6:
            return "That's a pretty good score!"
        case 6...7:
            return "So close to getting them all. Why not try again?"
        default:
            return "🎉 Perfect Score! Well done! 🎉"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
