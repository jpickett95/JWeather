//
//  JWeatherApp.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

import SwiftUI

@main
struct JWeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            //ContentView()
            //    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
            WeatherView()
                .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
 
        }
    }
}
