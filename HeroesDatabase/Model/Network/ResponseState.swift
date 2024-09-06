//
//  ResponseState.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation

enum ResponseState {
    case idle
    case loading
    case loaded
    case error
    case errorNoResults
    case errorNoNetwork
}
