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

struct ContentView: View {
    var body: some View {
        VStack {
            Arrow()
                .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
