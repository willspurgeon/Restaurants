//
//  WebService.swift
//  Restaurants
//
//  Created by Will Spurgeon on 5/26/22.
//

import Foundation
import CoreLocation

enum WebServiceError: Error {
    case couldNotBuildURL
}

protocol Networking {
    func fetchRestaurants(location: CLLocationCoordinate2D, searchText: String) async -> Result<PlacesResponse, Error>
}

class WebService: Networking {
    private let host = "maps.googleapis.com"
    static let apiKey = "AIzaSyDue_S6t9ybh_NqaeOJDkr1KC9a2ycUYuE"
    
    func fetchRestaurants(location: CLLocationCoordinate2D, searchText: String) async -> Result<PlacesResponse, Error> {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "maps.googleapis.com"
        components.path = "/maps/api/place/nearbysearch/json"
        components.queryItems = [
            URLQueryItem(name: "location", value: "\(location.latitude),\(location.longitude)"),
            URLQueryItem(name: "type", value: "restaurant"),
            URLQueryItem(name: "radius", value: "1500"),
            URLQueryItem(name: "key", value: WebService.apiKey)
        ]
        
        if !searchText.isEmpty {
            components.queryItems?.append(URLQueryItem(name: "keyword", value: searchText))
        }
        
        guard let url = components.url else { return .failure(WebServiceError.couldNotBuildURL) }
        
        do {
            let webResponse = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let response = try decoder.decode(PlacesResponse.self, from: webResponse.0)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }
}
