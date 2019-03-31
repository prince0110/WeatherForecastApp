//
//  Forecast.swift
//  WeatherForecastApp
//
//  Created by Prince Gupta on 31/03/19.
//  Copyright © 2019 Prince Gupta. All rights reserved.
//

import Foundation

struct Forecast: Decodable {
    let code: String
    let list: [TrihoralWeather]
    let city: City
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        list = try values.decode([TrihoralWeather].self, forKey: .list)
        city = try values.decode(City.self, forKey: .city)
        code = try values.decode(String.self, forKey: .code)
    }
    
    enum CodingKeys: String, CodingKey {
        case code = "cod"
        case list
        case city
    }
}

struct City: Decodable {
    let id: Int
    let name: String
    let country: String
    let coordinates: Cord
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        country = try values.decode(String.self, forKey: .country)
        coordinates = try values.decode(Cord.self, forKey: .coordinates)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case country
        case coordinates = "coord"
    }
}

struct Cord: Decodable {
    let lat: Double
    let long: Double
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decode(Double.self, forKey: .lat)
        long = try values.decode(Double.self, forKey: .long)
    }
    
    enum CodingKeys: String, CodingKey {
        case lat
        case long = "lon"
    }
}
