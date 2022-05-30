//
//  FavoritedView.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/30/22.
//

import SwiftUI

struct FavoritedView: View {
    let isFavorited: Bool
    let didTapHeart: () -> Void
    
    var body: some View {
        Image(systemName: isFavorited ? "heart.fill" : "heart")
            .font(.system(size: 24))
            .foregroundColor(.green)
            .onTapGesture {
                withAnimation {
                    didTapHeart()
                }
            }
    }
}
