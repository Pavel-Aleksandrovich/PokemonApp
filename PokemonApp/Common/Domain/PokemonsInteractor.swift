//
//  PokemonsInteractor.swift
//  PokemonApp
//
//  Created by pavel mishanin on 27.02.2022.
//

import Foundation

final class PokemonsInteractor {
    
    func fetchPokemons(onSuccess: @escaping ([Poke]) -> (),
                       onError: @escaping (ErrorMessage) -> ()) {
        
        NetworkManager.shared.getPokemons() { result in
            
            switch result {
            case.success(let pokemons):
                DispatchQueue.main.async {
                    onSuccess(pokemons)
                }
            case .failure(let error):
                onError(error)
            }
        }
    }
    
    func fetchPokemonByIndex(index: Int) {
        
    }
}
