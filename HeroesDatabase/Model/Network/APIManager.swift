//
//  APIManager.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation

protocol APIManagerProtocol {
    func buildRequest(_ requestModel: RequestProtocol) throws -> URLRequest
    func fetchResource<T: Decodable>(_: T.Type, urlRequest: URLRequest) async throws -> T
}

class APIManager: APIManagerProtocol {
    
    func buildRequest(_ requestModel: RequestProtocol) throws -> URLRequest {
        var urlComponents = URLComponents(string: requestModel.url + requestModel.path)

        urlComponents?.queryItems = getQueryItems(requestModel.queryParameters)

        guard let url = urlComponents?.url else {
            throw NetworkError.badURL("ERROR: Bad URL")
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadRevalidatingCacheData)
        urlRequest.httpMethod = requestModel.method

        return urlRequest
    }
    
    func fetchResource<T>(_: T.Type, urlRequest: URLRequest) async throws -> T where T: Decodable {
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.dataRequestError("ERROR: Bad Request")
        }
    }
    
    private func getQueryItems(_ queryParameters: [String:String]?) -> [URLQueryItem] {
        var parameters: [URLQueryItem] = []
        
        if let queryParameters = queryParameters {
            parameters.append(contentsOf: queryParameters.map {
                URLQueryItem(name: $0.key, value: $0.value)
            })
        }
        
        parameters.append(URLQueryItem(name: "apikey", value: AppSecrets.publicKey))
        parameters.append(URLQueryItem(name: "ts", value: AppSecrets.timestamp))
        parameters.append(URLQueryItem(name: "hash", value: AppSecrets.hash))

        return parameters
    }
}
