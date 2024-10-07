//
//  WeatherInteractor.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

protocol WeatherInteractorActions {
    func createApiCallString(lat: Double, long: Double, exclusions: [String]?) -> String
    
}

class WeatherInteractor: WeatherInteractorActions {
    private let networkService: Networking
    private let locationService: Locator
    var weatherData: ApiResponse?
    
    init(networkService: Networking, locationService: Locator) {
        self.networkService = networkService
        self.locationService = locationService
    }
    
    func createApiCallString(lat: Double, long: Double, exclusions: [String]?) -> String {
        var exclusionsString = ""
        if let _exclusions = exclusions {
            exclusionsString.append("&exclude=")
            for exclusion in _exclusions {
                exclusionsString.append(exclusion)
                if _exclusions.last != exclusion {
                    exclusionsString.append(",")
                }
            }
        }
        return "https://api.openweathermap.org/data/3.0/onecall?lat=\(lat)&lon=\(long)\(exclusionsString)&appid=\(ApiKey.key)"
    }
    
    func getWeatherData() {
        Task {
            do {
                let url = createApiCallString(lat: locationService.getLatitude(), long: locationService.getLongitude(), exclusions: nil)
                print(url)
                weatherData = try await networkService.get(urlPath: url, modelType: ApiResponse.self)
            } catch {
                print(error.localizedDescription)
            }
            print(weatherData ?? "weatherData is empty")
        }
    }
    
    func getCurrentWeatherData() {
        
    }
    
    func convertKToF(_ kelvin: Float) -> Int {
        return Int((kelvin - 273.15) * 9/5 + 32)
    }
    
    func convertKToC(_ kelvin: Float) -> Int {
        return Int(kelvin - 273.15)
    }
}
