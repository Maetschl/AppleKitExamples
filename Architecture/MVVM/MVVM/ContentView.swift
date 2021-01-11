//
//  ContentView.swift
//  MVVM
//
//  Created by Julian Arias Maetschl on 11-01-21.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject var viewModel = PokemonListViewModel()
    
    var body: some View {
        VStack {
            ForEach(viewModel.pokemons) {
                Text("\($0.id): \($0.name)")
            }
            Button("All Pokemons", action: { self.viewModel.clearFilter() })
            Button("Fire type", action: { self.viewModel.filterBy(.fire) })
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
