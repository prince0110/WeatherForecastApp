//
//  Weather.swift
//  WeatherForecastApp
//
//  Created by Prince Gupta on 30/03/19.
//  Copyright © 2019 Prince Gupta. All rights reserved.
//

import Foundation

struct TrihoralWeather: Decodable {
    let forcastedTime: Int64
    let weathers: [Weather]
    let main: Main
    var dateText: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        forcastedTime = try values.decode(Int64.self, forKey: .forcastedTime)
        weathers = try values.decode([Weather].self, forKey: .weathers)
        main = try values.decode(Main.self, forKey: .main)
        dateText = try values.decode(String.self, forKey: .dateText)
        dateText = dateText.components(separatedBy: " ").first!
    }
    
    enum CodingKeys: String, CodingKey {
        case forcastedTime = "dt"
        case weathers = "weather"
        case dateText = "dt_txt"
        case main
    }
}


struct Weather: Decodable {
    let main: String
    let desc: String
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        main = try values.decode(String.self, forKey: .main)
        desc = try values.decode(String.self, forKey: .desc)
    }
    
    enum CodingKeys: String, CodingKey {
        case main
        case desc = "description"
    }
}

struct Main: Decodable {
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Double
    let humidity: Int
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        temp = try values.decode(Double.self, forKey: .temp)
        tempMin = try values.decode(Double.self, forKey: .tempMin)
        tempMax = try values.decode(Double.self, forKey: .tempMax)
        pressure = try values.decode(Double.self, forKey: .pressure)
        humidity = try values.decode(Int.self, forKey: .humidity)
    }
    
    enum CodingKeys: String, CodingKey {
        case temp
        case pressure
        case humidity
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

