//
//  ContentView.swift
//  FriendFace
//
//  Created by Jared Pateman on 09/09/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var users: [User] = []
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.title)
                        
                        Text("Currently active: \(String(user.isActive))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if users.isEmpty {
                    if let registeredUsers = await fetchUserInformation() {
                        users = registeredUsers
                    }
                }
            }
        }
    }
    
    func fetchUserInformation() async -> [User]? {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decodedUsers = try decoder.decode([User].self, from: data)
            
            return decodedUsers
        } catch {
            print("Error fetcing users: \(error.localizedDescription)")
        }
        
        return nil
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
