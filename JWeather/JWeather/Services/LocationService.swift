//
//  LocationService.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/6/24.
//

import Foundation
import CoreLocation

// MARK: Locator



// MARK: - - Protocols
protocol Locator {
    func getLatitude() -> Double
    func getLongitude() -> Double
}

// MARK: - - Service
class LocationService: NSObject, ObservableObject, CLLocationManagerDelegate, Locator {

    
    // MARK: - -- Properties
    var locationManager = CLLocationManager()
    @Published var authorizationStatus: CLAuthorizationStatus?
    
    // MARK: - -- Lifecycle
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    // MARK: - -- Methods
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:  // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            break
            
        case .denied:  // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied
            break
            
        case .notDetermined:        // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Insert code to handle location updates
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    func getLatitude() -> Double {
        return locationManager.location?.coordinate.latitude ?? 0
    }
    
    func getLongitude() -> Double {
        return locationManager.location?.coordinate.longitude ?? 0
    }
}
