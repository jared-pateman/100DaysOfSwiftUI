//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Jared Pateman on 21/10/2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Welcome to SnowSeeker!")
            .font(.largeTitle)
        
        Text("Please select a resort from the left-hand menu; swipe from the left edge to show it.")
            .foregroundColor(.secondary)
    }
}

#Preview {
    WelcomeView()
}
