//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Jared Pateman on 06/09/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    @State private var predicateFilter = "BEGINSWITH"

    var body: some View {
        VStack {
            FilteredList(filter: lastNameFilter, predicate: predicateFilter)
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            Button("Show Begins With A") {
                lastNameFilter = "A"
                predicateFilter = "BEGINSWITH"
            }
            
            Button("Show Contains A") {
                lastNameFilter = "A"
                predicateFilter = "CONTAINS[c]"
            }
            
            Button("Show Begins With S") {
                lastNameFilter = "S"
                predicateFilter = "BEGINSWITH"
            }
            
            Button("Show Contains S") {
                lastNameFilter = "S"
                predicateFilter = "CONTAINS[c]"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
