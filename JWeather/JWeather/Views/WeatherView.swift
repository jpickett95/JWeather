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
    @State var offset: CGFloat = 0
    
    // MARK: Lifecycle
    init(presenter: WeatherPresentable) {
        self.presenter = presenter
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
                    CurrentWeatherView(presenter: CurrentWeatherPresenter(interactor: presenter.interactor, isMain: true), offset: $offset)
                    .offset(y: -offset)
                    // For bottom drag effect
                    .offset(y: offset > 0 ? (offset / UIScreen.main.bounds.width) * 100 : 0)
                    .offset(y: presenter.getTitleOffset(offset))
                    
                    // Custom Data Views
                    VStack(spacing: 10) {
                        
                        // Custom Stack Views
                        
                        CustomStackView {
                            // Label here:
                            Label {
                                Text("Hourly Forecast")
                            } icon: {
                                Image(systemName: "clock")
                            }
                            
                        } contentView: {
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                HStack(spacing: 15) {
                                    ForecastView(time: "Now", temp: 93, image: "cloud.bolt")
                                    ForecastView(time: "12PM", temp: 94, image: "sun.max")
                                    ForecastView(time: "1PM", temp: 95, image: "sun.min")
                                    ForecastView(time: "2PM", temp: 96, image: "sun.haze")
                                    ForecastView(time: "3PM", temp: 97, image: "cloud.sun")
                                    ForecastView(time: "4PM", temp: 98, image: "cloud")
                                    ForecastView(time: "5PM", temp: 99, image: "cloud.rain")
                                    ForecastView(time: "6PM", temp: 100, image: "cloud.fog")
                                }
                            }
                        }
                        
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

struct ForecastView: View {
    var time: String
    var temp: CGFloat
    var image: String
    
    var body: some View {
        VStack(spacing: 15) {
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)
            
            Image(systemName: image)
                .font(.title2)
            // Multicolor
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.yellow, .white)
            // Max frame
                .frame(height: 30)
            
            Text("\(Int(temp))°")
                .font(.callout.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
    }
}
