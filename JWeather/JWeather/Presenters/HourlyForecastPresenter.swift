//
//  ForecastPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import Foundation

// MARK: Forecast Presenter

protocol HourlyForecastPresentable {
    var hourlyForecast: [Current] { get }
    func getTime(_ dt: Double) -> String
    func getTemp(_ kelvin: Float) -> Int
    func getIcon(_ forecast: Current) -> String
    func showSunsetTime(_ forecast: Current) -> Bool
    func showSunriseTime(_ forecast: Current) -> Bool
    func getSunsetTime() -> String
    func getSunriseTime() -> String
}

class HourlyForecastPresenter: ObservableObject, HourlyForecastPresentable {
    private let interactor: WeatherInteractorActions
    @Published var hourlyForecast = [Current]()
    
    init(interactor: WeatherInteractorActions) {
        self.interactor = interactor
        
        guard let hourly = interactor.weatherData?.hourly else { return }
        self.hourlyForecast = hourly
    }
    
    /**
     A function that converts the given epoch (unix) time into a DateTime String.
     
     - Parameters:
        - dt: A Double value representing the time in epoch (unix) format
     
     - Returns: A String value containing the time in h am/pm format. (i.e. 2am)
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
    
    func getSunsetTime() -> String {
        guard let sunset = interactor.weatherData?.current.sunset else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        formatter.timeZone = .current
        formatter.pmSymbol = "pm"
        return formatter.string(from: Date(timeIntervalSince1970: sunset))
    }
    
    func getSunriseTime() -> String {
        guard let sunrise = interactor.weatherData?.daily?[1].sunrise else { return "" }
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mma"
        formatter.timeZone = .current
        formatter.pmSymbol = "pm"
        return formatter.string(from: Date(timeIntervalSince1970: sunrise))
    }
}
