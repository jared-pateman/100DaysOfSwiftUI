//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Jared Pateman on 21/10/2023.
//

import SwiftUI

// Add modifier .phoneOnlyStackNavigationView() to NavigationView to make iPhones always stack.
extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    
    enum SortType {
        case alphabetical, country
    }
    
    @StateObject var favorites = Favorites()
    @State private var searchText = ""
    
    @State private var showingSortPicker = false
    @State private var sort: SortType = .alphabetical
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            return resorts
        } else {
            return resorts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var sortedFilteredResorts: [Resort] {
        switch sort {
        case .alphabetical:
            return filteredResorts.sorted { $0.name < $1.name }
        case .country:
            return filteredResorts.sorted { $0.country < $1.country }
        }
    }
    
    var body: some View {
        NavigationView {
            List(sortedFilteredResorts) { resort in
                NavigationLink {
                    ResortView(resort: resort)
                } label: {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundColor(.secondary)
                        }
                        
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        showingSortPicker = true
                    } label: {
                        Label("Sort by", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
            .confirmationDialog("Sort By", isPresented: $showingSortPicker) {
                Button("Name") {
                    sort = .alphabetical
                }
                
                Button("Country") {
                    sort = .country
                }
            }
            
            WelcomeView()
        }
        .environmentObject(favorites)
    }
}

#Preview {
    ContentView()
}
