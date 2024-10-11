//
//  WeatherInteractor.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

import Foundation

// MARK: Weather Interactor



// MARK: - - Protocol
protocol WeatherInteractorActions {
    
    
    // MARK: - -- Properties
    var weatherData: ApiResponse? { get }
    var geocodingData: [GeocodingApiResponse]? { get }
    var zipGeocodingData: ZipGeocodingApiResponse? { get }
    
    // MARK: - -- Methods
    func getWeatherData(lat: Double?, long: Double?) async throws
    func getGeocodingData(geocodingType: GeocodingType, stateOrCity: String?, limit: Int?, zip: String?, lat: String?, long: String?) async throws
    func convertKToF(_ kelvin: Float) -> Int
    func convertKToC(_ kelvin: Float) -> Int
    func convertUnixToTime(_ dt: Double) -> String
    func convertMToMiles(_ meters: Int) -> Double
    func convertMMToInches(_ mm: Double) -> Double
    func converthPAtoInHg(_ hpa: Int) -> Double
}

// MARK: - - Interactor

/**
 An interactor object that handles networking & location services. Also contains functions for formatting data from api responses.
 */
class WeatherInteractor: ObservableObject, WeatherInteractorActions {
    
    
    // MARK: - -- Properties
    private let networkService: Networking
    private let locationService: Locator
    @Published var weatherData: ApiResponse?
    @Published var geocodingData: [GeocodingApiResponse]?
    @Published var zipGeocodingData: ZipGeocodingApiResponse?
    
    // MARK: - -- Lifecycle
    init(networkService: Networking, locationService: Locator) {
        self.networkService = networkService
        self.locationService = locationService
    }
    
    // MARK: - -- Methods
    
    /**
     Creates an api url, given the lattitude, longitude, and optional exclusions
     
     - Parameters:
        - lat: The lattitude of the location as a Double.
        - long: The longitude of the location as a Double.
        - exclusions: An optional array of strings that represent which data points to exclude from the api call. (i.e. current, minutely, hourly, daily, alerts)
     
     - Returns: A String url.
     */
    private func createOneCallApiString(lat: Double, long: Double, exclusions: [String]?) -> String {
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
    
    /**
     Creates an api url, given the geocoding type and input parameters. Geocoding api call is determined by the 'type' input parameter. May throw an error if the required input for the specified geocoding type is not valid.
     
     - Parameters:
        - type: The geocoding type which determines which api call is made. (i.e. direct, reverse, zipPostal)
        - stateOrCity: An optional String value containing the specified location state or city. Used for direct geocoding.
        - limit: An optional Integer value representing the limit of how many results desired from the api. Maximum value is 5. If the given input is greater than 5, only up to the maximum of 5 will be returned; if less than 1, the input will be ignored; if no limit is given or if ignored, may return up to 5 depending on what the api returns.
        - zip: An optional String value containing the zip code of the specified location. Used for zipPostal geocoding. If entering a zip/postal code for a location outside of the United States, the code & country code are required (comma separated). (i.e. 32826 or E14,GB)
        - lat: An optional String value containing the lattitude of the specified location. Used for reverse geocoding.
        - long: An optional String value containing the longitude of the specified location. Used for reverse geocoding.
     
     - Returns: A String url.
     
     - Throws: A NetworkingError if the required input for the specified geocoding type is not valid.
     */
    private func createGeocodingApiString(type: GeocodingType, stateOrCity: String?, limit: Int?, zip: String?, lat: String?, long: String?) throws -> String {
        var limitString = ""
        if let _limit = limit {
            if _limit > 5 {
                limitString.append("&limit=\(5)")
            } else if _limit >= 1 {
                limitString.append("&limit=\(_limit)")
            }
        }
        
        switch type {
        case .direct:
            guard let stateOrCity else { throw NetworkingError.invalidUrl("The request cannot be made. Invlaid url given. Check to make sure the proper input parameters were given (state is required).") }
            return "https://api.openweathermap.org/geo/1.0/direct?q=\(stateOrCity)\(limitString)&appid=\(ApiKey.key)"
        case .reverse:
            guard let lat, let long else { throw NetworkingError.invalidUrl("The request cannot be made. Invlaid url given. Check to make sure the proper input parameters were given (lattitude & longitude are required).") }
            return "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(long)\(limitString)&appid=\(ApiKey.key)"
        case .zipPostal:
            guard let zip else { throw NetworkingError.invalidUrl("The request cannot be made. Invlaid url given. Check to make sure the proper input parameters were given (zip is required).") }
            return "https://api.openweathermap.org/geo/1.0/zip?zip=\(zip)&appid=\(ApiKey.key)"
        }
    }
    
    /**
     An asynchronous function that fetches weather data from the OneCall api and stores it within the interactor's weatherData property. May throw an error if the call fails or there is a decoding error. If parameters are nil, will get the device's location lattitude & longitude to make the api call.
     
     - Parameters:
        - lat: An optional Double value containing the lattitude of the specified location.
        - long: An optional Double value containing the longitude of the specified location.
     
     - Throws: An Error if the api call fails or there is a decoding error.
     */
    @MainActor
    func getWeatherData(lat: Double?, long: Double?) async throws {
        do {
            var url = ""
            if let lat, let long {
                url = createOneCallApiString(lat: lat, long: long, exclusions: nil)
            } else {
                url = createOneCallApiString(lat: locationService.getLatitude(), long: locationService.getLongitude(), exclusions: nil)
            }
            print(url)
            weatherData = try await networkService.get(urlPath: url, modelType: ApiResponse.self)
        } catch {
            throw error
        }
    }
    
    /**
     An asynchronous function that takes various input for the specified geocoding api call, and stores the fetched data within the interactor's geocodingData/zipGeocodingData properties. Geocoding api call is determined by the 'geocodingType' input parameter. May throw an error if the api call fails or there is a decoding error.
     
     - Parameters:
        - geocodingType:The geocoding type which determines which api call is made. (i.e. direct, reverse, zipPostal)
        - stateOrCity: An optional String value containing the specified location state or city. Used for direct geocoding.
        - limit: An optional Integer value representing the limit of how many results desired from the api. Maximum value is 5. If the given input is greater than 5, only up to the maximum of 5 will be returned; if less than 1, the input will be ignored; if no limit is given or if ignored, may return up to 5 depending on what the api returns.
        - zip: An optional String value containing the zip code of the specified location. Used for zipPostal geocoding. If entering a zip/postal code for a location outside of the United States, the code & country code are required (comma separated). (i.e. 32826 or E14,GB)
        - lat: An optional String value containing the lattitude of the specified location. Used for reverse geocoding.
        - long: An optional String value containing the longitude of the specified location. Used for reverse geocoding.
     
     - Throws: An Error if the api call fails or there is a decoding error.
     */
    @MainActor
    func getGeocodingData(geocodingType: GeocodingType, stateOrCity: String?, limit: Int?, zip: String?, lat: String?, long: String?) async throws {
        do {
            let url = try createGeocodingApiString(type: geocodingType, stateOrCity: stateOrCity, limit: limit, zip: zip, lat: lat, long: long)
            
            switch geocodingType {
            case .direct, .reverse:
                let result = try await networkService.get(urlPath: url, modelType: [GeocodingApiResponse].self)
                self.geocodingData = result
            case .zipPostal:
                let result = try await networkService.get(urlPath: url, modelType: ZipGeocodingApiResponse.self)
                self.zipGeocodingData = result
            }
        } catch {
            throw error
        }
    }
    
    /**
     A function that converts the given input from Kelvin to Fahrenheit.
     
     - Parameters:
        - kelvin: A Float value representing a temperature in Kelvin (K).
     
     - Returns: An integer value representing the converted temperature in Fahrenheit (°F).
     */
    func convertKToF(_ kelvin: Float) -> Int {
        return Int((kelvin - 273.15) * 9/5 + 32)
    }
    
    /**
     A function that converts the given input from Kelvin to Celsius.
     
     - Parameters:
        - kelvin: A Float value representing a temperature in Kelvin
     
     - Returns: An integer value representing the converted temperature in Celsius (°C).
     */
    func convertKToC(_ kelvin: Float) -> Int {
        return Int(kelvin - 273.15)
    }
    
    /**
     A function that converts the given epoch (unix) time into a DateTime String.
     
     - Parameters:
        - dt: A Double value representing the time in epoch (unix) format
     
     - Returns: A String value containing the time in h:mm am/pm format. (i.e. 2:33am)
     */
    func convertUnixToTime(_ dt: Double) -> String {
        let date = Date(timeIntervalSince1970: dt)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mma"
        dateFormatter.timeZone = .current
        dateFormatter.amSymbol = "am"
        dateFormatter.pmSymbol = "pm"
        return dateFormatter.string(from: date)
    }
    
    /**
     A function that converts the given measurement from meters to miles.
     
     - Parameters:
        - meters: An Integer value containing the measurement in meters (m).
     
     - Returns: A Double value representing the measurement in miles (mi).
     */
    func convertMToMiles(_ meters: Int) -> Double {
        return Double(meters) / 1609
    }
    
    /**
     A function that converts the given measurement from millimeters to inches.
     
     - Parameters:
        - meters: An Integer value containing the measurement in millimeters (mm).
     
     - Returns: A Double value representing the measurement in inches (in).
     */
    func convertMMToInches(_ mm: Double) -> Double {
        return mm / 25.4
    }
    
    /**
     A function that converts the given measurement from hectopascal to inches of Mercury.
     
     - Parameters:
        - meters: An Integer value containing the measurement in hectopascal (hPa).
     
     - Returns: A Double value representing the measurement in inches of Mercury (inHg).
     */
    func converthPAtoInHg(_ hpa: Int) -> Double {
        return Double(hpa) / 33.8638853
    }
}
