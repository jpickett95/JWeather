//
//  JWeatherApp.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

import SwiftUI

@main
struct JWeatherApp: App {
    // MARK: Properties
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))

            //    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
           // WeatherView()
 
        }
    }
}
