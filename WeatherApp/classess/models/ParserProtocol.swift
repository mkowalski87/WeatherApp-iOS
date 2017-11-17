//
//  ParserProtocol.swift
//  WeatherApp
//
//  Created by Michał Kowalski on 16/11/2017.
//  Copyright © 2017 Michał Kowalski. All rights reserved.
//

import UIKit

class APIDateFormatter {
    static let apiDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:s.SSSSSS'Z'"
        return dateFormatter
    }()
}

protocol ParserProtocol {
    static func parseObject(data: Data) -> Self?
    static func parseArray(data: Data) -> [Self]?
}

extension ParserProtocol where Self:Decodable {
   
    static func parseObject(data: Data) -> Self? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(APIDateFormatter.apiDateFormatter)
        return try? decoder.decode(Self.self, from: data)
    }
    
    static func parseArray(data: Data) -> [Self]? {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(APIDateFormatter.apiDateFormatter)
        return try? decoder.decode([Self].self, from: data)
    }
}
