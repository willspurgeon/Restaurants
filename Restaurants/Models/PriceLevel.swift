//
//  PriceLevel.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/30/22.
//

import Foundation

enum PriceLevel: Int, Decodable, Equatable {
    case free = 0
    case inexpensive = 1
    case moderate = 2
    case expensive = 3
    case veryExpensive = 4
}
