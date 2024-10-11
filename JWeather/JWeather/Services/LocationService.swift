//
//  LocationService.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/6/24.
//

import Foundation
import CoreLocation

// MARK: Locator



// MARK: - - Protocol
protocol Locator {
    func getLatitude() -> Double
    func getLongitude() -> Double
}

// MARK: - - Service

/**
 Manages the user's device location, using CoreLocation.
 */
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
    
    /**
     A function that handles the user's device authorization status.
     
     - Parameters:
        - manager: A CLLocationManager object that contains the authorization status.
     
     ### Cases:
        - authorizedWhenInUse: Location services are available.
        - restricted: Location services currently unavailable.
        - denied: Location services currently unavailable.
        - notDetermined: Authorization not determined yet.
     */
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse: // Location services are available.
            // Insert code here of what should happen when Location services are authorized
            authorizationStatus = .authorizedWhenInUse
            locationManager.requestLocation()
            break
            
        case .restricted: // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .restricted
            break
            
        case .denied: // Location services currently unavailable.
            // Insert code here of what should happen when Location services are NOT authorized
            authorizationStatus = .denied
            break
            
        case .notDetermined: // Authorization not determined yet.
            authorizationStatus = .notDetermined
            manager.requestWhenInUseAuthorization()
            break
            
        default:
            break
        }
    }
    
    /**
     A function that handles location updates.
     
     - Parameters:
        - manager: A CLLocationManager object.
        - locations: An array of CLLocation objects.
     */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Insert code to handle location updates
    }
    
    /**
     A function that handles errors with the location manager.
     
     - Parameters:
        - manager: A CLLocationManager object.
        - error: An Error object containing the error.
     */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error: \(error.localizedDescription)")
    }
    
    /**
     A function that gets the device's lattitude value from the location manager.
     
     - Returns: A Double value containing the device's lattitude coordinate. Will return 0 if there's nil data.
     */
    func getLatitude() -> Double {
        return locationManager.location?.coordinate.latitude ?? 0
    }
    
    /**
     A function that gets the device's longitude value from the location manager.
     
     - Returns: A Double value containing the device's longitude coordinate. Will return 0 if there's nil data.
     */
    func getLongitude() -> Double {
        return locationManager.location?.coordinate.longitude ?? 0
    }
}
