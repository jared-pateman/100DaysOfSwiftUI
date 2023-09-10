//
//  UserDetailView.swift
//  FriendFace
//
//  Created by Jared Pateman on 09/09/2023.
//

import SwiftUI

struct UserDetailView: View {
    let user: CachedUser
    
    var body: some View {
        Form {
            Section {
                Text("Name: \(user.wrappedName)")
                Text("Age: \(user.age)")
                Text("Date Registered: \(user.wrappedRegistered.formatted(date: .abbreviated, time: .omitted))")
                Text("Company: \(user.wrappedCompany)")
            } header: {
                Text("User Information")
            }
            
            Section {
                Text("Email: \(user.wrappedEmail)")
                Text("Address: \(user.wrappedAddress)")
            } header: {
                Text("Contact Details")
            }
            
            Section {
                Text(user.wrappedAbout)
            } header: {
                Text("About")
            }
            
            Section {
                ForEach(user.friendsList) { friend in
                    Text(friend.wrappedName)
                }
            } header: {
                Text("Friends")
            }
        }
        .navigationTitle(user.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
    }
}
