//
//  APIManagerTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import XCTest
@testable import HeroesDatabase

final class APIManagerTests: XCTestCase {
    
    var apiManager: APIManager!
    
    override func setUpWithError() throws {
        // Initialize the APIManager
        apiManager = APIManager()
    }
    
    override func tearDownWithError() throws {
        // Tear down resources after each test
        apiManager = nil
    }
    
    func testBuildRequestSuccess() throws {
        // Given a mock request model
        let requestModel = MockRequestModel(url: "https://example.com", path: "/characters", method: "GET", queryParameters: ["name": "Spider-Man"])
        
        // When building the request
        let request = try apiManager.buildRequest(requestModel)
        
        // Then assert the request is correct
        XCTAssertEqual(request.url?.absoluteString, "https://example.com/characters?name=Spider-Man&apikey=%5BINSERT%20YOUR%20PUBLIC%20KEY%20HERE%5D&ts=1&hash=\(AppSecrets.hash)")
        XCTAssertEqual(request.httpMethod, "GET")
    }
    
    func testFetchResourceSuccess() async throws {
        // Given a mock request and expected response data
        let requestModel = MockRequestModel(url: "https://example.com", path: "/characters", method: "GET", queryParameters: ["name": "Spider-Man"])
        let urlRequest = try apiManager.buildRequest(requestModel)
        
        // Use URLProtocol to mock URLSession data
        let mockData = try JSONEncoder().encode(MockFetchCharactersResponse.sample) // Encoding mock response
        URLProtocolMock.requestHandler = { request in
            guard let url = request.url, url == urlRequest.url else {
                throw NetworkError.dataRequestError("ERROR: Bad Request")
            }
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, mockData)
        }
        
        // Register the mock URLProtocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        
        // When fetching the resource
        let (data, _) = try await session.data(for: urlRequest)
        let response = try JSONDecoder().decode(FetchCharactersResponse.self, from: data)
        
        // Then assert the fetched response is correct
        XCTAssertEqual(response.data.results.count, MockCharacterResponse.sampleList.count)
    }
    
    func testFetchResourceFailure() async throws {
        // Given a mock request and URLProtocol mock to simulate an error
        let requestModel = MockRequestModel(url: "https://example.com", path: "/characters", method: "GET", queryParameters: ["name": "Spider-Man"])
        let urlRequest = try! apiManager.buildRequest(requestModel)
        
        URLProtocolMock.requestHandler = { _ in
            throw NetworkError.dataRequestError("ERROR: Bad Request")
        }
        
        // Register the mock URLProtocol
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        
        let apiManagerWithMockSession = APIManager()

        // When fetching the resource and expecting a failure
        do {
            let _: FetchCharactersResponse = try await apiManagerWithMockSession.fetchResource(FetchCharactersResponse.self, urlRequest: urlRequest)
            XCTFail("Expected to throw but didn't")
        } catch {
            XCTAssertEqual(error as? NetworkError, NetworkError.dataRequestError("ERROR: Bad Request"))
        }
    }
}
