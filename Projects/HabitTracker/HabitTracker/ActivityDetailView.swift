//
//  ActivityDetailView.swift
//  HabitTracker
//
//  Created by Jared Pateman on 27/08/2023.
//

import SwiftUI

struct ActivityDetailView: View {
    @ObservedObject var activities: Activities
    
    @State private var timesCompleted = 0
    var activity: Activity

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Text(activity.description)
                } header: {
                    Text("Description")
                }
                
                Section {
                    Stepper("Times Completed: \(timesCompleted)", value: $timesCompleted, in: 0...Int.max)
                } header: {
                    Text("Modify times completed")
                }
            }
        }
        .navigationBarTitle(activity.type)
        .navigationBarItems(trailing: Button("Update",action: updateActivity))
        .onAppear {
            timesCompleted = activity.timesCompleted
        }
    }
    
    func updateActivity() {
        if let activityIndex = activities.activities.firstIndex(where: { (activity) -> Bool in
            activity == self.activity
        }) {
            let newActivity = Activity(type: self.activity.type, description: self.activity.description, timesCompleted: self.timesCompleted)
            
            self.activities.activities[activityIndex] = newActivity
        }
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activities: Activities(), activity: Activity(type: "Test", description: "Testing", timesCompleted: 1))
    }
}
