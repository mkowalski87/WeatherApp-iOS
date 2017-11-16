//
//  APIRequest.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 15/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case GET, POST
}

public protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: Any]? { get }
}

enum APIEndpoint: Endpoint {
    case searchLocation(query: String)
    case getWeather(locationId: Int32)
}

extension APIEndpoint {
    var method: HTTPMethod {
        switch self {
        case .searchLocation:
            return .GET
        case .getWeather:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .searchLocation:
            return "location/search"
        case .getWeather(let locationId):
            return "location/\(locationId)"
        }
    }
    
    var queryParameters: [String: Any]? {
        switch self {
        case .searchLocation(let query):
            return ["query": query]
        case .getWeather:
            return nil
        }
    }
    
}

public struct APIRequest {
    public let endpoint: Endpoint
    private let baseURL: URL = URL(string: "https://www.metaweather.com/api/")!
    var body: Data?
    let queryParameters: [String: Any]?
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
        queryParameters = endpoint.queryParameters
    }
    
    private var queryItems: [URLQueryItem]? {
        return queryParameters.map { $0.map { (key, value) in URLQueryItem(name: key, value: "\(value)") } }
    }
    
    public var method: HTTPMethod {
        return endpoint.method
    }
    
    public var url: URL {
        guard var components = URLComponents(url: baseURL.appendingPathComponent(endpoint.path, isDirectory: false), resolvingAgainstBaseURL: false) else {
            fatalError("Base URL or endpoint path is wrong!")
        }
        components.queryItems = queryItems
        
        guard let finalUrl = components.url else {
            fatalError("Query parameters are not encodable")
        }
        
        return finalUrl
    }
    
    public var httpRequest: URLRequest {
        var httpRequest = URLRequest(url: url)
        httpRequest.httpMethod = method.rawValue
        return httpRequest
    }
}
