//
//  DailyForecastPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import Foundation

// MARK: Daily Forecast Presenter



// MARK: - - Protocol
protocol DailyForecastPresentable {
    
    
    // MARK: - -- Properties
    var dailyForecast: [Daily] { get }
    
    
    // MARK: - -- Methods
    func getWeekday(_ dt: Double) -> String
    func getTempF(_ kelvin: Float) -> Float
}

// MARK: - - Presenter

/**
 A presenter object that formats data for DailyForecastViews.
 */
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
    
    /**
     A function that returns the weekday in 'EEE' format, given the date in epoch/unix time. If the day is today, will return 'Today' instead. (i.e. Mon, Tue, Wed, etc.)
     
     - Parameters:
        - dt: A Double value containing the date in epoch/unix time.
     
     - Returns: A String value containing the weekday in 'EEE' format. If the day is today, will return 'Today' instead. (i.e. Mon, Tue, Wed, etc.)
     */
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
    
    /**
     A function that converts the given input from Kelvin to Fahrenheit.
     
     - Parameters:
        - kelvin: A Float value representing a temperature in Kelvin (K).
     
     - Returns: A Float value representing the converted temperature in Fahrenheit (°F).
     */
    func getTempF(_ kelvin: Float) -> Float {
        return (kelvin - 273.15) * 9/5 + 32
    }
}
