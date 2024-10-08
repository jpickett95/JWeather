//
//  Errors.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

// MARK: - Error Entities



// MARK: - - Networking
/**
 Possible errors that can be thrown by NetworkManager networking functions.
 ### Error Cases:
 - invalidUrl
 - invalidResponse
 - dataError
 - unknown
 */
enum NetworkingError: Error {
    /// The URL path is invalid or corrupted.
    case invalidUrl(String)
    /// The URLSession returned with a HTTPURLResponce status code outside of the range (200-299).
    case invalidResponse(String)
    /// An error occurred while decoding data.
    case dataError
    /// An unknown error has occurred
    case unknown(String)
}

// MARK: - - Decoding
/**
 Possible error that can be thrown from decoding
 ### Error Cases:
 - invalidJSON
 - invalidData
 - missingKey
 - typeMismatch
 */
enum DecodingError: Error {
    case invalidJSON
    case invalidData(String)
    case missingKey
    case typeMismatch
}


// MARK: - - Client Error
/**
 Possible errors thrown from http repsonse codes in the 400s range
 
 ### HTTP Repsonse Status Codes:
 400, 401, 402, 403, 404, 405, 406, 407, 408, 409, 410, 411, 412, 413, 414, 415, 416, 417, 418, 421, 422, 423, 424, 425, 426, 428, 429, 431, 451
 */
enum ClientErrorResponse: Error {
    /// Response code 400
    case badRequest(String)
    /// Response code 401
    case unauthorized(String)
    /// Response code 402
    case paymentRequired(String)
    /// Response code 403
    case forbidden(String)
    /// Response code 404
    case notFound(String)
    /// Response code 405
    case methodNotAllowed(String)
    /// Response code 406
    case notAcceptable(String)
    /// Response code 407
    case proxyAuthenticationRequired(String)
    /// Response code 408
    case requestTimeout(String)
    /// Response code 409
    case conflict(String)
    /// Response code 410
    case gone(String)
    /// Response code 411
    case lengthRequired(String)
    /// Response code 412
    case preconditionFailed(String)
    /// Response code 413
    case payloadTooLarge(String)
    /// Response code 414
    case URITooLong(String)
    /// Response code 415
    case unsupportedMediaType(String)
    /// Response code 416
    case rangeNotSatisfiable(String)
    /// Response code 417
    case expectationFailed(String)
    /// Response code 418
    case imATeapot(String)
    /// Response code 421
    case misdirectedRequest(String)
    /// Response code 422
    case unprocessableContent(String)
    /// Response code 423
    case locked(String)
    /// Response code 424
    case failedDependency(String)
    /// Response code 425
    case tooEarly(String)
    /// Response code 426
    case upgradeRequired(String)
    /// Response code 428
    case preconditionRequired(String)
    /// Response code 429
    case tooManyRequests(String)
    /// Repsonse code 431
    case requestHeaderFieldsTooLarge(String)
    /// Repsonse code 451
    case unavailableForLegalReasons(String)
}


// MARK: - - Server Error
/**
 Possible errors thrown from http repsonse codes in the 500s range
 
 ### HTTP Repsonse Status Codes:
 500, 501, 502, 503, 504, 505, 506, 507, 508, 510, 511
 */
enum ServerErrorResponse: Error {
    /// Response code 500
    case internalServerError(String)
    /// Response code 501
    case notImplemented(String)
    /// Response code 502
    case badGateway(String)
    /// Response code 503
    case serviceUnavailable(String)
    /// Response code 504
    case gatewayTimeout(String)
    /// Response code 505
    case httpVersionNotSupported(String)
    /// Response code 506
    case variantAlsoNegotiates(String)
    /// Response code 507
    case insufficientStorage(String)
    /// Response code 508
    case loopDetected(String)
    /// Response code 510
    case notExtended(String)
    /// Repsonse code 511
    case networkAuthenticationRequired(String)
}
