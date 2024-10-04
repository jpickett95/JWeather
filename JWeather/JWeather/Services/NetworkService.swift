//
//  NetworkService.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

import Foundation

// MARK: - Networking



// MARK: - - Protocols
protocol Networking {
    func getData(urlPath: String) async throws -> Data
    func get<Model: Decodable>(urlPath: String, modelType: Model.Type) async throws -> Model
}

// MARK: - - Service
/**
 A singleton that manages URL network connections & API calls.
 ### Supports:
 - Retrieving data from a URL path.
 - Decoding data using JSONDecoder.
 */
public struct NetworkService: Networking {
    
    // MARK: - -- Methods
    /**
     An asynchronous, function that returns data from the given url path input parameter.
          
     - Parameters:
        - urlPath: A String value containing the url path.

     - Returns: The data retieved from the url path as a Data object.
     
     - Throws: An Error if there is an invalid URLResponse or url path.
     */
    public func getData(urlPath: String) async throws -> Data {
        
        guard let url = URL(string: urlPath) else {
            throw NetworkingErrors.invalidUrl("The url path entered is not valid.")
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        let httpResponse = response as? HTTPURLResponse
        guard let _response = httpResponse, (200...299).contains(_response.statusCode) else {
            throw ErrorHandlingService.statusCodeSwitch(httpResponse?.statusCode ?? 0)
        }
        
        return data
    }
    
    /**
     An asynchronous, generic function that returns decoded data from the given url path input parameter, and returns the data as an object of the specified modelType input parameter.
          
     - Parameters:
        - urlPath: A String value containing the url path.
        - modelType: The type of the object model the data is to be decoded into.

     - Returns: The data retieved from the url path as an object specified by the modelType input parameter.
     
     - Throws: A 'NetworkingError' if there is an invalid URLResponse or url path; or an Error if decoding fails.
     */
    public func get<Model: Decodable>(urlPath: String, modelType: Model.Type) async throws -> Model {
        let data = try await getData(urlPath: urlPath)
        return try await decode(data: data, modelType: modelType)
    }
}

// MARK: - JSON Decoder


// MARK: - - Protocols
protocol JSONDecoding {
    func decode<Model: Decodable>(data: Data, modelType: Model.Type) async throws -> Model
}

// MARK: - - Service Extension
extension NetworkService: JSONDecoding {
    
    // MARK: - -- Methods
    /**
     An asynchronous, generic function that returns an object  as the specific type of the given modelType input parameter, from the given data input parameter.
     
     Called using 'try await LoginManager.savePassword(username: stringValue, password: stringValue)', wrapped within a Task object.
     
     - Parameters:
        - data: A Data object containing the data to be decoded.
        - modelType: The type of the object model the data is to be decoded into.

     - Returns: The decoded data as an object specified by the modelType input parameter.
     
     - Throws: An Error if the deocding fails.
     */
    public func decode<Model>(data: Data, modelType: Model.Type) async throws -> Model where Model : Decodable {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Model.self, from: data)
    }
}
