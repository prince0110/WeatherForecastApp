//
//  WeatherForecastViewModel.swift
//  WeatherForecastApp
//
//  Created by Prince Gupta on 30/03/19.
//  Copyright © 2019 Prince Gupta. All rights reserved.
//

import Foundation

struct WeatherForecastViewModel {
    
    let desc: String
    let temp: String
    let time: String
    let dateFormatter = DateFormatter()
    
    init(weather: TrihoralWeather) {
        desc = weather.weathers.first!.desc.capitalized
        temp = "\(String(format: "%.1f", weather.main.tempMax))°C (Max) / \(String(format: "%.1f", weather.main.tempMin))°C (Min)"
        
        let date = Date(timeIntervalSince1970: TimeInterval(weather.forcastedTime))
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        time = "Time: " + dateFormatter.string(from: date)
    }
}
