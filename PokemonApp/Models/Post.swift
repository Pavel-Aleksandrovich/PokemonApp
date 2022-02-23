//
//  Post.swift
//  PokemonApp
//
//  Created by pavel mishanin on 23.02.2022.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let postId: Int
    let title: String
    let body: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
    }
}
