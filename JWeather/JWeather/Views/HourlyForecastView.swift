//
//  HourlyForecastView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

// MARK: Hourly Forecast View
struct HourlyForecastView: View {
    
    
    // MARK: Properties
    private let presenter: HourlyForecastPresentable
    
    
    // MARK: Lifecycle
    init(presenter: HourlyForecastPresentable) {
        self.presenter = presenter
    }
    
    // MARK: Body
    var body: some View {
        CustomStackView {

            // MARK: Title & Icon
            Label {
                Text("HOURLY FORECAST")
            } icon: {
                Image(systemName: "clock")
            }
            
        } contentView: {
            
            // MARK: Content
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(presenter.hourlyForecast, id: \.self) { forecast in
                        if presenter.hourlyForecast.firstIndex(of: forecast) ?? 0 <= 23 {
                            
                            // MARK: Forecast
                            HourlyForecastViewCell(time: presenter.getTime(forecast.dt), temp: "\(presenter.getTemp(forecast.temp))°", image: presenter.getIcon(forecast))
                            
                            // MARK: Sunset
                            if presenter.showSunsetTime(forecast) {
                                HourlyForecastViewCell(time: presenter.getSunsetTime(), temp: "Sunset", image: "sunset")
                            }
                            
                            // MARK: Sunrise
                            if presenter.showSunriseTime(forecast) {
                                HourlyForecastViewCell(time: presenter.getSunriseTime(), temp: "Sunrise", image: "sunrise")
                            }
                        }
                    }
                }
            }
        }
    }
}

// MARK: Content Cell
struct HourlyForecastViewCell: View {
    
    
    // MARK: Properties
    let time: String
    let temp: String
    let image: String
    
    // MARK: Body
    var body: some View {
        VStack(spacing: 15) {
            
            // MARK: Time
            Text(time)
                .font(.callout.bold())
                .foregroundStyle(.white)
            
            // MARK: Image
            Image(systemName: image)
                .font(.title2)
            // Multicolor
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(switchPrimaryColor(image: image), switchSecondaryColor(image: image))
            // Max frame
                .frame(height: 30)
            
            // MARK: Temperature
            Text(temp)
                .font(.callout.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
    }
    
    // MARK: Methods
    
    /**
     A function that returns the primary color, given the view's image property.
     
     - Parameters:
        - image: A String value containing the SF Symbol
     
     - Returns: A Color object depending on the given SF Symbol. Will return 'white' as the default case.
     
     ### Cases:
        - sun.max
        - sunset
        - sunrise
     */
    private func switchPrimaryColor(image: String) -> Color {
        switch image {
        case "sun.max":
            return .yellow
        case "sunset", "sunrise":
            return .white
        default:
            return .white
        }
    }
    
    /**
     A function that returns the secondary color, given the view's image property.
     
     - Parameters:
        - image: A String value containing the SF Symbol
     
     - Returns: A Color object depending on the given SF Symbol. Will return 'white' as the default case.
     
     ### Cases:
        - sun.max
        - sunset
        - sunrise
     */
    private func switchSecondaryColor(image: String) -> Color {
        switch image {
        case "sun.max", "sunset", "sunrise":
            return .yellow
        default:
            return .white
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(WeatherInteractor(networkService: NetworkService(), locationService: LocationService()))
}
