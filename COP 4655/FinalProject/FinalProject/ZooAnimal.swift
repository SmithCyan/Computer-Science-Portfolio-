//  ZooAnimal.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/3/25.


import SwiftUI

struct ZooAnimal: Codable, Identifiable {
    var id: UUID = UUID()
    let name: String
    let latin_name: String?
    let animal_type: String?
    let diet: String?
    let lifespan: String?
    let geo_range: String?
    let habitat: String?
    let image_link: String
    let fact: String?
    let species: Species?
    
    enum CodingKeys: String, CodingKey {
        case name
        case latin_name
        case animal_type
        case diet
        case lifespan
        case geo_range
        case habitat
        case image_link = "image"
        case fact
        case species
    }
}
    

