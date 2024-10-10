//
//  Untitled.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

struct ApiResponse: Decodable {
    let lat: Double
    let lon: Double
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let minutely: [Minutely]?
    let hourly: [Current]?
    let daily: [Daily]?
    let alerts: [WeatherAlert]?
}

struct Current: Decodable, Hashable {
    let dt: Double
    let sunrise: Double?
    let sunset: Double?
    let temp: Float
    let feelsLike: Float
    let pressure: Int
    let humidity: Int
    let dewPoint: Float
    let uvi: Float
    let clouds: Int
    let visibility: Int
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double?
    let rain: Rain?
    let snow: Snow?
    let weather: [Weather]
    let pop: Float?
}

struct Weather: Decodable, Hashable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Rain: Decodable, Hashable {
    let oneH: Double
    
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
    }
}

struct Snow: Decodable, Hashable {
    let oneH: Double
    
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
    }
}

struct Minutely: Decodable {
    let dt: Double?
    let precipitation: Int?
}

struct Daily: Decodable, Hashable {
    let dt: Double
    let sunrise: Double
    let sunset: Double
    let moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let summary: String
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Float
    let windSpeed: Double
    let windDeg: Int
    let windGust: Double
    let weather: [Weather]
    let clouds: Int
    let pop: Float
    let rain: Float?
    let snow: Float?
    let uvi: Float
}

struct Temp: Decodable, Hashable {
    let day: Float
    let min: Float
    let max: Float
    let night: Float
    let eve: Float
    let morn: Float
}

struct FeelsLike: Decodable, Hashable {
    let day: Float
    let night: Float
    let eve: Float
    let morn: Float
}

struct WeatherAlert: Decodable {
    let senderName: String?
    let event: String?
    let start: Double
    let end: Double
    let description: String
    let tags: [String]
}

struct GeocodingApiResponse: Decodable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
    let state: String?
}

struct ZipGeocodingApiResponse: Decodable {
    let zip: String
    let name: String
    let lat: Double
    let lon: Double
    let country: String
}
