//
//  APIResponse.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 15/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import Foundation

enum APIError: Error {
    case UnexpectedStatusReceived
}

public enum DataResponse {
    case success(data: Data)
    case failure(error: Error)

    // MARK: Initializers
    public init?(data: Data?, error: Error?) {
        switch (data, error) {
        case let (.some(data), .none): self = .success(data: data)
        case let (_, .some(error)): self = .failure(error: error)
        case (.none, .none): return nil
        }
    }
    
    public static func responseObject(data: Data?, httpResponse: HTTPURLResponse?, error: Error?) -> DataResponse? {
        switch (data, httpResponse, error) {
        // For API errors equivalent status code and data with specific structure is expected.
        case let (_, .some(httpResponse), _) where httpResponse.statusCode >= 400:
            return DataResponse(data: nil, error: APIError.UnexpectedStatusReceived)
        case let (.some(data), .some(httpResponse), .none) where httpResponse.statusCode < 300:
            return DataResponse(data: data, error: nil)
        case let ( _, _, .some(error)):
            return DataResponse(data: nil, error: error)
        default:
            fatalError("not supported")
        }
    }
}
