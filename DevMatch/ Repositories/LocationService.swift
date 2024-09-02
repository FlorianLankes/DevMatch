//
//  LocationService.swift
//  DevMatch
//
//  Created by Florian Lankes on 23.07.24.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published private(set) var lastKnownLocation: CLLocation?
    
    private let clLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        clLocationManager.delegate = self
    }
    
    //MARK: - Diese Methode fordert die Berechtigung für die Standortaktualisierungen an und startet
    func requestLocationUpdates() {
        self.clLocationManager.requestWhenInUseAuthorization()
        self.clLocationManager.startUpdatingLocation()
    }
    
    //MARK: - Delegierte Methode von `CLLocationManagerDelegate`, die aufgerufen wird, wenn Standortdaten aktualisiert werden.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.lastKnownLocation = locations.last
    }
}
