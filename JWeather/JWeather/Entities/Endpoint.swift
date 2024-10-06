//
//  Endpoint.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/3/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol Endpoint {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var method: HTTPMethod { get }
    var parameters: [String: String] { get }
    var path: String { get }
}

struct ContentEndpoint: Endpoint {
    var baseURL: URL = .init(string: "https://api.openweathermap.org/data/3.0")!
    var headers: [String: String] = [:]
    var method: HTTPMethod = .get
    var parameters: [String: String] = [:]
    var path: String = "/onecall"
}

extension ContentEndpoint {
    static func oneCall(latitude: Double, longitude: Double, exclusions: [Exclusion]?, units: Unit?, language: Language?) -> Self {
        var parameters = [
            "lat": "\(latitude)",
            "lon": "\(longitude)",
            "appid": ApiKey.key
        ]
        
        if let _exclusions = exclusions {
            parameters["exclude"] = _exclusions.map(\.rawValue).joined(separator: ",")
        }
        
        if let _units = units {
            parameters["unit"] = _units.rawValue
        }

        if let _language = language {
            parameters["lang"] = _language.rawValue
        }
        
        return ContentEndpoint(parameters: parameters)
    }
}
