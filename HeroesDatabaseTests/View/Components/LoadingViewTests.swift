//
//  LoadingViewTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
import SnapshotTesting
import SwiftUI
@testable import HeroesDatabase

final class LoadingViewSnapshotTests: XCTestCase {

    // Test the snapshot when the text is provided
    func testLoadingViewWithText() {
        // Given: A LoadingView with some text
        let view = LoadingView(text: "Loading characters...")
        
        // Verify the snapshot for the view with text
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot when the text is nil
    func testLoadingViewWithoutText() {
        // Given: A LoadingView without any text
        let view = LoadingView(text: nil)
        
        // Verify the snapshot for the view without text
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }
}
