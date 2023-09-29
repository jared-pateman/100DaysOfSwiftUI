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
    @State private var flagChosen = -1
    @State private var modifyFlags = false
    
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
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
    ]
    
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
                            withAnimation {
                                flagTapped(number)
                            }
                        } label: {
                            FlagImage(flagName: countries[number])
                                .accessibilityLabel(labels[countries[number], default: "Uknown Flag"])
                        }
                        .rotation3DEffect(.degrees(flagChosen == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(modifyFlags && flagChosen != number ? 0.25 : 1)
                        .scaleEffect(modifyFlags && flagChosen != number ? 0.50 : 1)
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
        flagChosen = number
        modifyFlags = true
        
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
        flagChosen = -1
        modifyFlags = false
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
