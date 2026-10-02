//  AnimalImagesScreen.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/7/25.

import SwiftUI
struct AnimalImageScreen: View {
    let animal: Animal

    var body: some View {
        VStack {
            Text(animal.name)
                .font(.largeTitle)
                .bold()
                .padding()

            if let uiImage = UIImage(named: "\(animal.image).jpg") {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 400)
                    .cornerRadius(15)
                    .shadow(radius: 10)
            } else {
                // Placeholder if image not found
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxHeight: 200)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .navigationTitle(animal.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
