//
//  CurrentWeatherPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import Foundation

// MARK: Current Weather Presenter



// MARK: - - Protocol
protocol CurrentWeatherPresentable {
    
    
    // MARK: - -- Properties
    var locationName: String? { get }
    var temperature: String? { get }
    var highLowTemp: String? { get }
    var sky: String? { get }
    var isMain: Bool { get }
    var interactor: WeatherInteractorActions { get }
    
    // MARK: - -- Methods
    func getTitleOpacity(_ offset: CGFloat) -> CGFloat
    func getTitleOffset(_ offset: CGFloat) -> CGFloat
}

// MARK: - - Presenter

/**
 A presenter object that formats data for CurrentWeatherViews.
 */
class CurrentWeatherPresenter: ObservableObject, CurrentWeatherPresentable {
    
    
    // MARK: - -- Properties
    let interactor: WeatherInteractorActions
    let isMain: Bool
    @Published var locationName: String?
    @Published var temperature: String?
    @Published var highLowTemp: String?
    @Published var sky: String?
    
    // MARK: - -- Lifecycle
    init(interactor: WeatherInteractorActions, isMain: Bool) {
        self.interactor = interactor
        self.isMain = isMain
        
        guard let temperature = interactor.weatherData?.current.temp, let high = interactor.weatherData?.daily?.first?.temp.max, let low = interactor.weatherData?.daily?.first?.temp.min, let sky = interactor.weatherData?.current.weather.first?.description.capitalized, let name = interactor.geocodingData?.first?.name else { return }
        self.temperature = " \(interactor.convertKToF(temperature))°"
        self.highLowTemp = "H:\(interactor.convertKToF(high))°  L:\(interactor.convertKToF(low))°"
        self.sky = sky
        self.locationName = name
    }
    
    // MARK: - -- Methods
    
    /**
     A function that returns the opacity value, given the offset value of the title view. Used to make views disappear when scrolling up on the screen.
     
     - Parameters:
        - offset: A CGFLoat value representing the offset of the title view.
     
     - Returns: A CGFloat value representing the opacity.
     */
    func getTitleOpacity(_ offset: CGFloat) -> CGFloat {
        let titleOffset = -getTitleOffset(offset)
        let progress = titleOffset / 20
        let opacity = 1 - progress
        return opacity
    }
    
    /**
     A function that gets the max height of the title view.
     
     - Parameters:
        - offset: A CGFloat value representing the title view's offset.
     
     - Returns: A CGFloat value containing the new offset for the title view, considering the desired max height. If the given offset is greater than 0, will return 0.
     */
    func getTitleOffset(_ offset: CGFloat) -> CGFloat {
        // Setting one max height for whole title
        // Consider max as 140
        if offset < 0 {
            let progress = -offset / 140
            
            // Since top padding is 40
            let newOffset = (progress <= 1.0 ? progress : 1) * 40
            return -newOffset
        }
        return 0
    }
}
