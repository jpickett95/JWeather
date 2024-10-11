//
//  CurrentWeatherView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

// MARK: Current Weather View
struct CurrentWeatherView: View {
    
    
    // MARK: Properties
    private let presenter: CurrentWeatherPresentable
    var offset: Binding<CGFloat>
    private var contentOffset: CGFloat {
        if !presenter.isMain {
            return -15
        } else { return 0 }
    }
    
    // MARK: Lifecycle
    init(presenter: CurrentWeatherPresentable, offset: Binding<CGFloat>) {
        self.presenter = presenter
        self.offset = offset
    }
    
    // MARK: Body
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            
            // MARK: Location
            if presenter.isMain {
                Text("My Location")
                    .font(.system(size: 35))
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
                
                Text(presenter.locationName?.uppercased() ?? "N/A")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
            } else {
                
                // MARK: Searchbar
                CustomSearchBar(presenter: presenter)
                    .opacity(presenter.getTitleOpacity(offset.wrappedValue))
                
                Text(presenter.locationName?.capitalized ?? "N/A")
                    .font(.system(size: 35))
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
            }
            
            // MARK: Temperature
            Text(presenter.temperature ?? "N/A")
                .font(.system(size: 75, weight: .thin))
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .opacity(presenter.getTitleOpacity(offset.wrappedValue))
            
            // MARK: Sky
            Text(presenter.sky ?? "N/A")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .opacity(presenter.getTitleOpacity(offset.wrappedValue))
            
            // MARK: High/Low Temp
            Text(presenter.highLowTemp ?? "N/A")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .opacity(presenter.getTitleOpacity(offset.wrappedValue))
            
        }
        .offset(y: contentOffset)
    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
