//
//  ContentView-ViewModel.swift
//  FaceHint
//
//  Created by Jared Pateman on 01/10/2023.
//

import Foundation
import SwiftUI


@MainActor class ViewModel: ObservableObject {
    @Published private(set) var people: [Person]
    
    init() {
        do {
            let peopleData = try Data(contentsOf: FileManager.documentsDirectory.appendingPathComponent("FaceHint"))
            people = try JSONDecoder().decode([Person].self, from: peopleData)
        } catch {
            people = []
        }
    }
    
    func removePerson(at offsets: IndexSet) {
        self.people.remove(atOffsets: offsets)
        save()
    }
    
    func save() {
        do {
            let peopleInfo = try JSONEncoder().encode(self.people)
            try peopleInfo.write(to: FileManager.documentsDirectory.appendingPathComponent("FaceHint"), options: [.atomic, .completeFileProtection])
            print("Saved people information")
        } catch {
            print("Unable to save user info.")
        }
    }
    
    func savePerson(personName: String, saveImage: UIImage?) {
        if let jpegData = saveImage?.jpegData(compressionQuality: 0.8) {
            let newPerson = Person(name: personName, picture: jpegData)
            self.people.append(newPerson)
            save()
        }
    }
}

