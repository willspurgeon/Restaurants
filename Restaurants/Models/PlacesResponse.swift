//
//  PlacesResponse.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/30/22.
//

import Foundation

struct PlacesResponse: Decodable, Equatable {
    let results: [Place]
    let errorMessage: String?
}
