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
    
    func getErrorMessage() -> String? {
        switch self {
        case .error:
            return "Sorry, something went wrong."
        case .errorNoResults:
            return "No entries found."
        case .errorNoNetwork:
            return "Unable to reach the database."
        default:
            return nil
        }
    }
}
