//
//  Untitled.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

struct ApiResponse: Decodable {
    let lat: Float
    let lon: Float
    let timezone: String
    let timezoneOffset: Int
    let current: Current
    let minutely: [Minutely]?
    let hourly: [Current]?
    let daily: [Daily]?
    let alerts: [WeatherAlert]?
    
//    enum CodingKeys: String, CodingKey {
//        case lat, lon, timezone
//        case timezoneOffset = "timezone_offset"
//        case current, daily, minutely, hourly, alerts
//    }
}

struct Current: Decodable {
    let dt: Int
    let sunrise: Int?
    let sunset: Int?
    let temp: Float
    let feelsLike: Float
    let pressure: Int
    let humidity: Int
    let dewPoint: Float
    let uvi: Float
    let clouds: Int
    let visibility: Int
    let windSpeed: Float
    let windDeg: Int
    let windGust: Float?
    let rain: Rain?
    let snow: Snow?
    let weather: [Weather]
    let pop: Float?
    
//    enum CodingKeys: String, CodingKey {
//        case dt, sunrise, sunset, temp
//        case feelsLike = "feels_like"
//        case pressure, humidity
//        case dewPoint = "dew_point"
//        case uvi, clouds, visibility
//        case windSpeed = "wind_speed"
//        case windDeg = "wind_deg"
//        case windGust = "wind_gust"
//        case rain, snow, weather, pop
//    }
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Rain: Decodable {
    let oneH: Float
    
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
    }
}

struct Snow: Decodable {
    let oneH: Float
    
    enum CodingKeys: String, CodingKey {
        case oneH = "1h"
    }
}

struct Minutely: Decodable {
    let dt: Int?
    let precipitation: Int?
}

struct Daily: Decodable {
    let dt: Int
    let sunrise: Int
    let sunset: Int
    let moonrise: Int
    let moonset: Int
    let moonPhase: Double
    let summary: String
    let temp: Temp
    let feelsLike: FeelsLike
    let pressure: Int
    let humidity: Int
    let dewPoint: Float
    let windSpeed: Float
    let windDeg: Int
    let windGust: Float
    let weather: [Weather]
    let clouds: Int
    let pop: Float
    let rain: Float?
    let snow: Float?
    let uvi: Float
    
//    enum CodingKeys: String, CodingKey {
//        case dt, sunrise, sunset, moonrise, moonset
//        case moonPhase = "moon_phase"
//        case summary, temp
//        case feelsLike = "feels_like"
//        case pressure, humidity
//        case dewPoint = "dew_point"
//        case windSpeed = "wind_speed"
//        case windDeg = "wind_deg"
//        case windGust = "wind_gust"
//        case weather, clouds, pop, rain, snow, uvi
//    }
}

struct Temp: Decodable {
    let day: Float
    let min: Float
    let max: Float
    let night: Float
    let eve: Float
    let morn: Float
}

struct FeelsLike: Decodable {
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
    
//    enum CodingKeys: String, CodingKey {
//        case senderName = "sender_name"
//        case event, start, end, description, tags
//    }
}
