//
//  CurrentWeatherPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/10/24.
//

import Foundation
import SwiftUICore

protocol CurrentWeatherPresentable {
    var locationName: String? { get }
    var temperature: String? { get }
    var highLowTemp: String? { get }
    var sky: String? { get }
    var isMain: Bool { get }
    
    func getTitleOpacity(_ offset: CGFloat) -> CGFloat
    func getTitleOffset(_ offset: CGFloat) -> CGFloat
}

class CurrentWeatherPresenter: ObservableObject, CurrentWeatherPresentable {
    private let interactor: WeatherInteractorActions
    let isMain: Bool
    @Published var locationName: String?
    @Published var temperature: String?
    @Published var highLowTemp: String?
    @Published var sky: String?
    
    init(interactor: WeatherInteractorActions, isMain: Bool) {
        self.interactor = interactor
        self.isMain = isMain
        
        guard let temperature = interactor.weatherData?.current.temp, let high = interactor.weatherData?.daily?.first?.temp.max, let low = interactor.weatherData?.daily?.first?.temp.min, let sky = interactor.weatherData?.current.weather.first?.description.capitalized, let name = interactor.geocodingData?.first?.name else { return }
        self.temperature = " \(interactor.convertKToF(temperature))°"
        self.highLowTemp = "H:\(interactor.convertKToF(high))°  L:\(interactor.convertKToF(low))°"
        self.sky = sky
        self.locationName = name
    }
    
    func getTitleOpacity(_ offset: CGFloat) -> CGFloat {
        let titleOffset = -getTitleOffset(offset)
        
        let progress = titleOffset / 20
        
        let opacity = 1 - progress
        
        return opacity
    }
    
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
