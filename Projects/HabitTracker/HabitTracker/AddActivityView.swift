//
//  AddActivityView.swift
//  HabitTracker
//
//  Created by Jared Pateman on 27/08/2023.
//

import SwiftUI

struct AddActivityView: View {
    @ObservedObject var activities: Activities
    @Environment(\.dismiss) var dismiss

    @State private var title = ""
    @State private var description = ""
    @State private var timesCompleted = 0
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Activity", text: $title)
                TextField("Description", text: $description)
                Stepper("Times Completed: \(timesCompleted)", value: $timesCompleted, in: 0...Int.max)
            }
            .navigationTitle("Add Activity")
            .toolbar {
                Button("Save") {
                    if title == "" || description == "" {
                        alertTitle = "Missing Information!"
                        alertMessage = "You must enter a title or description."
                        showingAlert = true
                    } else {
                        let activity = Activity(type: title, description: description, timesCompleted: timesCompleted)
                        activities.activities.append(activity)
                        dismiss()
                    }
                }
            }
        }
        .alert(alertTitle, isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(alertMessage)
        }
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activities: Activities())
    }
}
