//
//  WeatherContentBlockPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/7/24.
//

import Foundation

// MARK: Wind Presenter



// MARK: - - Protocol
protocol WindPresentable {
    
    
    // MARK: - -- Properties
    var icon: String { get }
    var title: String { get }
    var degrees: Int? { get set }
    var windSpeed: Double? { get set }
    var windGusts: Double? { get set }
    
    // MARK: - -- Methods
    func switchDegreesToDirection(_ degrees: Double) -> String
}

// MARK: - - Presenter

/**
 A presenter object that formats data for WindViews.
 */
class WindPresenter: ObservableObject, WindPresentable {
    
    
    // MARK: - -- Properties
    private var interactor: WeatherInteractorActions
    let icon = "wind"
    let title = "WIND"
    @Published var degrees: Int?
    @Published var windSpeed: Double?
    @Published var windGusts: Double?
    
    // MARK: - -- Lifecycle
    init(interactor: WeatherInteractorActions) {
        self.interactor = interactor
        self.degrees = interactor.weatherData?.current.windDeg
        self.windSpeed = interactor.weatherData?.current.windSpeed
        self.windGusts = interactor.weatherData?.current.windGust
    }
    
    // MARK: - -- Methods
    
    /**
    A function that returns the true direction as a String based off the given degrees input parameter.
     
     - Parameters:
        - degrees: A Double value containing the direction in degrees.
     
     - Returns: A String value containing the true direction. Will return 'N/A' as the default case. (i.e. N, NE, N/NE)
     */
    func switchDegreesToDirection(_ degrees: Double) -> String {
        switch(degrees) {
        case (348.76...360):
            return "N"
        case (0...11.25):
            return "N"
        case (11.26...33.75):
            return "N/NE"
        case (33.76...56.25):
            return "NE"
        case (56.26...78.75):
            return "E/NE"
        case (78.76...101.25):
            return "E"
        case (101.26...123.75):
            return "E/SE"
        case (123.76...146.25):
            return "SE"
        case (146.26...168.75):
            return "S/SE"
        case (168.76...191.25):
            return "S"
        case (191.26...213.75):
            return "S/SW"
        case (213.76...236.25):
            return "SW"
        case (236.26...258.75):
            return "W/SW"
        case (258.76...281.25):
            return "W"
        case (281.26...303.75):
            return "W/NW"
        case (303.76...326.25):
            return "NW"
        case (326.26...348.75):
            return "N/NW"
        default:
            return "N/A"
        }
    }
}
