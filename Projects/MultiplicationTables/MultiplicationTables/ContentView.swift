//
//  ContentView.swift
//  MultiplicationTables
//
//  Created by Jared Pateman on 13/08/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var timesTablesToPractice = 2
    @State private var questionAmount: Int = 10
    @State private var gameInProgress = false
    let questionAmountOptions = [5, 10, 20]
    
    @State private var currentQuestion = 0
    @State private var multiplicationNumber1 = 0
    @State private var multiplicationNumber2 = 0
    @State private var currentScore = 0
    @State private var userAnswer = 0
    var correctAnswer: Int {
        multiplicationNumber1 * multiplicationNumber2
    }
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAnswer = false

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
                    Text("Question number: \(currentQuestion)")
                        .font(.largeTitle)
                        .padding()
                    
                    Divider()
                    
                    Text("Current score: \(currentScore)")
                        .font(.title2.bold())
                        .padding()
                    
                    Spacer()
                    
                    Text("What is \(multiplicationNumber1) x \(multiplicationNumber2)?")
                        .font(.title2)
                    
                    TextField("Answer", value: $userAnswer, format: .number)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(.roundedBorder)
                        .padding()
                    
                    Spacer()
                    
                    Button("Enter Guess") {
                        submitAnswer()
                    }
                    .frame(width: 150, height: 100)
                    .background(.blue)
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                }
                .navigationTitle("Times Tables")
                .toolbar {
                    Button("Quit") {
                        withAnimation {
                            quitPractice()
                        }
                    }
                }
                .alert(alertTitle, isPresented: $showingAnswer) {
                    Button(
                        currentQuestion < questionAmount ? "OK" : "Quit",
                        action: currentQuestion < questionAmount ? newQuestion : quitPractice)
                } message: {
                    Text("\(multiplicationNumber1) x \(multiplicationNumber2) = \(correctAnswer)")
                }
            }
        }
    }
    
    func startPractice() {
        currentQuestion = 1
        currentScore = 0
        
        multiplicationNumber1 = Int.random(in: 1...timesTablesToPractice)
        multiplicationNumber2 = Int.random(in: 1...12)
        
        gameInProgress = true
    }
    
    func quitPractice() {
        currentQuestion = 0
        currentScore = 0
        
        gameInProgress = false
    }
    
    func submitAnswer() {
        if userAnswer == correctAnswer {
            alertTitle = "Correct!"
            currentScore += 1
        } else {
            alertTitle = "Incorrect!"
            currentScore -= 1
        }
        
        showingAnswer = true
    }
    
    func newQuestion() {
        currentQuestion += 1
        
        multiplicationNumber1 = Int.random(in: 1...timesTablesToPractice)
        multiplicationNumber2 = Int.random(in: 1...12)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
