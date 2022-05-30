//
//  RestaurantsViewModel.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/26/22.
//

import Foundation
import MapKit
import Combine
import CoreTelephony

class RestaurantsViewModel: NSObject, ObservableObject {
    @Published var restaurants: [Place] = []
    @Published var currentLocation: CLLocationCoordinate2D?
    @Published var searchText: String = ""
    @Published var favoritedPlaces = Set<String>() // Set of Place ids.
    @Published var errorMessage: String?
    @Published var selectedPlace: Place?
    
    private let locationManager = CLLocationManager()
    
    let webService: Networking
    var subscriptions = Set<AnyCancellable>()
    
    init(webService: Networking) {
        self.webService = webService
        super.init()
        
        $searchText
            .debounce(for: 0.25, scheduler: DispatchQueue.main)
            .sink(receiveValue: { _ in
                Task {
                    await self.fetchRestaurants()
                }
            })
            .store(in: &subscriptions)
    }
    
    func fetchRestaurants() async {
        guard let currentLocation = currentLocation else { return }

        let response = await webService.fetchRestaurants(location: currentLocation, searchText: searchText)
        
        switch response {
        case .success(let restaurantsResponse):
            DispatchQueue.main.async {
                self.restaurants = restaurantsResponse.results
            }
        case .failure(let error):
            errorMessage = error.localizedDescription
        }
    }
    
    func requestLocationAuthorization() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
    }
    
    func didFavoritePlace(placeId: String) {
        if favoritedPlaces.contains(placeId) {
            favoritedPlaces.remove(placeId)
        } else {
            favoritedPlaces.insert(placeId)
        }
    }
}

extension RestaurantsViewModel: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        self.currentLocation = location.coordinate
        
        Task {
            await fetchRestaurants()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
