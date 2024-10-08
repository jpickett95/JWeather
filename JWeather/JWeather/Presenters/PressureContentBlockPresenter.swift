//
//  PressureContentBlockPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/7/24.
//

import Foundation

class PressureContentBlockPresenter: ObservableObject {
    private let interactor: WeatherInteractor
    let title = "PRESSURE"
    let icon = "gauge.with.dots.needle.bottom.50percent"
    var  pressure: String? {
        guard let pressure = interactor.weatherData?.current.pressure else { return nil }
        return String(format: "%.2f", interactor.converthPAtoInHg(pressure))
    }
    
    init(interactor: WeatherInteractor) {
        self.interactor = interactor
    }
}
