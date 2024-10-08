//
//  CurrentWeatherContentView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/3/24.
//

import SwiftUI

struct CurrentWeatherContentView: View {
    private let presenter: CurrentWeatherContentPresenter
    
    init(presenter: CurrentWeatherContentPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        VStack{
            //MARK: Location
            Text("My Location")
                .foregroundStyle(.white)
                .font(.title2)
                .shadow(color: .black, radius: 5, x: 3, y: 0)
            Text(presenter.locationName ?? "N/A")
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 5, x: 3, y: 0)
            
            // MARK: Temperature
            Text(presenter.temperature ?? "N/A")
                .foregroundStyle(.white)
                .font(.system(size: 60, weight: .thin))
                .offset(x: 5)
                .shadow(color: .black, radius: 5, x: 3, y: 0)
            
            // MARK: Sky
            Text(presenter.sky ?? "N/A")
                .foregroundStyle(.white)
                .font(.title3)
                .shadow(color: .black, radius: 5, x: 3, y: 0)
            
            // MARK: High/Low
            Text(presenter.highLowTemp ?? "H:°\tL:°")
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 5, x: 3, y: 0)
            
        }
        .padding()
    }
}

#Preview {
    CurrentWeatherContentView(presenter: CurrentWeatherContentPresenter(interactor: WeatherInteractor(networkService: NetworkService(), locationService: LocationService())))
}
