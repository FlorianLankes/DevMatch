//
//  MapViewModel.swift
//  DevMatch
//
//  Created by Florian Lankes on 24.07.24.
//

import Combine
import Foundation
import MapKit
import SwiftUI

class MapViewModel: ObservableObject {
    @Published var jobs: [ArbeitsagenturSearchResult.Stellenangebot] = []
    
    @Published var mapCameraPosition: MapCameraPosition = .automatic
    @Published var route: MKRoute?
    
    @Published var destinationName: String = ""
    private let locationService = LocationService()
    private var cancelBag = Set<AnyCancellable>()
    private var lastKnownCoordinate: CLLocationCoordinate2D?
    
    init() {
        self.locationService.requestLocationUpdates()
        self.locationService.$lastKnownLocation
            .sink { location in
                if let location {
                    self.lastKnownCoordinate = location.coordinate
                    self.mapCameraPosition = .camera(.init(centerCoordinate: location.coordinate, distance: 2500))
                }
            }
            .store(in: &cancelBag)
    }
    
    @MainActor
    func fetchRoute() {
        if let lastKnownCoordinate = self.lastKnownCoordinate {
            let request = MKDirections.Request()
            
            Task {
                let destinations = try await CLGeocoder().geocodeAddressString(destinationName)
                if let firstPlacemark = destinations.first {
                    request.source = MKMapItem(placemark: MKPlacemark(coordinate: lastKnownCoordinate))
                    request.destination = MKMapItem(placemark: MKPlacemark(placemark: firstPlacemark))
                    request.transportType = .automobile
                    
                    let result = try? await MKDirections(request: request).calculate()
                    self.route = result?.routes.first
                }
                
            }
        }
    }
    
}
