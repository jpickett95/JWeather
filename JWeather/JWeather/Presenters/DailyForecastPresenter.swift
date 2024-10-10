//
//  DailyForecastPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import Foundation

// MARK: Daily Forecast Presenter



// MARK: - - Protocols
protocol DailyForecastPresentable {
    var dailyForecast: [Daily] { get }
    
    func getWeekday(_ dt: Double) -> String
    func getTempF(_ kelvin: Float) -> Float
}

// MARK: - - Presenter
class DailyForecastPresenter: ObservableObject, DailyForecastPresentable {
    
    
    // MARK: - -- Properties
    private let interactor: WeatherInteractorActions
    @Published var dailyForecast = [Daily]()
    
    // MARK: - -- Lifecycle
    init(interactor: WeatherInteractorActions) {
        self.interactor = interactor
        
        guard let daily = interactor.weatherData?.daily else { return }
        self.dailyForecast = daily
    }
    
    // MARK: - -- Methods
    func getWeekday(_ dt: Double) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        
        let day = Calendar.current.component(.day, from: Date(timeIntervalSince1970: dt))
        let today = Calendar.current.component(.day, from: Date.now)
        if day == today  {
            return "Today"
        }
        return formatter.string(from: Date(timeIntervalSince1970: dt))
    }
    
    func getTempF(_ kelvin: Float) -> Float {
        return (kelvin - 273.15) * 9/5 + 32
    }
}
