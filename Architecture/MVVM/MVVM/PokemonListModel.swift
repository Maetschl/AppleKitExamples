//
//  PokemonListModel.swift
//  MVVM
//
//  Created by Julian Arias Maetschl on 11-01-21.
//

import Foundation

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
