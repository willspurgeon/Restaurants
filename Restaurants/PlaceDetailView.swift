//
//  PlaceDetailView.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/27/22.
//

import SwiftUI

struct PlaceDetailView: View {
    private let imageHeight: CGFloat = 300
    
    let restaurant: Place
    @ObservedObject var viewModel: RestaurantsViewModel
    
    var body: some View {
        ScrollView {
            AsyncImage(url: restaurant.mainPhotoUrl) { image in
                image
                    .resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(height: imageHeight)
            
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(restaurant.name ?? "")
                        .font(.title)
                    
                    Text(restaurant.vicinity ?? "")
                        .font(.caption)
                    
                    HStack() {
                        StarView(rating: restaurant.rating ?? 1, totalRatings: restaurant.userRatingsTotal ?? 0)
                        
                        if restaurant.openingHours?.openNow ?? false {
                            Text("Open Now")
                                .font(.caption)
                                .foregroundColor(.green)
                        } else {
                            Text("Closed")
                                .font(.caption)
                                .foregroundColor(.red)
                        }
                        
                        ExpenseView(priceLevel: restaurant.priceLevel)
                    }
                }
                .padding()
                .navigationTitle(restaurant.name ?? "")
                
                Spacer()
                
                FavoritedView(isFavorited: viewModel.favoritedPlaces.contains(restaurant.id), didTapHeart: {
                    viewModel.didFavoritePlace(placeId: restaurant.id)
                })
                .padding()
            }
        }
    }
}
