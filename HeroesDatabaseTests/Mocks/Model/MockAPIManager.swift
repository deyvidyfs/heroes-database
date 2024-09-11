//
//  MockAPIManager.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import Foundation
@testable import HeroesDatabase

// Mock APIManager for testing purposes
class MockAPIManager: APIManagerProtocol {
    
    var shouldThrowError = false
    
    // Mock buildRequest method
    func buildRequest(_ requestModel: RequestProtocol) throws -> URLRequest {
        guard let url = URL(string: requestModel.url + requestModel.path) else {
            throw NetworkError.badURL("Mock: Bad URL")
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = requestModel.method
        return request
    }
    
    // Mock fetchResource method
    func fetchResource<T: Decodable>(_ type: T.Type, urlRequest: URLRequest) async throws -> T {
        if shouldThrowError {
            throw NetworkError.dataRequestError("Mock: Data fetch error")
        }
        
        if type == FetchCharactersResponse.self {
            return MockFetchCharactersResponse.sample as! T
        } else if type == SearchCharactersResponse.self {
            return MockSearchCharactersResponse.sample as! T
        }
        throw NetworkError.dataRequestError("Mock: Unknown error")
    }
}
