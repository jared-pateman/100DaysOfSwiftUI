//
//  AstronautView.swift
//  Moonshot
//
//  Created by Jared Pateman on 21/08/2023.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut

    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                    .accessibilityHidden(true)
                
                Text(astronaut.description)
                    .padding()
                    .accessibilityLabel("About \(astronaut.name)")
                    .accessibilityHint(astronaut.description)
            }
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts["armstrong"]!)
            .preferredColorScheme(.dark)
    }
}
