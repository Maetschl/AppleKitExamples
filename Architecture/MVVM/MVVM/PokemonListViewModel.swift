//
//  PokemonListViewModel.swift
//  MVVM
//
//  Created by Julian Arias Maetschl on 11-01-21.
//

import Combine

class PokemonListViewModel: ObservableObject {

    // MARK: Private objects
    private var model: PokemonListModelProtocol

    // MARK: Published objects
    @Published var pokemons: [Pokemon]


    // MARK: Trigger objects
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

    // MARK: Init
    init(model: PokemonListModelProtocol = PokemonListModel()) {
        self.model = model
        self.pokemons = model.pokemons
    }

    // MARK: Methods
    func clearFilter() {
        selectedFilter = .none
    }

    func filterBy(_ filter: PokemonType) {
        selectedFilter = .fire
    }

}
