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
            return ErrorMessages.somethingWentWrong
        case .errorNoResults:
            return ErrorMessages.noEntriesFound
        case .errorNoNetwork:
            return ErrorMessages.unableToReachDatabase
        default:
            return nil
        }
    }
}
