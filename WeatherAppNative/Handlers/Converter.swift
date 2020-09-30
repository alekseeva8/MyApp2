//
//  Converter.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct Converter {
    
    static func convert(_ viewModel: ViewModel) -> (city: String, description: String, temperature: Int) {
        
        let timezone = viewModel.weather.timezone
        let timezoneSplitted = timezone.split(separator: "/")
        var city = String(timezoneSplitted.last ?? "")
        city = city.contains("_") ? city.replacingOccurrences(of: "_", with: " ") : city
        
        let description = viewModel.weather.current?.weather.first?.description ?? ""
        
        let tempDouble = viewModel.weather.current?.temp ?? 0.0
        let temperature = Int(tempDouble.rounded())
        
        return (city, description, temperature)
    }
}
