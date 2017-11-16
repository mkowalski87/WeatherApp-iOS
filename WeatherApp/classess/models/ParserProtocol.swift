//
//  ParserProtocol.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

protocol ParserProtocol {
    static func parseObject(data: Data) -> Self?
    static func parseArray(data: Data) -> [Self]?
}

extension ParserProtocol where Self:Decodable {
    static func parseObject(data: Data) -> Self? {
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
    
    static func parseArray(data: Data) -> [Self]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([Self].self, from: data)
    }
}
