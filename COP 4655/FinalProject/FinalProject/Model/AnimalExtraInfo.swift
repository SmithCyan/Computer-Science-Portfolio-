//  AnimalExtraInfo.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/6/25.

import SwiftUI

struct AnimalExtraInfo: Codable {
    let image: String
    let diet: String
    let lifespan: String
    let habitat: String
    let geo_range: String
}

class LocalAnimalExtraInfo {
    static let shared = LocalAnimalExtraInfo()
    private var data: [String: AnimalExtraInfo] = [:]

    init() {
        if let url = Bundle.main.url(forResource: "AnimalInfo", withExtension: "json"),
           let json = try? Data(contentsOf: url) {
            data = (try? JSONDecoder().decode([String: AnimalExtraInfo].self, from: json)) ?? [:]
        }
}
    func info(for name: String) -> AnimalExtraInfo? {
          data[name]
      }
  }
