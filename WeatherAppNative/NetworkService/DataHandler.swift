//
//  DataHandler.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/29/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation
import CoreLocation

struct DataHandler {
    
    static func getData(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Weather?, Error?) -> Void) {
        
        APIHandler.request(latitude: latitude, longitude: longitude) { (data, error) in
            guard let data = data else {return}
            
            switch error {
            case nil: 
                do {
                    let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                    DispatchQueue.main.async {
                        completion(weatherData, nil)
                    }
                } catch let jsonError {
                    print("Failed to decode JSON ", jsonError)
                }
            default:
                completion(nil, error)
            }
        }
    }
}
