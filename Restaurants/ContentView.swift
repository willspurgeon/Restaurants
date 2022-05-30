//
//  ContentView.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/26/22.
//

import SwiftUI

struct ContentView: View {
    @State var isDisplayingList = true
    @StateObject var viewModel = RestaurantsViewModel(webService: WebService())
    
    var body: some View {
        if let errorMessage = viewModel.errorMessage {
            ErrorView(errorText: errorMessage, retryClosure: {
                Task {
                    await viewModel.fetchRestaurants()
                }
            })
        } else {
            NavigationView {
                VStack {
                    GeometryReader { proxy in
                        ZStack {
                            if isDisplayingList {
                                List(viewModel.restaurants) { restaurantData in
                                    NavigationLink(destination: PlaceDetailView(restaurant: restaurantData, viewModel: viewModel)) {
                                        RestaurantCell(restaurantModel: restaurantData, isFavorited: viewModel.favoritedPlaces.contains(restaurantData.id),  didTapHeart: { viewModel.didFavoritePlace(placeId: restaurantData.id) })
                                    }
                                }
                                .refreshable {
                                    Task {
                                        await viewModel.fetchRestaurants()
                                    }
                                }
                                .searchable(text: $viewModel.searchText, prompt: "Search for a restaurant")
                                .toolbar() {
                                    ToolbarItem(placement: .principal) {
                                        HStack {
                                            Image("logo")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 30)
                                            Text("At Lunch")
                                                .font(.title)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                            } else if let currentLocation = viewModel.currentLocation {
                                AreaMapView(location: currentLocation, places: viewModel.restaurants, viewModel: viewModel)
                                    .ignoresSafeArea()
                                    .navigationViewStyle(.stack)
                            }
                            
                            ViewSwitchingView(isDisplayingList: $isDisplayingList, proxy: proxy)
                        }
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear() {
                viewModel.requestLocationAuthorization()
            }
        }
    }
}

struct ViewSwitchingView: View {
    @Binding var isDisplayingList: Bool
    let proxy: GeometryProxy
    
    var body: some View {
        Button(action: { isDisplayingList.toggle() }) {
            HStack() {
                Image(systemName: isDisplayingList ? "map": "list.bullet")
                Text(isDisplayingList ? "Map" : "List")
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(.green)
        .cornerRadius(8)
        .position(x: proxy.size.width / 2, y: proxy.size.height - 40)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
