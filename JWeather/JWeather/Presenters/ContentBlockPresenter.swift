//
//  ContentBlockPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/7/24.
//

import Foundation

// MARK: Content Block Presenter



// MARK: - - Protocols
protocol ContentBlockPresentable {
    var iconString: ContentIcon { get }
    var title: ContentTitle { get }
    var content: String? { get }
    var description: String? { get }
    
    func switchContent() -> String
    func switchDescription() -> String
    func switchVisibilityDescription(_ visibility: Double) -> String
}

// MARK: - - Presenter
class ContentBlockPresenter: ObservableObject {
    
    
    // MARK: - -- Properties
    private var interactor: WeatherInteractor
    let iconString: ContentIcon
    let title: ContentTitle
    var content: String?
    var description: String?
    
    // MARK: - -- Lifecycle
    init(interactor: WeatherInteractor, iconString: ContentIcon, title: ContentTitle) {
        self.interactor = interactor
        self.iconString = iconString
        self.title = title
    }
    
    // MARK: - -- Methods
    
    /**
     A function that returns the content value as a String, depending on the presenter's title case.
     
     - Returns: A String value containing the formatted content for the view, based on the title case.
     */
    func switchContent() -> String {
        switch (title) {
        case .sunset:
            guard let sunset = interactor.weatherData?.current.sunset else { return "N/A" }
            return interactor.convertUnixToTime(sunset)
        case .feelsLike:
            guard let feelsLike = interactor.weatherData?.current.feelsLike else { return "N/A" }
            return "\(interactor.convertKToF(feelsLike))°"
        case .visibility:
            guard let visibility = interactor.weatherData?.current.visibility else { return "N/A" }
            return "\(Int(interactor.convertMToMiles(Int(visibility)))) mi"
        case .precipitation:
            if let rain = interactor.weatherData?.current.rain?.oneH {
                let rain = interactor.convertMMToInches(rain)
                return String(format: "%.2f\"", rain)
            } else if let snow = interactor.weatherData?.current.snow?.oneH {
                let snow = interactor.convertMMToInches(snow)
                return String(format: "%.2f\"", snow)
            } else {
                return "0\""
            }
        case .humidity:
            guard let humidity = interactor.weatherData?.current.humidity else { return "N/A" }
            return "\(humidity)%"
        }
    }
    
    /**
     A function that returns the content description value as a String, depending on the presenter's title case.
     
     - Returns: A String value containing the formatted content description for the view, based on the title case.
     */
    func switchDescription() -> String {
        switch (title) {
        case .sunset:
            guard let sunrise = interactor.weatherData?.current.sunrise else { return "N/A" }
            return "Sunrise: \(interactor.convertUnixToTime(sunrise))"
        case .feelsLike:
            guard let feelsLike = interactor.weatherData?.current.feelsLike, let temp = interactor.weatherData?.current.temp else { return "N/A" }
            if temp > feelsLike {
                return "It may feel cooler than the actual temperature."
            } else if temp < feelsLike {
                return "It may feel warmer than the actual temperature."
            } else {
                return "It may feel as expected."
            }
        case .visibility:
            guard let visibility = interactor.weatherData?.current.visibility else { return "No visibility data available." }
            return switchVisibilityDescription(interactor.convertMToMiles(visibility))
        case .precipitation:
            if (interactor.weatherData?.current.rain?.oneH) != nil {
                return "Expected rain in the next hour."
            } else if (interactor.weatherData?.current.snow?.oneH) != nil {
                return "Expected snow in the next hour."
            } else {
                return "None expected."
            }
        case .humidity:
            guard let dewPoint = interactor.weatherData?.current.dewPoint else { return "The dew point is unknown." }
            return "The dew point is \(interactor.convertKToF(dewPoint))°"
        }
    }
    
    /**
     A function that returns the visibility description value as a String, depending on the given visibility value input.
     
     - Parameters:
        - visibility: A Double value representing the visibility data.
     
     - Returns: A String value containing the formatted visibility description for the view, based on the given visibility value.
     */
    func switchVisibilityDescription(_ visibility: Double) -> String {
        switch(visibility) {
        case (0...0.340909):
            return "Fog may be hindering your visibility."
        case (0.34091...0.5):
            return "Moderate fog."
        case (0.5...1.0):
            return" Mist or thin fog."
        case (1.000001...2.0):
            return "Poor visibility."
        case (2.000001...5.0):
            return "Moderate visbility."
        case (5.000001...10.0):
            return "Good visibility."
        case (10.000001...30.0):
            return "Very good visibility."
        case (30.000001 ... .infinity):
            return "Excellent visibility."
        default:
            return "No visibility data available."
        }
    }
}
