//
//  ContentView.swift
//  FaceHint
//
//  Created by Jared Pateman on 01/10/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    @State private var showingAddPerson = false
    @State private var userImage: Image?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.people, id: \.id) { person in
                    NavigationLink {
                        UserDetailView(person: person)
                    } label: {
                        HStack {
                            person.convert()
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                            
                            Text(person.name)
                                .font(.title)
                        }
                    }
                }
                .onDelete { index in
                    viewModel.removePerson(at: index)
                }
            }
            .navigationTitle("FaceHint")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    showingAddPerson = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddPerson) {
                AddPersonView(viewModel: viewModel)
            }
        }
        .onAppear(perform: viewModel.locationFetcher.start)
    }
}

#Preview {
    ContentView()
}
