//  AnimalPhoto.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/3/25.

import SwiftUI

struct SpeciesRow: View {
    let species: Species?
    let zooAnimal: ZooAnimal?
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            if let imageURL = species?.image ?? zooAnimal?.image_link,
               let url = URL(string: imageURL) {
                
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    default:
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.gray.opacity(0.2))
                            .frame(width: 80, height: 80)
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            )
                    }
                }
            } else {
                // Placeholder if no image is available
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "photo")
                            .foregroundColor(.gray)
                    )
            }
            
            VStack(alignment: .leading, spacing: 6) {
                // Name
                if let species = species {
                    Text(species.displayName)
                        .font(.headline)
                } else if let zoo = zooAnimal {
                    Text(zoo.name)
                        .font(.headline)
                } else {
                    Text("Unknown Animal")
                        .font(.headline)
                        .foregroundColor(.secondary)
                }
                
                // Optional fact
                if let fact = species?.fact ?? zooAnimal?.fact {
                    Text(fact)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
}
