//
//  AreaMapView.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/26/22.
//

import MapKit
import SwiftUI
import UIKit

struct AreaMapView: View {
    @State var mapRegion: MKCoordinateRegion
    let places: [Place]
    @ObservedObject var viewModel: RestaurantsViewModel
    
    init(location: CLLocationCoordinate2D, places: [Place], viewModel: RestaurantsViewModel) {
        self.places = places
        mapRegion = .init(center: location, span: .init(latitudeDelta: 0.02, longitudeDelta: 0.02))
        self.viewModel = viewModel
    }
    
    var body: some View {
        Map(coordinateRegion: $mapRegion, annotationItems: places) { place in
            MapAnnotation(coordinate: .init(latitude: place.geometry!.location.lat, longitude: place.geometry!.location.lng)) {
                MarkerView(restaurant: place, viewModel: viewModel)
            }
        }
    }
}
