//
//  ForecastPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import Foundation

// MARK: Forecast Presenter



// MARK: - - Protocol
protocol HourlyForecastPresentable {
    
    
    // MARK: - -- Properties
    var hourlyForecast: [Current] { get }
    
    
    // MARK: - -- Methods
    func getTime(_ dt: Double) -> String
    func getTemp(_ kelvin: Float) -> Int
    func getIcon(_ forecast: Current) -> String
    func showSunsetTime(_ forecast: Current) -> Bool
    func showSunriseTime(_ forecast: Current) -> Bool
    func getSunsetTime() -> String
    func getSunriseTime() -> String
}

// MARK: - - Presenter

/**
 A presenter object that formats data for HourlyForecastViews.
 */
class HourlyForecastPresenter: ObservableObject, HourlyForecastPresentable {
    
    
    // MARK: - -- Properties
    private let interactor: WeatherInteractorActions
    @Published var hourlyForecast = [Current]()
    
    // MARK: - -- Lifecycle
    init(interactor: WeatherInteractorActions) {
        self.interactor = interactor
        
        guard let hourly = interactor.weatherData?.hourly else { return }
        self.hourlyForecast = hourly
    }
    
    // MARK: - -- Methods
    
    /**
     A function that converts the given epoch (unix) time into a DateTime String in 'ha' format. Will return 'Now' if the hour matches the current hour. (i.e. 12pm, 1am, etc.)
     
     - Parameters:
        - dt: A Double value representing the time in epoch (unix) format
     
     - Returns: A String value containing the time in h am/pm format. Will return 'Now' if the hour matches the current hour. (i.e. 2am)
     */
    func getTime(_ dt: Double) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "ha"
        dateFormatter.timeZone = .current
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        if dateFormatter.string(from: Date.now) == dateFormatter.string(from: date) {
            return "Now"
        }
        return dateFormatter.string(from: date)
    }
    
    /**
     A function that converts the given input from Kelvin to Fahrenheit.
     
     - Parameters:
        - kelvin: A Float value representing a temperature in Kelvin (K).
     
     - Returns: An integer value representing the converted temperature in Fahrenheit (°F).
     */
    func getTemp(_ kelvin: Float) -> Int {
        return interactor.convertKToF(kelvin)
    }
    
    /**
     A function that returns a SF Symbol's String name, given the forecast. Will return the 'questionmark' symbol if there's an error or nil data.
     
     - Parameters:
        - forecast: A Current object containing the forecast data.
     
     - Returns: A String value containing the name of a SF Symbol, depending on the given forecast data. Will return the 'questionmark' symbol if there's an error or nil data.
     */
    func getIcon(_ forecast: Current) -> String {
        guard let sunset = interactor.weatherData?.current.sunset, let tomorrowSunrise = interactor.weatherData?.daily?[1].sunrise else { return "questionmark" }
        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        formatter.timeZone = .current
        
        let sunsetDate = Date(timeIntervalSince1970: sunset)
        let sunriseDate = Date(timeIntervalSince1970: tomorrowSunrise)
        let date = Date(timeIntervalSince1970: forecast.dt)
        guard let sunsetHour = Int(formatter.string(from: sunsetDate)), let sunriseHour = Int(formatter.string(from: sunriseDate)), let hour = Int(formatter.string(from: date)) else { return "questionmark" }
        
        if sunsetHour < hour || hour <= sunriseHour {
            return "moon.stars"
        } else {
            return "sun.max"
        }
    }
    
    /**
     A function that determines whether the sunset time should be shown, given the forecast's time.
     
     - Parameters:
        - forecast: A Current object that contains the forecast data.
     
     - Returns: A Bool value representing whether the sunset time should be shown. If the forecast's hour matches the current sunset's hour, will return true. Will return false if there's an error or nil data.
     */
    func showSunsetTime(_ forecast: Current) -> Bool {
        guard let sunset = interactor.weatherData?.current.sunset else { return false }

        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        formatter.timeZone = .current
        
        let sunsetDate = Date(timeIntervalSince1970: sunset)
        let date = Date(timeIntervalSince1970: forecast.dt)
        
        guard let sunsetHour = Int(formatter.string(from: sunsetDate)), let hour = Int(formatter.string(from: date)) else { return false }
        
        return sunsetHour == hour
    }
    
    /**
     A function that determines whether the sunrise time should be shown, given the forecast's time.
     
     - Parameters:
        - forecast: A Current object that contains the forecast data.
     
     - Returns: A Bool value representing whether the sunrise time should be shown. If the forecast's hour matches the current sunrise's hour, will return true. Will return false if there's an error or nil data.
     */
    func showSunriseTime(_ forecast: Current) -> Bool {
        guard let sunrise = interactor.weatherData?.daily?[1].sunrise else { return false }

        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        formatter.timeZone = .current
        
        let sunriseDate = Date(timeIntervalSince1970: sunrise)
        let date = Date(timeIntervalSince1970: forecast.dt)
        
        guard let sunriseHour = Int(formatter.string(from: sunriseDate)), let hour = Int(formatter.string(from: date)) else { return false }
        
        return sunriseHour == hour
    }
    
    /**
     A function that returns the sunset's time in 'h:mma' format. (i.e. 7:45pm)
     
     - Returns: A String value containing the sunset's time in 'h:mma' format. Will return an empty String if there's an error or nil data. (i.e. 7:45pm)
     */
    func getSunsetTime() -> String {
        guard let sunset = interactor.weatherData?.current.sunset else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        formatter.timeZone = .current
        formatter.pmSymbol = "pm"
        return formatter.string(from: Date(timeIntervalSince1970: sunset))
    }
    
    /**
     A function that returns the sunrise's time in 'h:mma' format. (i.e. 7:45am)
     
     - Returns: A String value containing the sunrise's time in 'h:mma' format. Will return an empty String if there's an error or nil data. (i.e. 7:45am)
     */
    func getSunriseTime() -> String {
        guard let sunrise = interactor.weatherData?.daily?[1].sunrise else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        formatter.timeZone = .current
        formatter.amSymbol = "am"
        return formatter.string(from: Date(timeIntervalSince1970: sunrise))
    }
}
