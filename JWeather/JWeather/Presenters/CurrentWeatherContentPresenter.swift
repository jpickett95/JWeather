//
//  CurrentWeatherContentPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/4/24.
//

import Foundation

class CurrentWeatherContentPresenter: ObservableObject {
    private let interactor: WeatherInteractor
    @Published var locationName: String?
    @Published var temperature: String?
    @Published var highLowTemp: String?
    @Published var sky: String?
    
    init(interactor: WeatherInteractor) {
        self.interactor = interactor
        
        guard let temp = interactor.weatherData?.current.temp, let high = interactor.weatherData?.daily?.first?.temp.max, let low = interactor.weatherData?.daily?.first?.temp.min, let sky = interactor.weatherData?.current.weather.first?.description.capitalized, let name = interactor.geocodingData?.first?.name else { return }
        self.temperature = "\(interactor.convertKToF(temp))°"
        self.highLowTemp = "H:\(interactor.convertKToF(high))°\tL:\(interactor.convertKToF(low))°"
        self.sky = sky
        self.locationName = name
    }
    

}
