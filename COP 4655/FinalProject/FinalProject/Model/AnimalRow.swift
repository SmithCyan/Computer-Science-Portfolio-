//  AnimalSearch.swift
//  FinalProject
// Created by Nitsa Saint Fort on 11/26/25.

import SwiftUI

struct AnimalRow: View {
    let animal: ZooAnimal

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: animal.image_link)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                case .failure(_):
                    Image(systemName: "photo")
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 80, height: 80)
            .clipShape(RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading) {
                Text(animal.name)
                    .font(.headline)
                Text(animal.latin_name ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}




