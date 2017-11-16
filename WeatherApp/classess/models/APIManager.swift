
//
//  APIManager.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 15/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import Foundation

struct GetWeatherResponse: Codable, ParserProtocol {
    let consolidated_weather: [WeatherDTO]
}

class APIManager {
    
    let apiClient = APIClient()
    
    func searchLocations(with query: String, completion:(([LocationDTO]?, Error?)->(Void))?) {
        let request = APIRequest(endpoint: APIEndpoint.searchLocation(query: query))
        _ = apiClient.data(request) { (response) in
            switch response {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
            case .success(let data):
                DispatchQueue.main.async {
                    completion?(LocationDTO.parseArray(data: data), nil)
                }
            }
        }
    }

    func getCurrentWeather(for locationId: Int32, completion:(([WeatherDTO]?, Error?)->(Void))?) {
        let request = APIRequest(endpoint: APIEndpoint.getWeather(locationId: locationId))
        
        _ = apiClient.data(request) { (response) in
            switch response {
            case .failure(let error):
                DispatchQueue.main.async {
                    completion?(nil, error)
                }
            case .success(let data):
                guard let responseObject = GetWeatherResponse.parseObject(data: data) else {
                    DispatchQueue.main.async {
                        completion?(nil, APIError.ParsingResponseError)
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion?(responseObject.consolidated_weather, nil)
                }
            }
        }
    }
    
}
