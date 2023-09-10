//
//  ContentView.swift
//  FriendFace
//
//  Created by Jared Pateman on 09/09/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users: [User] = []
    
    var body: some View {
        NavigationView {
            List(cachedUsers) { user in
                NavigationLink {
                    UserDetailView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.wrappedName)
                            .font(.title)
                        
                        Text("Currently active: \(String(user.isActive))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if cachedUsers.isEmpty {
                    if let registeredUsers = await fetchUserInformation() {
                        users = registeredUsers
                    }
                    
                    await MainActor.run {
                        for user in users {
                            let userToSave = CachedUser(context: moc)
                            userToSave.id = user.id
                            userToSave.name = user.name
                            userToSave.isActive = user.isActive
                            userToSave.age = Int16(user.age)
                            userToSave.company = user.company
                            userToSave.email = user.email
                            userToSave.address = user.address
                            userToSave.about = user.about
                            userToSave.registered = user.registered
                            userToSave.tags = user.tags.joined(separator: ",")
                            
                            for friend in user.friends {
                                let friendToSave = CachedFriend(context: moc)
                                friendToSave.id = friend.id
                                friendToSave.name = friend.name
                                userToSave.addToFriends(friendToSave)
                            }
                            
                            try? moc.save()
                        }
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
