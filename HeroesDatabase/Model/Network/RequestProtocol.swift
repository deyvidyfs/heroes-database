//
//  RequestProtocol.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation

protocol RequestProtocol {
    var url: String { get }
    var path: String { get }
    var method: String { get }
    var queryParameters: [String: String]? { get }
}
