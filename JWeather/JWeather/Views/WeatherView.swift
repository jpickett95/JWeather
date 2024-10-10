//
//  HomeView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/9/24.
//

import SwiftUI

struct WeatherView: View {
    // MARK: Properties
    private let presenter: WeatherPresentable
    private let isMain: Bool
    @State var offset: CGFloat = 0
    
    // MARK: Lifecycle
    init(presenter: WeatherPresentable, isMain: Bool) {
        self.presenter = presenter
        self.isMain = isMain
    }
    
    var body: some View {
        ZStack {
            // MARK: Background
            // Geometry Reader for getting width & height
            GeometryReader { proxy in
                Image("clear-sky")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .ignoresSafeArea()
            //.overlay(.ultraThinMaterial)    // Blur effect
            
            // MARK: Main View
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack {
                    
                    // MARK: Current Weather
                    CurrentWeatherView(presenter: CurrentWeatherPresenter(interactor: presenter.interactor, isMain: isMain), offset: $offset)
                    .offset(y: -offset)
                    // For bottom drag effect
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                    .offset(y: presenter.getTitleOffset(offset))
                    
                    // Custom Data Views
                    VStack(spacing: 10) {
                                                
                        // MARK: Hourly Forecast
                        HourlyForecastView(presenter: HourlyForecastPresenter(interactor: presenter.interactor))
                        
                        
                        // MARK: Daily Forecast
                        DailyForecastView(presenter: DailyForecastPresenter(interactor: presenter.interactor))
                        
                        
                        // MARK: Wind
                        WindView(presenter: WindPresenter(interactor: presenter.interactor))
                        
                        HStack(spacing: 10) {
                            // MARK: Sunset
                            WeatherDataView(presenter: WeatherDataPresenter(interactor: presenter.interactor, icon: ContentIcon.sunset, title: ContentTitle.sunset))
                            
                            
                            // MARK: Feels Like
                            WeatherDataView(presenter: WeatherDataPresenter(interactor: presenter.interactor, icon: ContentIcon.feelsLike, title: ContentTitle.feelsLike))
                        }
                        .frame(maxHeight: .infinity)
                    
                        HStack(spacing: 10) {
                            // MARK: Precipitation
                            WeatherDataView(presenter: WeatherDataPresenter(interactor: presenter.interactor, icon: ContentIcon.precipitation, title: ContentTitle.precipitation))
                            
                            
                            // MARK: Visibility
                            WeatherDataView(presenter: WeatherDataPresenter(interactor: presenter.interactor, icon: ContentIcon.visibility, title: ContentTitle.visibility))
                        }.frame(maxHeight: .infinity)
                        
                        HStack(spacing: 10) {
                            // MARK: Humidity
                            WeatherDataView(presenter: WeatherDataPresenter(interactor: presenter.interactor, icon: ContentIcon.humidity, title: ContentTitle.humidity))
                            
                            
                            // MARK: Pressure
                            PressureView(presenter: PressurePresenter(interactor: presenter.interactor))
            
                        }
                    }
                }
                .padding(.top, 40)
                .padding(.top, presenter.topEdge)
                .padding([.horizontal, .bottom])
                // Getting offset
                .overlay(
                    // Using Geometry Reader
                    GeometryReader { proxy -> Color in
                        
                        let minY = proxy.frame(in: .global).minY
                        
                        DispatchQueue.main.async {
                            offset = minY
                        }
                        
                        return Color.clear
                        
                    }
                )
            }
        }
    }
    
    
    
   
}

#Preview {
    ContentView()
        .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
