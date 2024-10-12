//
//  WeatherInteractorTests.swift
//  JWeatherTests
//
//  Created by Jonah Pickett on 10/3/24.
//

import XCTest
@testable import JWeather

//class MOCKNetworkService: Networking {
//    func get<Model>(urlPath: String, modelType: Model.Type) async throws -> Model where Model : Decodable {
//        return ApiResponse(lat: 34.43443, lon: -84.12452, timezone: "time", timezoneOffset: 5, current: Current(dt: 434353353, sunrise: 3232324, sunset: 32422323, temp: 2323.56, feelsLike: 2323.45, pressure: 3232, humidity: 3232, dewPoint: 32323.56, uvi: 323.67, clouds: 3, visibility: 23, windSpeed: 3232323.323, windDeg: 32323, windGust: 323232.3232, rain: Rain(oneH: 223.3232), snow: Snow(oneH: 3232.3232), weather: [Weather(id: 232, main: "fddfsd", description: "sdsds", icon: "ddsds")], pop: 332.343), minutely: [Minutely(dt: 2243434.34, precipitation: 32323)], hourly: [Current(dt: 434353353, sunrise: 3232324, sunset: 32422323, temp: 2323.56, feelsLike: 2323.45, pressure: 3232, humidity: 3232, dewPoint: 32323.56, uvi: 323.67, clouds: 3, visibility: 23, windSpeed: 3232323.323, windDeg: 32323, windGust: 323232.3232, rain: Rain(oneH: 223.3232), snow: Snow(oneH: 3232.3232), weather: [Weather(id: 232, main: "fddfsd", description: "sdsds", icon: "ddsds")], pop: 332.343)], daily: [Daily](), alerts: [WeatherAlert]()) as! Model
//    }
//    
//    func getData(urlPath: String) async throws -> Data {
//        return Data()
//    }
//}

class MOCKNetworkService: Networking {
    let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func getData(urlPath: String) async throws -> Data {
        if let path = Bundle.main.url(forResource: fileName, withExtension: ".json") {
            return try Data(contentsOf: path)
        }
        
        throw NetworkingError.invalidUrl("Invalid url.")
    }
    
    func get<Model>(urlPath: String, modelType: Model.Type) async throws -> Model where Model : Decodable {
        let data = try await getData(urlPath: fileName)
        return try JSONDecoder().decode(modelType, from: data)
    }
                                                                                                                
                                                                                                
}

class MOCKLocationService: Locator {
    func getLatitude() -> Double {
        return 34.434343
    }
    
    func getLongitude() -> Double {
        return -85.323232
    }
    
    
}

final class WeatherInteractorTests: XCTestCase {
    var subjectUnderTest: WeatherInteractor?

    override func setUp() {
        super.setUp()
        //subjectUnderTest = WeatherInteractor(networkService: MOCKNetworkService(), locationService: MOCKLocationService())
    }

    override func tearDown() {
        super.tearDown()
        subjectUnderTest = nil
    }

    func testGetWeatherData_IsSuccess() async {
        // Given
        subjectUnderTest = WeatherInteractor(networkService: MOCKNetworkService(fileName: "MockResponse"), locationService: MOCKLocationService())
        let lattitude = 34.434343
        let longitude = -85.323232
        
        // When
        do {
            try await subjectUnderTest?.getWeatherData(lat: lattitude, long: longitude)
        } catch {
            print(error.localizedDescription)
        }
        
        // Then
        XCTAssertNotNil(subjectUnderTest?.weatherData)
    }
    
    func testCreateOneCallApiString_WithoutExclusions() {
        
    }

}
