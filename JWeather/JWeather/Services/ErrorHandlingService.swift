//
//  ErrorHandling.swift
//  JWeather
//
//  Created by Jonah Pickett on 10/1/24.
//

import Foundation

// MARK: - Error Handling



// MARK: - - Protocols
protocol ErrorHandling {
    static func statusCodeSwitch(_ statusCode: Int) -> Error
}

// MARK: - - Service
/**
 Manager that handles Errors & error messages
 
 ### Methods:
    - statusCodeSwitch: returns a ClientResponseError,  , or NetworkingError depending on the given status code input parameter.
 */
public struct ErrorHandlingService: ErrorHandling {
    // MARK: - - Methods
    /**
     A static function that returns a ClientResponseError,  , or NetworkingError depending on the given status code input parameter.
     
     Called using 'ErrorManager.statusCodeSwitch(_ statusCode: Int)'
     
     - Parameters:
        - statusCode: A status code as an Int object
     
     - Returns: A ClientResponseError,  , or NetworkingError with a descriptive String associative value, depending on the given status code input parameter.
     */
    public static func statusCodeSwitch(_ statusCode: Int) -> Error {
        switch(statusCode) {
        case 400:
            return ClientErrorResponse.badRequest("Client Error Response: (Bad Request) The server cannot or will not process the request due to something that is perceived to be a client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).")
        case 401:
            return ClientErrorResponse.unauthorized("Client Error Response: (Unauthenticated) Although the HTTP standard specifies \"unauthorized\", semantically this response means \"unauthenticated\". That is, the client must authenticate itself to get the requested response.")
        case 402:
            return ClientErrorResponse.paymentRequired("Client Error Response: (Payment Required) This response code is reserved for future use. The initial aim for creating this code was using it for digital payment systems, however this status code is used very rarely and no standard convention exists.")
        case 403:
            return ClientErrorResponse.forbidden("Client Error Response: (Forbidden) The client does not have access rights to the content; that is, it is unauthorized, so the server is refusing to give the requested resource. Unlike 401 Unauthorized, the client's identity is known to the server.")
        case 404:
            return ClientErrorResponse.notFound("Client Error Response: (Not Found) The server cannot find the requested resource. In the browser, this means the URL is not recognized. In an API, this can also mean that the endpoint is valid but the resource itself does not exist. Servers may also send this response instead of 403 Forbidden to hide the existence of a resource from an unauthorized client. This response code is probably the most well known due to its frequent occurrence on the web.")
        case 405:
            return ClientErrorResponse.methodNotAllowed("Client Error Response: (Method Not Allowed) The request method is known by the server but is not supported by the target resource. For example, an API may not allow calling DELETE to remove a resource.")
        case 406:
            return ClientErrorResponse.notAcceptable("Client Error Response: (Not Acceptable) This response is sent when the web server, after performing server-driven content negotiation, doesn't find any content that conforms to the criteria given by the user agent.")
        case 407:
            return ClientErrorResponse.proxyAuthenticationRequired("Client Error Response: (Proxy Authentication Required) This is similar to 401 Unauthorized but authentication is needed to be done by a proxy.")
        case 408:
            return ClientErrorResponse.requestTimeout("Client Error Response: (Request Timeout) This response is sent on an idle connection by some servers, even without any previous request by the client. It means that the server would like to shut down this unused connection. This response is used much more since some browsers, like Chrome, Firefox 27+, or IE9, use HTTP pre-connection mechanisms to speed up surfing. Also note that some servers merely shut down the connection without sending this message.")
        case 409:
            return ClientErrorResponse.conflict("Client Error Response: (Conflict) This response is sent when a request conflicts with the current state of the server.")
        case 410:
            return ClientErrorResponse.gone("Client Error Response: (Gone) This response is sent when the requested content has been permanently deleted from server, with no forwarding address. Clients are expected to remove their caches and links to the resource. The HTTP specification intends this status code to be used for \"limited-time, promotional services\". APIs should not feel compelled to indicate resources that have been deleted with this status code.")
        case 411:
            return ClientErrorResponse.lengthRequired("Client Error Response: (Length Required) Server rejected the request because the Content-Length header field is not defined and the server requires it.")
        case 412:
            return ClientErrorResponse.preconditionFailed("Client Error Response: (Precondition Failed) The client has indicated preconditions in its headers which the server does not meet.")
        case 413:
            return ClientErrorResponse.payloadTooLarge("Client Error Response: (Payload Too Large) Request entity is larger than limits defined by server. The server might close the connection or return an Retry-After header field.")
        case 414:
            return ClientErrorResponse.URITooLong("Client Error Response: (URI Too Long) The URI requested by the client is longer than the server is willing to interpret.")
        case 415:
            return ClientErrorResponse.unsupportedMediaType("Client Error Response: (Unsupported Media Type) The media format of the requested data is not supported by the server, so the server is rejecting the request.")
        case 416:
            return ClientErrorResponse.rangeNotSatisfiable("Client Error Response: (Range Not Satisfiable) The range specified by the Range header field in the request cannot be fulfilled. It's possible that the range is outside the size of the target URI's data.")
        case 417:
            return ClientErrorResponse.expectationFailed("Client Error Response: (Expectation Failed) This response code means the expectation indicated by the Expect request header field cannot be met by the server.")
        case 418:
            return ClientErrorResponse.imATeapot("Client Error Response: (I'm a teapot) The server refuses the attempt to brew coffee with a teapot.")
        case 421:
            return ClientErrorResponse.misdirectedRequest("Client Error Response: (Misdirected Request) The request was directed at a server that is not able to produce a response. This can be sent by a server that is not configured to produce responses for the combination of scheme and authority that are included in the request URI.")
        case 422:
            return ClientErrorResponse.unprocessableContent("Client Error Response: (Unprocessable Content) The request was well-formed but was unable to be followed due to semantic errors.")
        case 423:
            return ClientErrorResponse.locked("Client Error Response: (Locked) The resource that is being accessed is locked.")
        case 424:
            return ClientErrorResponse.failedDependency("Client Error Response: (Failed Dependency) The request failed due to failure of a previous request.")
        case 425:
            return ClientErrorResponse.tooEarly("Client Error Response: (Too Early) Indicates that the server is unwilling to risk processing a request that might be replayed.")
        case 426:
            return ClientErrorResponse.upgradeRequired("Client Error Response: (Upgrade Required) The server refuses to perform the request using the current protocol but might be willing to do so after the client upgrades to a different protocol. The server sends an Upgrade header in a 426 response to indicate the required protocol(s).")
        case 428:
            return ClientErrorResponse.preconditionRequired("Client Error Response: (Precondition Required) The origin server requires the request to be conditional. This response is intended to prevent the 'lost update' problem, where a client GETs a resource's state, modifies it and PUTs it back to the server, when meanwhile a third party has modified the state on the server, leading to a conflict.")
        case 429:
            return ClientErrorResponse.tooManyRequests("Client Error Response: (Too Many Requests) The user has sent too many requests in a given amount of time (\"rate limiting\").")
        case 431:
            return ClientErrorResponse.requestHeaderFieldsTooLarge("Client Error Response: (Request Header Fields Too Large) The server is unwilling to process the request because its header fields are too large. The request may be resubmitted after reducing the size of the request header fields.")
        case 451:
            return ClientErrorResponse.unavailableForLegalReasons("Client Error Response: (Unavailable For Legal Reasons) The user agent requested a resource that cannot legally be provided, such as a web page censored by a government.")
        case 500:
            return ServerErrorResponse.internalServerError("Server Error Response: (Internal Server Error) The server has encountered a situation it does not know how to handle.")
        case 501:
            return ServerErrorResponse.notImplemented("Server Error Response: (Not Implemented) The request method is not supported by the server and cannot be handled. The only methods that servers are required to support (and therefore that must not return this code) are GET and HEAD.")
        case 502:
            return ServerErrorResponse.badGateway("Server Error Response: (Bad Gateway) This error response means that the server, while working as a gateway to get a response needed to handle the request, got an invalid response.")
        case 503:
            return ServerErrorResponse.serviceUnavailable("Server Error Response: (Service Unavailable) The server is not ready to handle the request. Common causes are a server that is down for maintenance or that is overloaded. Note that together with this response, a user-friendly page explaining the problem should be sent. This response should be used for temporary conditions and the Retry-After HTTP header should, if possible, contain the estimated time before the recovery of the service. The webmaster must also take care about the caching-related headers that are sent along with this response, as these temporary condition responses should usually not be cached.")
        case 504:
            return ServerErrorResponse.gatewayTimeout("Server Error Response: (Gateway Timeout) This error response is given when the server is acting as a gateway and cannot get a response in time.")
        case 505:
            return ServerErrorResponse.httpVersionNotSupported("Server Error Response: (HTTP Version Not Supported) The HTTP version used in the request is not supported by the server.")
        case 506:
            return ServerErrorResponse.variantAlsoNegotiates("Server Error Response: (Variant Also Negotiates) The server has an internal configuration error: the chosen variant resource is configured to engage in transparent content negotiation itself, and is therefore not a proper end point in the negotiation process.")
        case 507:
            return ServerErrorResponse.insufficientStorage("Server Error Response: (Insufficient Storage) The method could not be performed on the resource because the server is unable to store the representation needed to successfully complete the request.")
        case 508:
            return ServerErrorResponse.loopDetected("Server Error Response: (Loop Detected) The server detected an infinite loop while processing the request.")
        case 510:
            return ServerErrorResponse.notExtended("Server Error Response: (Not Extended) Further extensions to the request are required for the server to fulfill it.")
        case 511:
            return ServerErrorResponse.networkAuthenticationRequired("Server Error Response: (Network Authentication Required) Indicates that the client needs to authenticate to gain network access.")
        default:
            return NetworkingErrors.unknown("Url session returned with an unknown or invalid response with status code: \(statusCode)")
        }
    }
}
