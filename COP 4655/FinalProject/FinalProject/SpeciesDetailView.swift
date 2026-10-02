//  SpeciesDetailView.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/3/25.

import SwiftUI

struct SpeciesDetailView: View {
    let zooAnimal: ZooAnimal

        // Merge local info
        private var animalWithLocalInfo: ZooAnimal {
            zooAnimal.mergedWithLocalInfo()
        }

        var body: some View {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    
                    // Image
                    if let url = URL(string: animalWithLocalInfo.image_link) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .success(let img):
                                img.resizable()
                                    .scaledToFit()
                                    .frame(maxHeight: 300)
                            default:
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 200)
                            }
                        }
                    }
                    
                    // Name
                    Text(animalWithLocalInfo.name)
                        .font(.largeTitle)
                        .bold()
                    
                    // Latin name
                    if let latin = animalWithLocalInfo.latin_name {
                        Text(latin)
                            .italic()
                            .foregroundColor(.secondary)
                    }
                    
                    Divider()
                    
                    // Extra info
                    VStack(spacing: 12) {
                        InfoRow(title: "Diet", value: animalWithLocalInfo.diet)
                        InfoRow(title: "Lifespan", value: animalWithLocalInfo.lifespan)
                        InfoRow(title: "Habitat", value: animalWithLocalInfo.habitat)
                        InfoRow(title: "Geo Range", value: animalWithLocalInfo.geo_range)
                    }
                    .padding(.horizontal)
                    
                    Divider()
                    
                    // Fun fact
                    if let fact = animalWithLocalInfo.fact {
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
                                .fill(Color.blue.opacity(0.1))
                        )
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                .padding()
            }
            .navigationTitle(animalWithLocalInfo.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    // Reusable info row
    struct DetailInfoRow: View {
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
