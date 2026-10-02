//  AnimalFacts.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 11/30/25.
// Animal Model for Wildlife App

import SwiftUI


struct SpeciesSearchResponse: Codable {
    let results: [Species]
}
struct Species: Codable, Identifiable {
    let key : Int
    let scientificName: String?
    let canonicalName: String?
    let vernacularName: String?
    let kingdom: String?
    let phylum: String?
    let order: String?
    let family: String?
    let genus: String?
    let image: String?
    let fact: String?
    let habitat: String?
    let locations: [String]?
    
    var id : Int {key}
    
    var displayName: String {
        vernacularName ?? canonicalName ?? scientificName ?? "Unknown"
    }
}
   
    
