//
//  WeatherInteractor.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

import Foundation

protocol WeatherInteractorActions {
    func createOneCallApiString(lat: Double, long: Double, exclusions: [String]?) -> String
    
}

class WeatherInteractor: ObservableObject, WeatherInteractorActions {
    private let networkService: Networking
    private let locationService: Locator
    @Published var weatherData: ApiResponse?
    @Published var geocodingData: [GeocodingApiResponse]?
    @Published var zipGeocodingData: ZipGeocodingApiResponse?
    
    init(networkService: Networking, locationService: Locator) {
        self.networkService = networkService
        self.locationService = locationService
        
        Task {
            try await getWeatherData()
            guard let lat = weatherData?.lat, let long = weatherData?.lon else { return }
            try await getGeocodingData(geocodingType: .reverse, state: nil, limit: 1, zip: nil, lat: String(lat), long: String(long))
            print(weatherData ?? "No weather data")
        }
    }
    
    func createOneCallApiString(lat: Double, long: Double, exclusions: [String]?) -> String {
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
    
    func createGeocodingApiString(type: GeocodingType, state: String?, limit: Int?, zip: String?, lat: String?, long: String?) throws -> String {
        var limitString = ""
        if let _limit = limit {
            if _limit < 1 {
                limitString.append("&limit=\(1)")
            } else if _limit > 5 {
                limitString.append("&limit=\(5)")
            } else {
                limitString.append("&limit=\(_limit)")
            }
        }
        
        switch type {
        case .direct:
            guard let state else { throw NetworkingError.invalidUrl("The request cannot be made. Invlaid url given. Check to make sure the proper input parameters were given (state is required).") }
            return "https://api.openweathermap.org/geo/1.0/direct?q=\(state)\(limitString)&appid=\(ApiKey.key)"
        case .reverse:
            guard let lat, let long else { throw NetworkingError.invalidUrl("The request cannot be made. Invlaid url given. Check to make sure the proper input parameters were given (lattitude & longitude are required).") }
            return "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(long)\(limitString)&appid=\(ApiKey.key)"
        case .zipPostal:
            guard let zip else { throw NetworkingError.invalidUrl("The request cannot be made. Invlaid url given. Check to make sure the proper input parameters were given (zip is required).") }
            return "https://api.openweathermap.org/geo/1.0/zip?zip=\(zip)&appid=\(ApiKey.key)"
        }
    }
    
    @MainActor
    func getWeatherData() async throws {
        do {
            let url = createOneCallApiString(lat: locationService.getLatitude(), long: locationService.getLongitude(), exclusions: nil)
            print(url)
            weatherData = try await networkService.get(urlPath: url, modelType: ApiResponse.self)
        } catch {
            throw error
        }
    }
    
    func getGeocodingData(geocodingType: GeocodingType, state: String?, limit: Int?, zip: String?, lat: String?, long: String?) async throws {
        do {
            let url = try createGeocodingApiString(type: geocodingType, state: state, limit: limit, zip: zip, lat: lat, long: long)
            print(url)
            
            switch geocodingType {
            case .direct, .reverse:
                let result = try await networkService.get(urlPath: url, modelType: [GeocodingApiResponse].self)
                self.geocodingData = result
            case .zipPostal:
                let result = try await networkService.get(urlPath: url, modelType: ZipGeocodingApiResponse.self)
                self.zipGeocodingData = result
            }
        } catch {
            print(error)
            throw error

        }
    }
        
    func convertKToF(_ kelvin: Float) -> Int {
        return Int((kelvin - 273.15) * 9/5 + 32)
    }
    
    func convertKToC(_ kelvin: Float) -> Int {
        return Int(kelvin - 273.15)
    }
    
    func convertUnixToTime(_ dt: Double) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma"
        dateFormatter.timeZone = .current
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        return dateFormatter.string(from: date)
    }
    
    func convertMToMiles(_ meters: Int) -> Double {
        return Double(meters) / 1609
    }
    
    func convertMMToInches(_ mm: Double) -> Double {
        return mm / 25.4
    }
    
    func converthPAtoInHg(_ hpa: Int) -> Double {
        return Double(hpa) / 33.8638853
    }
}
