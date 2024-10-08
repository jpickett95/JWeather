//
//  WeatherInteractorTests.swift
//  JWeatherTests
//
//  Created by Jonah Pickett on 10/3/24.
//

import XCTest
@testable import JWeather

class MOCKNetworkService: Networking {
    func get<Model>(urlPath: String, modelType: Model.Type) async throws -> Model where Model : Decodable {
        return ApiResponse(lat: 34.43443, lon: -84.12452, timezone: "time", timezoneOffset: 5, current: Current(dt: 434353353, sunrise: 3232324, sunset: 32422323, temp: 2323.56, feelsLike: 2323.45, pressure: 3232, humidity: 3232, dewPoint: 32323.56, uvi: 323.67, clouds: 3, visibility: 23, windSpeed: 3232323.323, windDeg: 32323, windGust: 323232.3232, rain: Rain(oneH: 223.3232), snow: Snow(oneH: 3232.3232), weather: [Weather(id: 232, main: "fddfsd", description: "sdsds", icon: "ddsds")], pop: 332.343), minutely: [Minutely(dt: 2243434.34, precipitation: 32323)], hourly: [Current(dt: 434353353, sunrise: 3232324, sunset: 32422323, temp: 2323.56, feelsLike: 2323.45, pressure: 3232, humidity: 3232, dewPoint: 32323.56, uvi: 323.67, clouds: 3, visibility: 23, windSpeed: 3232323.323, windDeg: 32323, windGust: 323232.3232, rain: Rain(oneH: 223.3232), snow: Snow(oneH: 3232.3232), weather: [Weather(id: 232, main: "fddfsd", description: "sdsds", icon: "ddsds")], pop: 332.343)], daily: [Daily](), alerts: [WeatherAlert]()) as! Model
    }
    
    func getData(urlPath: String) async throws -> Data {
        return Data()
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
    var subjectUnderTest: WeatherInteractor!

    override func setUp() {
        subjectUnderTest = WeatherInteractor(networkService: MOCKNetworkService(), locationService: MOCKLocationService())
    }

    override func tearDown() {
        subjectUnderTest = nil
    }

    func test() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

}
