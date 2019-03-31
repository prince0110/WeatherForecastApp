//
//  WeatherForecastViewController+UITableView.swift
//  WeatherForecastApp
//
//  Created by Prince Gupta on 30/03/19.
//  Copyright © 2019 Prince Gupta. All rights reserved.
//

import Foundation
import UIKit

extension WeatherForecastViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dates[section])
        dateFormatter.dateFormat = "MMM d, yyyy"
        let dateString = dateFormatter.string(from: date!)
        return dateString
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let values = dataDict[dates[section]]
        return values?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath) as! ForecastCell
        let values = dataDict[dates[indexPath.section]]
        cell.viewModel = WeatherForecastViewModel(weather: values![indexPath.row])
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.white
            cell.forecastView.backgroundColor = UIColor.white

        }
        else {
            cell.backgroundColor = UIColor.hexStringToUIColor(hex: HEX_COLOR.LIGHT_PINK_COLOR)
            cell.forecastView.backgroundColor = UIColor.hexStringToUIColor(hex: HEX_COLOR.LIGHT_PINK_COLOR)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
