//  ZooAnimalExtension.swift
//  FinalProject
//  Created by Nitsa Saint Fort on 12/6/25.

import Foundation

extension ZooAnimal {
    func mergedWithLocalInfo() -> ZooAnimal {
        guard let local = LocalAnimalExtraInfo.shared.info(for: self.name) else {
            return self
        }

        return ZooAnimal(
            id: self.id,
            name: self.name,
            latin_name: self.latin_name,
            animal_type: self.animal_type ?? species?.kingdom,
            diet: self.diet ?? local.diet,
            lifespan: self.lifespan ?? local.lifespan,
            geo_range: self.geo_range ?? local.geo_range,
            habitat: self.habitat ?? local.habitat,
            image_link: self.image_link.isEmpty ? local.image : self.image_link,
            fact: self.fact,
            species: self.species
        )
    }
}

