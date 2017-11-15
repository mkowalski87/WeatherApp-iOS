//
//  APIClient.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 15/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import Foundation

final class APIClient: NSObject, URLSessionDelegate {

    // MARK: Properties
    private var session: URLSession!
    
    // MARK: Initializers
    override init() {
        super.init()
        session = URLSession(configuration: .ephemeral, delegate: self, delegateQueue: nil)
    }
  
    func data(_ request: APIRequest, completionBlock: @escaping (DataResponse) -> Void) -> URLSessionDataTask {
        let task = session.dataTask(with: request.httpRequest, completionHandler: { (data, response, error) -> Void in
            guard let response = DataResponse.responseObject(data: data, httpResponse: response as? HTTPURLResponse, error: error) else {
                fatalError("Unexpected response type")
            }
            completionBlock(response)
        })
        task.resume()
        return task
    }
}
