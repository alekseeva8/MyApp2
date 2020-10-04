//
//  LocationManagerDelegate.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/29/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import CoreLocation

protocol LocationDelegate: class {
    func getWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

class LocationManagerDelegate: NSObject, CLLocationManagerDelegate {
    
    private let locationManager = CLLocationManager()
    weak var locationDelegate: LocationDelegate?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        locationManager.stopUpdatingLocation()
        guard let location = locations.last else { return } 
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        locationDelegate?.getWeather(latitude: latitude, longitude: longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied, .restricted:
            guard let delegate = locationDelegate as? UIViewController else {return}
            Alert.locationServiceIsDisabled(delegate)
        case .authorizedAlways, .authorizedWhenInUse:
            break
        @unknown default:
            break
        }
    }    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to get location", error)
    }
}
