//
//  WeatherForecastViewController.swift
//  WeatherForecastApp
//
//  Created by Prince Gupta on 30/03/19.
//  Copyright © 2019 Prince Gupta. All rights reserved.
//

import UIKit

class ForecastCell: UITableViewCell {

    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var forecastView: UIView!
    
    
    var viewModel: WeatherForecastViewModel! {
        didSet {
            tempLabel.text = viewModel.temp
            descLabel.text = viewModel.desc
            timeLabel.text = viewModel.time
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
