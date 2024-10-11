//
//  JWeatherApp.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

import SwiftUI

// MARK: App File
@main
struct JWeatherApp: App {
    
    // MARK: Properties
    let persistenceController = PersistenceController.shared

    
    // MARK: Body
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
        }
    }
}
