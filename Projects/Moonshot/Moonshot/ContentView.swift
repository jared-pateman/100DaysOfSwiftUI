//
//  ContentView.swift
//  Moonshot
//
//  Created by Jared Pateman on 16/08/2023.
//

import SwiftUI

struct ContentView: View {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    @State private var gridShowing = true
    
    var body: some View {
        NavigationView {
            Group {
                if gridShowing {
                    GridView(missions: missions, astronauts: astronauts)
                } else {
                    ListView(missions: missions, astronauts: astronauts)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                Button {
                    gridShowing.toggle()
                } label: {
                    Image(systemName: gridShowing ? "list.dash" : "square.grid.2x2")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
