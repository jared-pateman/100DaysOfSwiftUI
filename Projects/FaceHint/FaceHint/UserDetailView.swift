//
//  UserDetailView.swift
//  FaceHint
//
//  Created by Jared Pateman on 02/10/2023.
//

import SwiftUI

struct UserDetailView: View {
    let person: Person
    var personImage: Image {
        person.convert()
    }
    
    var body: some View {
        ScrollView {
            personImage
                .resizable()
                .scaledToFit()
        }
        .navigationTitle(person.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
