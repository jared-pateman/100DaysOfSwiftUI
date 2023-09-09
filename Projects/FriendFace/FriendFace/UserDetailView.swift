//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Jared Pateman on 09/09/2023.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    
    var body: some View {
        Form {
            Section {
                Text("Name: \(user.name)")
                Text("Age: \(user.age)")
                Text("Date Registered: \(user.registered.formatted(date: .abbreviated, time: .omitted))")
                Text("Company: \(user.company)")
            } header: {
                Text("User Information")
            }
            
            Section {
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
            } header: {
                Text("Contact Details")
            }
            
            Section {
                Text(user.about)
            } header: {
                Text("About")
            }
            
            Section {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            } header: {
                Text("Friends")
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
