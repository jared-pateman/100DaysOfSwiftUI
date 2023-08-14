//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Jared Pateman on 13/08/2023.
//

import SwiftUI

struct Question {
    var questionText: String
    var answer: Int
}

struct ContentView: View {
    @State private var timesTablesToPractice = 2
    @State private var questionAmount: Int = 10
    @State private var gameInProgress = false
    let questionAmountOptions = [5, 10, 20]
    
    @State private var questionsToAsk = [Question]()
    @State private var currentQuestion = 0
    @State private var currentScore = 0
    @State private var userAnswer = ""
    @FocusState private var answerIsFocused: Bool
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAnswer = false
    @State private var showingSummary = false

    var body: some View {
        NavigationView {
            if !gameInProgress {
                VStack {
                    Spacer()
                    
                    Text("Include up to times table")
                        .font(.title)
                    
                    Stepper("\(timesTablesToPractice)", value: $timesTablesToPractice, in: 2...12)
                        .padding()
                    
                    Spacer()
                    
                    Text("How many questions?")
                        .font(.title)
                    
                    Picker("How many questions?", selection: $questionAmount) {
                        ForEach(questionAmountOptions, id: \.self) {
                            Text("\($0) questions")
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    
                    Spacer()
                    
                    Button("Start Practice") {
                        withAnimation {
                            startPractice()
                        }
                    }
                    .frame(width: 150, height: 100)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                .navigationTitle("Times Tables")
            } else {
                VStack {
                    Text("Question number: \(currentQuestion + 1)")
                        .font(.largeTitle)
                        .padding()
                    
                    Divider()
                    
                    Text("Current score: \(currentScore)")
                        .font(.title2.bold())
                        .padding()
                    
                    Spacer()
                    
                    Text(questionsToAsk[currentQuestion].questionText)
                        .font(.title2)
                    
                    TextField("Answer", text: $userAnswer)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .focused($answerIsFocused)
                        .padding()
                    
                    Spacer()
                    
                    Button("Check Answer") {
                        checkAnswer(correctAnswer: questionsToAsk[currentQuestion].answer)
                    }
                    .frame(width: 150, height: 100)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                .navigationTitle("Times Tables")
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button("Done") {
                            answerIsFocused = false
                        }
                    }
                }
                .toolbar {
                    Button("Quit") {
                        withAnimation {
                            quitPractice()
                        }
                    }
                }
                .alert(alertTitle, isPresented: $showingAnswer) {
                    Button("OK", action: newQuestion)
                }
                .alert("Game Over!", isPresented: $showingSummary) {
                    Button("New Game", action: quitPractice)
                } message: {
                    Text("You got \(currentScore)/\(questionAmount) correct!")
                }
            }
        }
    }
    
    func startPractice() {
        questionsToAsk.removeAll()
        generateQuestions()
        userAnswer = ""
        currentScore = 0
        gameInProgress = true
    }
    
    func generateQuestions() {
        for _ in 1...questionAmount {
            let randomInt1 = Int.random(in: 1...timesTablesToPractice)
            let randomInt2 = Int.random(in: 1...12)
            let answer = randomInt1 * randomInt2
            let question = Question(questionText: "What is \(randomInt1) x \(randomInt2)?", answer: answer)
            
            questionsToAsk.append(question)
        }
    }
    
    func quitPractice() {
        userAnswer = ""
        questionsToAsk.removeAll()
        currentQuestion = 0
        currentScore = 0
        gameInProgress = false
    }
    
    func checkAnswer(correctAnswer: Int) {
        if Int(userAnswer) == correctAnswer {
            alertTitle = "Correct!"
            currentScore += 1
        } else {
            alertTitle = "Incorrect!"
        }
        
        if currentQuestion == questionAmount - 1 {
            showingSummary = true
        } else {
            showingAnswer = true
        }
    }
    
    func newQuestion() {
        userAnswer = ""
        currentQuestion += 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
