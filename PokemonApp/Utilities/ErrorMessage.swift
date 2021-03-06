//
//  ErrorMessage.swift
//  PokemonApp
//
//  Created by pavel mishanin on 23.02.2022.
//

import Foundation

enum ErrorMessage: String, Error {
    case invalidUrl = "Invalid Url. Please try again."
    case unableToComplete = "Unable to complete your request. Please try again"
    case invalidRespoinse = "Invalid response from the server. Please try again"
    case invalidData = "Invalid data from the server. Please try again."
}
