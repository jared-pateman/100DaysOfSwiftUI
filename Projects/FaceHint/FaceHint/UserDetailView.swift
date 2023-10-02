//
//  UserDetailView.swift
//  FaceHint
//
//  Created by Jared Pateman on 02/10/2023.
//

import SwiftUI
import MapKit

struct UserDetailView: View {
    let person: Person
    var personImage: Image {
        person.convert()
    }
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    var body: some View {
        VStack {
            personImage
                .resizable()
                .scaledToFit()
            
            Map(coordinateRegion: $mapRegion, annotationItems: [person]) { person in
                MapAnnotation(coordinate: person.coordinate) {
                    personImage
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                }
            }
        }
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
