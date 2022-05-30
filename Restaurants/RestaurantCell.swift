//
//  RestaurantCell.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/26/22.
//

import SwiftUI

struct RestaurantCell: View {
    let restaurantModel: Place
    let isFavorited: Bool
    let didTapHeart: () -> Void
    
    init(restaurantModel: Place, isFavorited: Bool, didTapHeart: @escaping () -> Void) {
        self.restaurantModel = restaurantModel
        self.isFavorited = isFavorited
        self.didTapHeart = didTapHeart
    }
    
    init(restaurantModel: Place) {
        self.restaurantModel = restaurantModel
        isFavorited = false
        didTapHeart = { }
    }
    
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: restaurantModel.mainPhotoUrl) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }.frame(width: 100, height: 100)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(restaurantModel.name ?? "")
                    .font(.title3)
                    .bold()
                
                StarView(rating: restaurantModel.rating ?? 1, totalRatings: restaurantModel.userRatingsTotal ?? 0)
                
                ExpenseView(priceLevel: restaurantModel.priceLevel)
                Spacer()
            }
            
            Spacer()
            
            FavoritedView(isFavorited: isFavorited, didTapHeart: didTapHeart)
        }
    }
}

extension Place {
    var mainPhotoUrl: URL? {
        guard let firstPhotoReference = photos?.first?.photoReference else { return nil }
        
        let urlString = "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=\(firstPhotoReference)&key=\(WebService.apiKey)"
        
        return URL(string: urlString)
    }
}
