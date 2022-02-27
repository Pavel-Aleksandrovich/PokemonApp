//
//  PokemonsPresenter.swift
//  PokemonApp
//
//  Created by pavel mishanin on 27.02.2022.
//

import Foundation

protocol PokemonsListViewController: AnyObject {
    func showPokemons(pokemons: [Poke])
    func showError(error: ErrorMessage)
    func showProgress()
    func hideProgress()
    func hideError()
}

class PokemonsPresenter {
    
    private weak var controller: PokemonsListViewController?
    private let int = PokemonsInteractor()
    
    func onViewAttached(controller: PokemonsListViewController) {
        self.controller = controller
        controller.showProgress()
        
        int.fetchPokemons { pokemons in
            self.controller?.hideProgress()
            self.controller?.showPokemons(pokemons: pokemons)
        } onError: { error in
            self.controller?.hideProgress()
            self.controller?.showError(error: error)
        }
    }
    
    func onCellTapped(index: Int) {
        //router
    }
}
