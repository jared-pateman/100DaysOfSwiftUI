//
//  AddPersonView.swift
//  FaceHint
//
//  Created by Jared Pateman on 01/10/2023.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    
    @State private var personName = ""
    @State private var image: Image?
    @State private var showingImagePicker = false
    
    @State private var inputImage: UIImage?
    @State private var saveImage: UIImage?
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $personName)
                    .padding()
                
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    showingImagePicker = true
                }
            }
            .onChange(of: inputImage) { _ in loadImage() }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .toolbar {
                ToolbarItem(placement: .automatic) {
                    Button("Save") {
                        viewModel.savePerson(personName: personName, saveImage: saveImage)
                        dismiss()
                    }
                    .disabled(personName == "" || image == nil)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
        saveImage = inputImage
    }
}

//#Preview {
//    AddPersonView()
//}
