//
//  AlamofireTestsTests.swift
//  AlamofireTestsTests
//
//  Created by Raphaël Payet on 26/06/2021.
//

import XCTest
@testable import AlamofireTests

class AlamofireServiceTests: XCTestCase {
    
    func testGivenIngredientsAreRiceAndChicken_WhenGettingRecipes_ThenRecipesAreNotNilAndErrorIsNil() {
        // Get ingredients from fake data
        let ingredients = FakeData.ingredients
        
        // Call the method
        let service = AlamofireService.shared
        let expectation = XCTestExpectation(description: "Success")
        service.getRecipes(with: ingredients) { _recipes, _error in
            // Test the end
            XCTAssertNotNil(_recipes)
            XCTAssertNil(_error)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
}
