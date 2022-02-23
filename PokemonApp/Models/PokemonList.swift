//
//  PokemonList.swift
//  PokemonApp
//
//  Created by pavel mishanin on 23.02.2022.
//

import Foundation

struct PokemonList: Codable {
    let next: String?
    let results: [Poke]
}

struct Poke : Codable {
    let name: String
    let url: String
}
