//
//  RestaurantsTests.swift
//  RestaurantsTests
//
//  Created by Will Spurgeon on 5/26/22.
//

import XCTest
@testable import Restaurants

class RestaurantsTests: XCTestCase {
    var viewModel: RestaurantsViewModel?
    var webService = MockWebService()
    
    override func setUp() {
        viewModel = RestaurantsViewModel(webService: webService)
        viewModel?.currentLocation = .init(latitude: 123, longitude: 124)
    }

    func testFetchSetsResults() async throws {
        await viewModel?.fetchRestaurants()
        
        // Dispatch to the main queue to allow the changes to be made before we test.
        let expectation = XCTestExpectation()
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
        XCTAssertEqual(viewModel?.restaurants.count, 1)
        XCTAssertEqual(viewModel?.restaurants.first?.name, "A Place")
    }
    
    func testFetchErrorSetsErrorMessage() async throws {
        webService.shouldFail = true
        await viewModel?.fetchRestaurants()
        
        XCTAssertEqual(viewModel?.restaurants.count, 0)
        XCTAssertEqual(viewModel?.errorMessage, "The operation couldn’t be completed. (RestaurantsTests.WebError error 0.)")
    }
}
