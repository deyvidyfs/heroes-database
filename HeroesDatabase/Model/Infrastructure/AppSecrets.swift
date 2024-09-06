//
//  AppSecrets.swift
//  HeroesDatabase
//
//  Created by Deyvidy Luã F.S on 06/09/24.
//

import Foundation
import CryptoKit

struct AppSecretsKeys: Decodable {
    let publicKey: String
    let privateKey: String
}

class AppSecrets {
    
    private static var privateKey = ""
    
    static var publicKey = ""
    static var timestamp = "1"
    static var hash = ""
    
    static func getKeys() {
        if let url = Bundle.main.url(forResource: "AppSecrets", withExtension: ".plist") {
            do {
                let data = try Data(contentsOf: url)
                let properties = try PropertyListDecoder().decode(AppSecretsKeys.self, from: data)
                
                publicKey = properties.publicKey
                privateKey = properties.privateKey
                getHash()
                
            } catch {
                print("ERROR: Unable to read API keys: ", error)
            }
        }
    }
    
    private static func getHash() {
        let hashString = timestamp + privateKey + publicKey
        let digest = Insecure.MD5.hash(data: Data(hashString.utf8))

        hash = digest.map {
            String(format: "%02hhx", $0)
        }.joined()
    }
}
