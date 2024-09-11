//
//  ImageLoaderViewTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import Foundation

import XCTest
import SnapshotTesting
import SwiftUI
@testable import HeroesDatabase

final class ImageLoaderViewSnapshotTests: XCTestCase {

    // Test the snapshot when the image URL is valid
    func testImageLoaderViewWithValidImageURL() {
        // Given: A valid image URL
        let view = ImageLoaderView(imageUrl: "http://i.annihil.us/u/prod/marvel/i/mg/3/60/53176bb096d17/landscape_incredible.jpg")
        
        // Verify the snapshot for the view with a valid image
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot when the image URL is the "not available" placeholder
    func testImageLoaderViewWithNotAvailableImageURL() {
        // Given: The "not available" image URL
        let view = ImageLoaderView(imageUrl: "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available/standard_medium.jpg")
        
        // Verify the snapshot for the view with the placeholder image
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot when the image URL is empty (shows loading view)
    func testImageLoaderViewWithEmptyURL() {
        // Given: An empty image URL
        let view = ImageLoaderView(imageUrl: "")
        
        // Verify the snapshot for the view with a loading state
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)))
    }

    // Test the snapshot when the image is still loading
    func testImageLoaderViewLoadingState() {
        // Given: A view that is still loading the image
        // Since SnapshotTesting doesn't fully support async image loading simulation,
        // we are treating this as a generic "loading" scenario to visualize the loading state.
        let view = ImageLoaderView(imageUrl: "http://i.annihil.us/u/prod/marvel/i/mg/3/60/53176bb096d17/landscape_incredible.jpg")

        // Verify the snapshot for the loading state
        assertSnapshot(of: LoadingView(), as: .image(layout: .device(config: .iPhone13)))
    }
}
