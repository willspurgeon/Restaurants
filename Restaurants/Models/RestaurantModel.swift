//
//  RestaurantModel.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/26/22.
//

import Foundation

struct Place: Decodable, Identifiable, Equatable {
    let addressComponents: [AddressComponent]?
    let formattedAddress: String?
    let formattedPhoneNumber: String?
    let name: String?
    let openingHours: PlaceOpeningHours?
    let photos: [PlacePhoto]?
    let priceLevel: PriceLevel?
    let rating: Double?
    let reviews: [Review]?
    let url: String?
    let userRatingsTotal: Int?
    let website: String?
    let placeId: String?
    let geometry: Geometry?
    let vicinity: String?
    
    var id: String {
        return placeId ?? UUID().uuidString
    }
}
