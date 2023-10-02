//
//  Person.swift
//  FaceHint
//
//  Created by Jared Pateman on 01/10/2023.
//

import Foundation
import SwiftUI

struct Person: Identifiable, Equatable, Codable, Comparable {
    var id = UUID()
    var name: String
    var picture: Data
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    func convert() -> Image {
        let uiImageData = picture
        if let uiImage = UIImage(data: uiImageData) {
            return Image(uiImage: uiImage)
        }
        return Image(systemName: "questionmark.square.dashed")
    }
}
