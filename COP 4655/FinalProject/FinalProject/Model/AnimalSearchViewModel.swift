//  AnimalSearch.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/6/25.

import SwiftUI
import Combine
import ParseSwift

@MainActor
class AnimalSearchViewModel: ObservableObject {
    @Published var animals: [ZooAnimal] = []
    @Published var isLoading = false
    
    private let apiKey = "UKEdhhSzC9fI9GXyy5kRZ8Y9A8hg3OqWzVxbLhV5"
    
    
    func searchAnimals(_ query: String) async {
        guard !query.isEmpty else {
            animals = []
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        if let fetchedAnimals = await fetchAnimalsFromAPI(query: query) {
            self.animals = fetchedAnimals
        } else {
            self.animals = []
        }
    }
    
    
    private func fetchAnimalsFromAPI(query: String) async -> [ZooAnimal]? {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.gbif.org/v1/species/search?q=\(encodedQuery)&limit=20"
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            struct GBIFResponse: Codable {
                let results: [Species]
            }
            
            let decoded = try JSONDecoder().decode(GBIFResponse.self, from: data)
            
            // Map Species -> ZooAnimal for your UI
            let zooAnimals = decoded.results.map { species -> ZooAnimal in
                ZooAnimal(
                    name: species.displayName,
                    latin_name: species.scientificName,
                    animal_type: species.kingdom,
                    diet: nil,
                    lifespan: nil,
                    geo_range: species.locations?.joined(separator: ", "),
                    habitat: species.habitat,
                    image_link: species.image ?? "",
                    fact: species.fact,
                    species: species
                )
            }
            
            return zooAnimals
        } catch {
            print("GBIF API error:", error)
            return nil
        }
    }
}
