//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Jared Pateman on 22/10/2023.
//

import Foundation

class Favorites: ObservableObject {
    // The actual resorts that the user has favourited.
    private var resorts: Set<String>
    
    // Key we're using to read/write to with UserDefaults.
    private let saveKey = FileManager.documentsDirectory.appendingPathComponent("Favorites")
    
    init() {
        do {
            let data = try Data(contentsOf: saveKey)
            let decoded = try JSONDecoder().decode(Set<String>.self, from: data)
            resorts = decoded
        } catch {
            resorts = []
        }
    }
    
    // Return true if resort is in the resorts set.
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    // Add a resort to the resorts set.
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    // Remove a resort from the resorts set.
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // Write data to device.
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: saveKey, options: [.atomicWrite, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}
