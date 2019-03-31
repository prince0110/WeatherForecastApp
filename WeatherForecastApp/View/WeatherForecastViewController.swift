//
//  WeatherForecastViewController.swift
//  WeatherForecastApp
//
//  Created by Prince Gupta on 30/03/19.
//  Copyright © 2019 Prince Gupta. All rights reserved.
//

import UIKit

class WeatherForecastViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    
    typealias Coordinates = (lat: Double, long: Double)
    typealias CityDesc = (city: String, coord: Coordinates)
    
    var cities: [CityDesc] = [(city: "Bangalore", (lat: 12.9716, long: 77.5946)),
                              (city:"Delhi", (lat: 28.7041, long: 77.1025)),
                              (city:"Mumbai", (lat: 19.0760, long: 72.8777)),
                              (city:"Chennai", (lat: 13.0827, long: 80.2707)),
                              (city:"Kolkata", (lat: 22.5726, long: 88.3639))]
    var currentCity: CityDesc = ("", (0,0)) {
        didSet {
            url = String(format: Api.Weather.triHoral, "\(currentCity.coord.lat)", "\(currentCity.coord.long)" )
        }
    }
    var url = ""
    var dataDict = [String: [TrihoralWeather]]()
    var dates = [String]()
    let dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchData()
    }
    
    //MARK: - UI Setup -
    private func setupUI() {
        self.navigationController?.navigationBar.barTintColor = UIColor.hexStringToUIColor(hex: HEX_COLOR.PINK_COLOR)
        currentCity = cities.first!
        let nib = UINib(nibName: "ForecastCell", bundle: nil)
        self.tableview.register(nib, forCellReuseIdentifier: "ForecastCell")
        setupNavButton()
    }
    
    private func setupNavButton() {
        navigationItem.titleView = nil
        
        let button =  UIButton(type: .custom)
        button.frame = .zero
        let attrString = NSAttributedString(string: currentCity.city, attributes: [.font : UIFont.boldSystemFont(ofSize: 22.0), .foregroundColor: UIColor.white])
        button.setAttributedTitle(attrString, for: .normal)
        button.titleLabel?.sizeToFit()
        button.addTarget(self, action: #selector(clickOnButton), for: .touchUpInside)
        navigationItem.titleView = button
    }
    
    @objc func clickOnButton() {
        let sheet = UIAlertController(title: "Select city", message: "", preferredStyle: .actionSheet)
        cities.forEach {
            let action = UIAlertAction(title: $0.city, style: .default) { (act) in
                let idx = sheet.actions.firstIndex(of: act)!
                self.currentCity = self.cities[idx]
                self.setupNavButton()
                self.fetchData()
            }
            sheet.addAction(action)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        sheet.addAction(cancel)
        present(sheet, animated: true, completion: nil)
    }
    
    //MARK: - API Call -
    private func fetchData() {
        do {
            try HttpWorker.shared.getData(from: url) { (model: Forecast?, error) in
                self.dataDict = [:]
                self.dates = []
                
                if let model = model {
                    let array = model.list.sorted { $0.forcastedTime < $1.forcastedTime }
                    for (_, val) in array.enumerated() {
                        if let _ = self.dataDict[val.dateText] {
                            self.dataDict[val.dateText]?.append(val)
                            if !self.dates.contains(val.dateText) {
                                self.dates.append(val.dateText)
                            }
                        } else {
                            self.dataDict[val.dateText] = []
                            self.dataDict[val.dateText]?.append(val)
                        }
                    }
                } else {
                    AppUtils.showAlert(msg: "Could not fetch data")
                }
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
        } catch {
            AppUtils.showAlert(msg: "Could not fetch data")
            print("Error ==== \(error)")
        }
    }
}
