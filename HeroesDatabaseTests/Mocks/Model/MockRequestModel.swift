//
//  MockRequestModel.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import Foundation
@testable import HeroesDatabase

struct MockRequestModel: RequestProtocol {
    var url: String
    var path: String
    var method: String
    var queryParameters: [String : String]?
}

// URLProtocolMock for intercepting network requests in tests
class URLProtocolMock: URLProtocol {
    
    static var testURLs = [URL?: Data]()
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data))?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = URLProtocolMock.requestHandler else {
            fatalError("Request handler is not set.")
        }
        
        do {
            let (response, data) = try handler(request)
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        } catch {
            client?.urlProtocol(self, didFailWithError: error)
        }
        
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
