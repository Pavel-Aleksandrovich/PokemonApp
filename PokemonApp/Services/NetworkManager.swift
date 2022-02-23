//
//  NetworkManager.swift
//  PokemonApp
//
//  Created by pavel mishanin on 23.02.2022.
//

import Foundation

enum ObtainPostResult {
    case success(post: [Post])
    case failure(error: Error)
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let decoder = JSONDecoder()
    private let session = URLSession.shared
    
    func obtainPosts(completion: @escaping (ObtainPostResult) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        session.dataTask(with: url) { [ weak self ] data, response, error in
            
            var result: ObtainPostResult
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            if error == nil, let parsData = data {
                
                guard let post = try? self?.decoder.decode([Post].self, from: parsData) else {
                    result = .success(post: [])
                    return
                }
                result = .success(post: post)
                print("url")
            } else {
                result = .failure(error: error!)
            }
            
            
        }.resume()
    }
    
    let baseURL = "https://pokeapi.co/api/v2/pokemon?limit=10"
    
    
    func getPokemons(page:Int, completed: @escaping(Result<[Poke], ErrorMessage>) -> Void) {
        
        let endpoint = baseURL + "&offset=\(page)"
        
        // Returns if URL is invalid
        guard let url = URL(string: endpoint) else {
            print("err")
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            // Returns if error exists
            if let _ = error {
                print("err")
                
                completed(.failure(.unableToComplete))
                return
            }
            
            // Returns if response is not successful status code
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unableToComplete))
                print("err")
                
                return
            }
            
            // Returns if data is invalid
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            // Trys to decode data, throws failure if invalid
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(PokemonList.self, from: data)
                let pokemons = response.results
                
                completed(.success(pokemons))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
}
