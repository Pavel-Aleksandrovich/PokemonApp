//
//  NetworkManager.swift
//  PokemonApp
//
//  Created by pavel mishanin on 23.02.2022.
//

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://pokeapi.co/api/v2/pokemon?limit=10"
    
    func getPokemons(page: Int = 10, completed: @escaping(Result<[Poke], ErrorMessage>) -> Void) {
        
        let endpoint = "https://pokeapi.co/api/v2/pokemon?limit=10" + "&offset=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Returns if error exists
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(PokemonList.self, from: data)
                let pokemons = response.results
                
                completed(.success(pokemons))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
}
