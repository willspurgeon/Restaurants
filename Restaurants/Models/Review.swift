//
//  Review.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/30/22.
//

import Foundation

struct Review: Decodable, Equatable {
    let authorName: String
    let rating: Double
    let relativeTimeDescription: String
    let text: String?
}
