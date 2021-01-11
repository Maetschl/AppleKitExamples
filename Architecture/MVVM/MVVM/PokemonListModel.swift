//
//  PokemonListModel.swift
//  MVVM
//
//  Created by Julian Arias Maetschl on 11-01-21.
//

import SwiftUI

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

class PokemonListViewModel: ObservableObject {

    @State var model: PokemonListModelProtocol

    var selectedFilter: PokemonType = .none {
        didSet {
            switch selectedFilter {
            case .none:
                pokemons = model.pokemons
            default:
                pokemons = model.pokemons.filter({ $0.type == selectedFilter })
            }
        }
    }

    @Published var pokemons: [Pokemon]

    init(model: PokemonListModelProtocol = PokemonListModel()) {
        self.model = model
        self.pokemons = model.pokemons
    }

    func clearFilter() {
        selectedFilter = .none
    }

    func filterBy(_ filter: PokemonType) {
        selectedFilter = .fire
    }

}

protocol PokemonListModelProtocol {
    var pokemons: [Pokemon] { get }
}

struct PokemonListModel: PokemonListModelProtocol {
    var pokemons: [Pokemon] = [
        Pokemon(
            id: 1,
            name: "Bulbasaur",
            type: .grass,
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
        ),
        Pokemon(
            id: 4,
            name: "Charmander",
            type: .fire,
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png"
        ),
        Pokemon(
            id: 7,
            name: "Squirtle",
            type: .water,
            image: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png"
        )
    ]
}
