//
//  ResponseStateTests.swift
//  HeroesDatabaseTests
//
//  Created by Deyvidy Luã F.S on 11/09/24.
//

import XCTest
@testable import HeroesDatabase

final class ResponseStateTests: XCTestCase {

    func testGetErrorMessageForError() {
        // Given the state is .error
        let state = ResponseState.error
        
        // When getting the error message
        let errorMessage = state.getErrorMessage()
        
        // Then the error message should match the expected value from constants
        XCTAssertEqual(errorMessage, ErrorMessages.somethingWentWrong)
    }
    
    func testGetErrorMessageForErrorNoResults() {
        // Given the state is .errorNoResults
        let state = ResponseState.errorNoResults
        
        // When getting the error message
        let errorMessage = state.getErrorMessage()
        
        // Then the error message should match the expected value from constants
        XCTAssertEqual(errorMessage, ErrorMessages.noEntriesFound)
    }
    
    func testGetErrorMessageForErrorNoNetwork() {
        // Given the state is .errorNoNetwork
        let state = ResponseState.errorNoNetwork
        
        // When getting the error message
        let errorMessage = state.getErrorMessage()
        
        // Then the error message should match the expected value from constants
        XCTAssertEqual(errorMessage, ErrorMessages.unableToReachDatabase)
    }
    
    func testGetErrorMessageForIdleState() {
        // Given the state is .idle
        let state = ResponseState.idle
        
        // When getting the error message
        let errorMessage = state.getErrorMessage()
        
        // Then the error message should be nil
        XCTAssertNil(errorMessage)
    }
    
    func testGetErrorMessageForLoadingState() {
        // Given the state is .loading
        let state = ResponseState.loading
        
        // When getting the error message
        let errorMessage = state.getErrorMessage()
        
        // Then the error message should be nil
        XCTAssertNil(errorMessage)
    }
    
    func testGetErrorMessageForLoadedState() {
        // Given the state is .loaded
        let state = ResponseState.loaded
        
        // When getting the error message
        let errorMessage = state.getErrorMessage()
        
        // Then the error message should be nil
        XCTAssertNil(errorMessage)
    }
}
