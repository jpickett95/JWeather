//
//  WeatherView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/3/24.
//

import SwiftUI

struct WeatherView: View {
    private let interactor: WeatherInteractor
    
    init(interactor: WeatherInteractor) {
        self.interactor = interactor
    }
    
    var body: some View {
        ZStack{
            // MARK: Background Image
            Image(SkyImage.clear.rawValue, bundle: nil)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 15) {
                // MARK: Current Weather
                CurrentWeatherContentView(presenter: CurrentWeatherContentPresenter(interactor: interactor))

                HStack(spacing: 15) {
                    // MARK: Sunset
                    ContentBlockView()
                    
                    
                    // MARK: Feels Like
                    ContentBlockView()
                }
                
                HStack(spacing: 15) {
                    // MARK: Precipitation
                    ContentBlockView()
                    
                    
                    // MARK: Visbility
                    ContentBlockView()
                }
                
            }
            
            
        }
    }
    
    func currentWeatherView() -> some View {
        Text("Yas!")
    }
}

#Preview {
    WeatherView(interactor: WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
