//
//  ErrorViewTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import HeroesDatabase

final class ErrorViewSnapshotTests: XCTestCase {

    // Test the snapshot for the error view with an error message and retry action
    func testErrorViewWithMessageAndRetryAction() {
        // Given: An error message and a retry action
        let view = ErrorView(errorMessage: "Something went wrong", retryAction: { print("Retry action triggered") })
        
        // Verify the snapshot for the error view with message and retry action
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the error view with an error message and no retry action
    func testErrorViewWithMessageNoRetryAction() {
        // Given: An error message but no retry action
        let view = ErrorView(errorMessage: "Something went wrong", retryAction: nil)
        
        // Verify the snapshot for the error view with message but no retry action
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the error view with no error message and no retry action
    func testErrorViewNoMessageNoRetryAction() {
        // Given: No error message and no retry action
        let view = ErrorView(errorMessage: nil, retryAction: nil)
        
        // Verify the snapshot for the error view with no message and no retry action
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot for the error view with no error message but with a retry action
    func testErrorViewNoMessageWithRetryAction() {
        // Given: No error message but with a retry action
        let view = ErrorView(errorMessage: nil, retryAction: { print("Retry action triggered") })
        
        // Verify the snapshot for the error view with no message but with retry action
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
