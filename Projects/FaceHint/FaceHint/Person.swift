//
//  Person.swift
//  FaceHint
//
//  Created by Jared Pateman on 01/10/2023.
//

import Foundation
import SwiftUI
import CoreLocation

struct Person: Identifiable, Equatable, Codable, Comparable {
    var id = UUID()
    var name: String
    var picture: Data
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
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
