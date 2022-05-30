//
//  MockWebService.swift
//  RestaurantsTests
//
//  Created by Will Spurgeon on 5/30/22.
//

@testable import Restaurants
import MapKit

class MockWebService: Networking {
    var shouldFail = false
    
    func fetchRestaurants(location: CLLocationCoordinate2D, searchText: String) async -> Result<PlacesResponse, Error> {
        
        if shouldFail {
            return .failure(WebError.requestFailed)
        } else {
            return .success(PlacesResponse(results: [.init(addressComponents: nil, formattedAddress: "123 Street Ave.", formattedPhoneNumber: "123-456-7890", name: "A Place", openingHours: nil, photos: [], priceLevel: .expensive, rating: 4.5, reviews: [], url: nil, userRatingsTotal: 123, website: nil, placeId: "123", geometry: nil, vicinity: nil)], errorMessage: nil))
        }
    }
}

enum WebError: Error {
    case requestFailed
}
