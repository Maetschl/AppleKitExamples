//
//  ContentView.swift
//  MVVM
//
//  Created by Julian Arias Maetschl on 11-01-21.
//

import SwiftUI

struct PokemonImage: View {

    let id: Int
    @State private var image: Image = Image(systemName: "circle.fill")

    init(id: Int) {
        self.id = id
    }

    func loadImage() {
        let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            self.image = Image(uiImage: UIImage(data: data!)!)
        }.resume()
    }

    var body: some View {
        image
            .resizable()
            .interpolation(.none)
            .frame(width: 128, height: 128)
            .onAppear(perform: {
                loadImage()
            })
    }

}

struct ContentView: View {

    @ObservedObject var viewModel: PokemonListViewModel = PokemonListViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.pokemons) { pokemon in
                HStack {
                    PokemonImage(id: pokemon.id)
                    Text("#\(pokemon.id) - \(pokemon.name)")
                    Spacer()
                }
            }
            Button("All Pokemons", action: { self.viewModel.clearFilter() })
            Button("Fire type", action: { self.viewModel.filterBy(.fire) })
        }
        .padding()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
