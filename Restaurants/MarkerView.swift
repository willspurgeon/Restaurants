//
//  MarkerView.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/27/22.
//

import SwiftUI

struct MarkerView: View {
    let restaurant: Place
    @ObservedObject var viewModel: RestaurantsViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            NavigationLink(destination: PlaceDetailView(restaurant: restaurant, viewModel: viewModel)) {
                Image(systemName: "mappin")
                    .font(.system(size: 30))
                    .tint(.green)
                
            }
            .onTapGesture {
                withAnimation {
                    viewModel.selectedPlace = restaurant
                }
            }
        }
    }
}

struct MarkerView_Preview: PreviewProvider {
    static let place: Place? = Place(addressComponents: nil, formattedAddress: "", formattedPhoneNumber: "", name: "A Nice Place to Eat", openingHours: nil, photos: [], priceLevel: .expensive, rating: 4.5, reviews: [], url: nil, userRatingsTotal: 23, website: nil, placeId: nil, geometry: nil, vicinity: nil)
    
    static var previews: some View {
        return MarkerView(restaurant: place!, viewModel: RestaurantsViewModel(webService: WebService()))
    }
}
