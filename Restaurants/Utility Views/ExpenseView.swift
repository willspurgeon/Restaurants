//
//  ExpenseView.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/30/22.
//

import SwiftUI

struct ExpenseView: View {
    let priceLevel: PriceLevel?
    
    var body: some View {
        Text(String(repeating: "$", count: priceLevel?.rawValue ?? 0))
            .font(.footnote)
            .foregroundColor(.gray)
    }
}
