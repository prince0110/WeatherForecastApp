//
//  AppUtils.swift
//  WeatherForecastApp
//
//  Created by Prince Gupta on 31/03/19.
//  Copyright © 2019 Prince Gupta. All rights reserved.
//

import Foundation
import UIKit

struct AppUtils {
    
    static func showAlert(title: String = "Alert!", msg: String, ok action: UIAlertAction? = nil, cancel: UIAlertAction? = nil) {
        DispatchQueue.main.async {
            let controller = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            if action != nil {
                controller.addAction(action!)
            } else {
                let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
                controller.addAction(ok)
            }
            
            if cancel != nil {
                controller.addAction(cancel!)
            }
            
            let vc = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
            vc?.present(controller, animated: true, completion: nil)
        }
    }
}
