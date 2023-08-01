//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Jared Pateman on 01/08/2023.
//

import SwiftUI

struct LargeBlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
    }
}

extension View {
    func largeBlueTitle() -> some View {
        modifier(LargeBlueTitle())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("Hello, world!")
                .largeBlueTitle()
            
            Spacer()
            
            Image(systemName: "globe")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.primary)
            
            Spacer()
            
            Text("Welcome to my app!")
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
