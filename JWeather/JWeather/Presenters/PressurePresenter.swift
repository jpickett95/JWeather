//
//  PressureContentBlockPresenter.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/7/24.
//

import Foundation

// MARK: Pressure Presenter



// MARK: - - Protocols
protocol PressurePresentable {
    var pressure: String? { get }
    var title: String { get }
    var icon: String { get }
}

// MARK: - - Presenter
class PressurePresenter: ObservableObject, PressurePresentable {
    
    
    // MARK: - -- Properties
    private let interactor: WeatherInteractorActions
    let title = "PRESSURE"
    let icon = "gauge.with.dots.needle.bottom.50percent"
    @Published var pressure: String?
    
    // MARK: - -- Lifecycle
    init(interactor: WeatherInteractorActions) {
        self.interactor = interactor
        
        guard let pressure = interactor.weatherData?.current.pressure else { return }
        self.pressure = String(format: "%.2f", interactor.converthPAtoInHg(pressure))
    }
}
