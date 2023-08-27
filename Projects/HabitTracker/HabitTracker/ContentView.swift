//
//  ContentView.swift
//  HabitTracker
//
//  Created by Jared Pateman on 27/08/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    @State private var showingAddActivity = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(activities.activities) { activity in
                    NavigationLink {
                        ActivityDetailView(activities: activities, activity: activity)
                    } label: {
                        VStack(alignment: .leading) {
                            Text(activity.type)
                                .font(.headline)
                            
                            Text("Times Completed: \(activity.timesCompleted)")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: removeActivity)
            }
            .navigationTitle("Hobby Tracker")
            .toolbar {
                Button {
                    showingAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                AddActivityView(activities: activities)
            }
        }
    }
    
    func removeActivity(at offsets: IndexSet) {
        activities.activities.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
