//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Jared Pateman on 18/10/2023.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: geo.frame(in: .global).minY / fullView.size.height > 1 ? 1 : geo.frame(in: .global).minY / fullView.size.height, saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(geo.frame(in: .global).minY < 200 ? geo.frame(in: .global).minY / 200 : 1)
                            .scaleEffect(scaleView(midYAxis: geo.frame(in: .global).midY, globalMidY: fullView.frame(in: .global).midY))
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    
    func scaleView(midYAxis: CGFloat, globalMidY: CGFloat) -> CGFloat {
        var newScale = midYAxis / globalMidY
        
        if newScale > 2 {
            newScale = 2
        } else if newScale < 0.5 {
            newScale = 0.5
        }
        
        return newScale
    }
}

#Preview {
    ContentView()
}
