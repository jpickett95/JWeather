//
//  DailyForecastView.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import SwiftUI

struct DailyForecastView: View {
    private let presenter: DailyForecastPresentable
    
    init(presenter: DailyForecastPresentable) {
        self.presenter = presenter
    }
    
    var body: some View {
        CustomStackView {

            Label {
                Text("\(presenter.dailyForecast.count)-DAY FORECAST")
            } icon: {
                Image(systemName: "calendar")
            }
            
        } contentView: {
            
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

struct DailyForecastViewCell: View {
    let day: String
    let image: String
    let minTemp: Float
    let maxTemp: Float
    
    var body: some View {
        HStack(spacing: 15) {
            
            Text(day)
                .font(.title3.bold())
                .foregroundStyle(.white)
                .frame(width: 60, alignment: .leading)
            
            Image(systemName: image)
                .font(.title3)
                .symbolVariant(.fill)
                .symbolRenderingMode(.palette)
                .foregroundStyle(switchPrimaryColor(image: image), switchSecondaryColor(image: image))
                .frame(width: 30)
            
            Text("\(Int(minTemp))°")
                .font(.title3.bold())
                .foregroundStyle(.secondary)
                .foregroundStyle(.white)
            
            // Progress Bar
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
            
            Text("\(Int(maxTemp))°")
                .font(.title3.bold())
                .foregroundStyle(.white)
        }
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
