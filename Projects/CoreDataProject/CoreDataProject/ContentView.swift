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
    @State private var predicateFilter: FilterType = .beginsWith
    @State private var sortDescriptors: [SortDescriptor<Singer>] = []

    var body: some View {
        VStack {
            FilteredList(filter: lastNameFilter, predicate: predicateFilter, sortDescriptors: sortDescriptors)
            
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
                predicateFilter = .beginsWith
            }
            
            Button("Show Contains A") {
                lastNameFilter = "A"
                predicateFilter = .containsCaseInsenstitive
            }
            
            Button("Show Begins With S") {
                lastNameFilter = "S"
                predicateFilter = .beginsWith
            }
            
            Button("Show Contains S") {
                lastNameFilter = "S"
                predicateFilter = .containsCaseInsenstitive
            }
            
            Button("Sort alphabetically by last name") {
                sortDescriptors = [SortDescriptor(\.lastName)]
            }
            
            Button("Sort reverse alphabetically by last name") {
                sortDescriptors = [SortDescriptor(\.lastName, order: .reverse)]
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
