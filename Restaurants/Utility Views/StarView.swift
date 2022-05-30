//
//  StarView.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/30/22.
//

import SwiftUI

struct StarView: View {
    let rating: Double
    let totalRatings: Int
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...5, id: \.self) { starNum in
                if Int(rating) > starNum {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                        .foregroundColor(.yellow)
                } else {
                    Image(systemName: "star")
                        .font(.system(size: 14))
                        .foregroundColor(.yellow)
                }
            }
            
            Text("(\(totalRatings))")
                .font(.caption)
                .opacity(0.5)
        }
        .fixedSize(horizontal: true, vertical: true)
    }
}
