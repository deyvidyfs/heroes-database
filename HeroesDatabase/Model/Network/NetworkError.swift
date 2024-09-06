//
//  NetworkError.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation

enum NetworkError: Error {
    case dataRequestError(String)
    case badURL(String)
    case badNetwork(String)
}
