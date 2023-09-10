//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by Jared Pateman on 09/09/2023.
//

import SwiftUI

@main
struct FriendFaceApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
