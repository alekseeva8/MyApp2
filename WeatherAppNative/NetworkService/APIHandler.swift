//
//  APIHandler.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/29/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import CoreLocation

struct APIHandler {
    
    static weak var viewController: UIViewController?
    static private var alertHasShown = false
    
    static func request (latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Data?, Error?) -> Void) {
        
        let optURL = URLBuilder()
            .set(scheme: Constants.scheme)
            .set(host: Constants.host)
            .set(path: Constants.path + "onecall")
            .addQueryItem(name: "lat", value: "\(latitude)")
            .addQueryItem(name: "lon", value: "\(longitude)")
            .addQueryItem(name: "units", value: Constants.metriFormat)
            .addQueryItem(name: "appid", value: Constants.apiKey)
            .build()
        
        guard let url = optURL else {return}
        print(url)
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            switch error {
            case nil:
                completion(data, error)
            default:
                if alertHasShown == false {
                    guard let viewController = viewController else {return}
                    DispatchQueue.main.async {
                        Alert.noInternetConnection(viewController)
                        alertHasShown = true
                    }
                }
            }
        } .resume()
    }
}
