//
//  HttpWorker.swift
//  WeatherForecastApp
//
//  Created by Prince Gupta on 30/03/19.
//  Copyright © 2019 Prince Gupta. All rights reserved.
//

import Foundation

struct Api {
    struct Weather {
        static let triHoral = "https://api.openweathermap.org/data/2.5/forecast?lat=%@&lon=%@&appid=ea574594b9d36ab688642d5fbeab847e&units=metric"
    }
}

struct HttpWorker {
    
    enum ErrorCode: Error {
        case urlNotProper
        case modelCannotBeMade
    }
    
    static let shared = HttpWorker()
    private init() {
        
    }
    
    func getData<T: Decodable>(from urlString: String, completion: @escaping (T?, Error?) -> Void ) throws {
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let validData = data {
                        do {
                            let model = try JSONDecoder().decode(T.self, from: validData)
                            completion(model, nil)
                        } catch {
                            completion(nil, ErrorCode.modelCannotBeMade)
                        }
                    }
                } else {
                    completion(nil, error!)
                }
                }.resume()
        } else {
            throw ErrorCode.urlNotProper
        }
    }
}

