//
//  CurrentWeatherView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    private let presenter: CurrentWeatherPresentable
    var offset: Binding<CGFloat>
    
    init(presenter: CurrentWeatherPresentable, offset: Binding<CGFloat>) {
        self.presenter = presenter
        self.offset = offset
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            
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
                Text(presenter.locationName?.capitalized ?? "N/A")
                    .font(.system(size: 35))
                    .foregroundStyle(.white)
                    .shadow(radius: 5)
            }
            
            Text(presenter.temperature ?? "N/A")
                .font(.system(size: 75, weight: .thin))
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .opacity(presenter.getTitleOpacity(offset.wrappedValue))
            
            Text(presenter.sky ?? "N/A")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .opacity(presenter.getTitleOpacity(offset.wrappedValue))
            
            
            Text(presenter.highLowTemp ?? "N/A")
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(.white)
                .shadow(radius: 5)
                .opacity(presenter.getTitleOpacity(offset.wrappedValue))
            
        }

    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
