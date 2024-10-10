//
//  HourlyForecastView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

struct HourlyForecastView: View {
    private let presenter: HourlyForecastPresentable
    
    init(presenter: HourlyForecastPresentable) {
        self.presenter = presenter
    }
    
    var body: some View {
        CustomStackView {

            Label {
                Text("HOURLY FORECAST")
            } icon: {
                Image(systemName: "clock")
            }
            
        } contentView: {
            ScrollView(.horizontal, showsIndicators: false) {
                
                HStack(spacing: 15) {
                    ForEach(presenter.hourlyForecast, id: \.self) { forecast in
                        if presenter.hourlyForecast.firstIndex(of: forecast) ?? 0 <= 23 {
                            HourlyForecastViewCell(time: presenter.getTime(forecast.dt), temp: "\(presenter.getTemp(forecast.temp))°", image: presenter.getIcon(forecast))
                            
                            if presenter.showSunsetTime(forecast) {
                                HourlyForecastViewCell(time: presenter.getSunsetTime(), temp: "Sunset", image: "sunset")
                            }
                            
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

struct HourlyForecastViewCell: View {
    let time: String
    let temp: String
    let image: String
    
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
                .foregroundStyle(switchPrimaryColor(image: image), switchSecondaryColor(image: image))
            // Max frame
                .frame(height: 30)
            
            Text(temp)
                .font(.callout.bold())
                .foregroundStyle(.white)
        }
        .padding(.horizontal, 10)
    }
    
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
