//
//  PokemonDetails.swift
//  PokemonApp
//
//  Created by pavel mishanin on 23.02.2022.
//

import UIKit

final class PokemonDetails: UIViewController {
    
    private let pokemonNameLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureLayout()
    }
    
    func configure(pokemon: Poke) {
        pokemonNameLabel.text = pokemon.name
    }
    
    private func configureLayout() {
        pokemonNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(pokemonNameLabel)
        
        NSLayoutConstraint.activate([
            pokemonNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonNameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
