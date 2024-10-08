//
//  WeatherView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/3/24.
//

import SwiftUI

struct WeatherView: View {
    @EnvironmentObject private var interactor: WeatherInteractor
    
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
                
                ScrollView {
                    // MARK: Wind
                    WindContentBlockView(presenter: WindContentBlockPresenter(interactor: interactor))
                    
                    HStack(spacing: 15) {
                        // MARK: Sunset
                        ContentBlockView(presenter: ContentBlockPresenter(interactor: interactor, iconString: ContentIcon.sunset, title: ContentTitle.sunset))
                        
                        // MARK: Feels Like
                        ContentBlockView(presenter: ContentBlockPresenter(interactor: interactor, iconString: ContentIcon.feelsLike, title: ContentTitle.feelsLike))
                    }
                    
                    HStack(spacing: 15) {
                        // MARK: Precipitation
                        ContentBlockView(presenter: ContentBlockPresenter(interactor: interactor, iconString: ContentIcon.precipitation, title: ContentTitle.precipitation))
                        
                        // MARK: Visbility
                        ContentBlockView(presenter: ContentBlockPresenter(interactor: interactor, iconString: ContentIcon.visibility, title: ContentTitle.visibility))
                    }
                    
                    HStack(spacing: 15) {
                        // MARK: Humidity
                        ContentBlockView(presenter: ContentBlockPresenter(interactor: interactor, iconString: ContentIcon.humidity, title: ContentTitle.humidity))
                        
                        // MARK: Pressure
                        PressureBlockView(presenter: PressureContentBlockPresenter(interactor: interactor))
                    }
                }
            }
            
        }
    }
    
    func currentWeatherView() -> some View {
        Text("Yas!")
    }
}

#Preview {
    WeatherView().environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
