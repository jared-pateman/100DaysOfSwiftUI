//
//  BookwomApp.swift
//  Bookwom
//
//  Created by Jared Pateman on 03/09/2023.
//

import SwiftUI

@main
struct BookwomApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
