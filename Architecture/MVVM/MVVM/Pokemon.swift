//
//  Pokemon.swift
//  MVVM
//
//  Created by Julian Arias Maetschl on 11-01-21.
//

import Foundation

struct Pokemon: Identifiable {
    let id: Int
    let name: String
    let type: PokemonType
    let image: String
}

enum PokemonType {
    case fire
    case water
    case grass
    case none
}
