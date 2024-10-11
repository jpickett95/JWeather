//
//  HomePresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/9/24.
//

import Foundation

// MARK: Weather Presenter



// MARK: - - Protocols
protocol WeatherPresentable {
    var topEdge: CGFloat { get }
    var interactor: WeatherInteractorActions { get }
    var locationName: String? { get }
    var temperature: String? { get }
    var highLowTemp: String? { get }
    var sky: String? { get }
    var searchText: String { get set }
    
    func getTitleOpacity(_ offset: CGFloat) -> CGFloat
    func getTitleOffset(_ offset: CGFloat) -> CGFloat
}

// MARK: - - Presenter
class WeatherPresenter: ObservableObject, WeatherPresentable {
    
    
    // MARK: - -- Properties
    var interactor: WeatherInteractorActions
    var topEdge: CGFloat
    @Published var locationName: String?
    @Published var temperature: String?
    @Published var highLowTemp: String?
    @Published var sky: String?
    @Published var searchText: String = ""
    
    // MARK: - -- Lifecycle
    init(interactor: WeatherInteractor, topEdge: CGFloat) {
        self.interactor = interactor
        self.topEdge = topEdge
        
        guard let temperature = interactor.weatherData?.current.temp, let high = interactor.weatherData?.daily?.first?.temp.max, let low = interactor.weatherData?.daily?.first?.temp.min, let sky = interactor.weatherData?.current.weather.first?.description.capitalized, let name = interactor.geocodingData?.first?.name else { return }
        self.temperature = " \(interactor.convertKToF(temperature))°"
        self.highLowTemp = "H:\(interactor.convertKToF(high))°  L:\(interactor.convertKToF(low))°"
        self.sky = sky
        self.locationName = name
    }
    
    // MARK: - -- Methods
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
