//
//  CurrentWeatherContentPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/4/24.
//

import Foundation

class CurrentWeatherContentPresenter: ObservableObject {
    private let interactor: WeatherInteractor
    @Published var currentWeather: CurrentWeather?
    
    init(interactor: WeatherInteractor) {
        self.interactor = interactor
        self.currentWeather = getCurrentWeather()
    }
    
    func getCurrentWeather() -> CurrentWeather {
        guard let weatherData = interactor.weatherData, let high = interactor.weatherData?.daily?.first?.temp.max, let low = interactor.weatherData?.daily?.first?.temp.min else { return CurrentWeather(location: "Not Available", temperature: "N/A", sky: "N/A", highLowTemp: "H:°\tL:°") }
        
        return CurrentWeather(location: "", temperature: "\(interactor.convertKToF(weatherData.current.temp))°", sky: weatherData.current.weather.description, highLowTemp: "H:\(interactor.convertKToF(high))°\tL:\(interactor.convertKToF(low))°")
    }
}
