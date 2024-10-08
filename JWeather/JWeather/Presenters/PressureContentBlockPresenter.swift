//
//  PressureContentBlockPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/7/24.
//

import Foundation

// MARK: Pressure Content Block Presenter



// MARK: - - Protocols
protocol PressureContentBlockPresentable {
    var pressure: String? { get }
}

// MARK: - - Presenter
class PressureContentBlockPresenter: ObservableObject {
    
    
    // MARK: - -- Properties
    private let interactor: WeatherInteractor
    let title = "PRESSURE"
    let icon = "gauge.with.dots.needle.bottom.50percent"
    @Published var pressure: String?
    
    // MARK: - -- Lifecycle
    init(interactor: WeatherInteractor) {
        self.interactor = interactor
        
        guard let pressure = interactor.weatherData?.current.pressure else { return }
        self.pressure = String(format: "%.2f", interactor.converthPAtoInHg(pressure))
    }
}
