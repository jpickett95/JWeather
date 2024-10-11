//
//  DailyForecastView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

// MARK: Daily Forecast View
struct DailyForecastView: View {
    
    
    // MARK: Properties
    private let presenter: DailyForecastPresentable
    
    
    // MARK: Lifecycle
    init(presenter: DailyForecastPresentable) {
        self.presenter = presenter
    }
    
    // MARK: Body
    var body: some View {
        CustomStackView {

            // MARK: Title & Icon
            Label {
                Text("\(presenter.dailyForecast.count)-DAY FORECAST")
            } icon: {
                Image(systemName: "calendar")
            }
            
        } contentView: {
            
            // MARK: Content
            VStack(alignment: .leading, spacing: 10) {
                ForEach(presenter.dailyForecast, id: \.self) { forecast in
                    VStack {
                        DailyForecastViewCell(day: presenter.getWeekday(forecast.dt), image: "sun.max", minTemp: presenter.getTempF(forecast.temp.min), maxTemp: presenter.getTempF(forecast.temp.max))
                        
                        Divider()
                            .overlay(.white)
                    }
                    .padding(.vertical, 8)
                }
            }
            
        }
    }
}

// MARK: Content Cell
struct DailyForecastViewCell: View {
    
    
    // MARK: Properties
    let day: String
    let image: String
    let minTemp: Float
    let maxTemp: Float
    
    // MARK: Body
    var body: some View {
        HStack(spacing: 15) {
            
            // MARK: Weekday
            Text(day)
                .font(.title3.bold())
                .foregroundStyle(.white)
                .frame(width: 60, alignment: .leading)
            
            // MARK: Image
            Image(systemName: image)
                .font(.title3)
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(switchPrimaryColor(image: image), switchSecondaryColor(image: image))
                .frame(width: 30)
            
            // MARK: Min Temperature
            Text("\(Int(minTemp))°")
                .font(.title3.bold())
                .foregroundStyle(.secondary)
                .foregroundStyle(.white)
            
            // MARK: Progress Bar
            ZStack(alignment: .leading) {
                
                Capsule()
                    .fill(.tertiary)
                    .foregroundStyle(.white)
                
                GeometryReader { proxy in
                    Capsule()
                        .fill(.linearGradient(.init(colors: [.orange, .red]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: (CGFloat(maxTemp) / 140) * proxy.size.width)
                }
                    
            }
            .frame(height: 4)
            
            // MARK: Max Temperature
            Text("\(Int(maxTemp))°")
                .font(.title3.bold())
                .foregroundStyle(.white)
        }
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
