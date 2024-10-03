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
        return ApiResponse(lat: <#T##Float#>, lon: <#T##Float#>, timezone: <#T##String#>, timezoneOffset: <#T##Int#>, current: <#T##Current#>, minutely: <#T##[Minutely]?#>, hourly: <#T##[Current]?#>, daily: <#T##[Daily]?#>, alerts: <#T##[WeatherAlert]?#>) as! Model
    }
    
    func getData(urlPath: String) async throws -> Data {
        return Data()
    }
    
    
}

final class WeatherInteractorTests: XCTestCase {
    var subjectUnderTest: WeatherInteractor!

    override func setUp() {
        subjectUnderTest = WeatherInteractor(networkService: MOCKNetworkService())
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
