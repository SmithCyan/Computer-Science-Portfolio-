//  ZooAnimalDetailView.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/6/25.

import SwiftUI
import ParseSwift

struct ZooAnimalDetailView: View {

    let animal: ZooAnimal

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                // Large image
                AsyncImage(url: URL(string: animal.image_link)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                            .cornerRadius(20)
                            .shadow(radius: 10)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }
                
                // Name of the animal
                VStack(spacing: 4) {
                    Text(animal.name)
                        .font(.largeTitle)
                        .bold()
                        .multilineTextAlignment(.center)
                    if let latin = animal.latin_name {
                        Text(latin)
                            .italic()
                            .foregroundColor(.secondary)
                    }
                }
                if let type = animal.animal_type {
                    InfoRow(title: "Kingdom", value: type)
                }
                
                Divider()
                
                // information about the animals
                if let extra = LocalAnimalExtraInfo.shared.info(for: animal.name) {
                    InfoRow(title: "Diet", value: extra.diet)
                    InfoRow(title: "Lifespan", value: extra.lifespan)
                    InfoRow(title: "Habitat", value: extra.habitat)
                    InfoRow(title: "Geo Range", value: extra.geo_range)
                }
                
                Divider()
                
                // Fun facts about the animals
                if let fact = animal.fact {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Fun Fact")
                            .font(.title2)
                            .bold()
                        Text(fact)
                            .font(.body)
                            .foregroundColor(.primary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(LinearGradient(
                                colors: [Color.green.opacity(0.2), Color.blue.opacity(0.1)],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ))
                    )
                    .padding(.horizontal)
                }
                NavigationLink {
                    AnimalSoundsScreen()
                } label: {
                    Text("Play Animal Sounds")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationTitle(animal.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// Small reusable row for the information
struct InfoRow: View {
    let title: String
    let value: String?

    var body: some View {
        HStack {
            Text(title)
                .bold()
            Spacer()
            Text(value ?? "Unknown")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
        )
    }
}
