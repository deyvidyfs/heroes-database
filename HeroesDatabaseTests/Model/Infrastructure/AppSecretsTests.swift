//
//  AppSecretsTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 10/09/24.
//

import XCTest
@testable import HeroesDatabase
import CryptoKit

final class AppSecretsTests: XCTestCase {

    func testGetKeys() {
        // Simulate reading the plist file by manually setting the values
        AppSecrets.getKeys()

        // Check if the keys are set correctly
        XCTAssertEqual(AppSecrets.publicKey, "[INSERT YOUR PUBLIC KEY HERE]")
        
        let expectedHash = Insecure.MD5.hash(data: Data("1[INSERT YOUR PRIVATE KEY HERE][INSERT YOUR PUBLIC KEY HERE]".utf8)).map {
            String(format: "%02hhx", $0)
        }.joined()

        XCTAssertEqual(AppSecrets.hash, expectedHash, "Hash should match the expected hash value")
    }
}
