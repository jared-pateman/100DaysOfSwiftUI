//
//  ContentView.swift
//  Drawing
//
//  Created by Jared Pateman on 26/08/2023.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 75, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX + 75, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - 75, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX - 75, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

struct ColorCyclingRectangle: View {
    var amount = 0.0
    var steps: Int = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(LinearGradient(
                        colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    lineWidth: 2)
            }
        }
        .drawingGroup()
    }
    
    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount
        
        if targetHue > 1 {
            targetHue -= 1
        }
        
        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var lineThickness: Double = 5.0
    @State private var colorCycle = 0.0
    
    var body: some View {
        VStack {
            Text("Tap the arrow to change the line thickness")
                .font(.title2)
                .multilineTextAlignment(.center)
            Arrow()
                .stroke(Color.red, style: StrokeStyle(lineWidth: CGFloat(lineThickness), lineCap: .round, lineJoin: .round))
                .onTapGesture {
                    withAnimation {
                        if lineThickness < 25.0 {
                            lineThickness += 5.0
                        } else {
                            lineThickness = 5.0
                        }
                    }
                }
            
            Spacer()
            
            ColorCyclingRectangle(amount: colorCycle)
                .padding()
            
            Text("Slide to change the rectangle")
                .font(.title2)
    
            Slider(value: $colorCycle)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
