//
//  Converter.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct Converter {
    
    static func convertCurrentWeather(_ viewModel: ViewModel) -> (city: String, description: String, temperature: String) {
        
        let timezone = viewModel.weather.timezone
        let timezoneSplitted = timezone.split(separator: "/")
        var city = String(timezoneSplitted.last ?? "")
        city = city.contains("_") ? city.replacingOccurrences(of: "_", with: " ") : city
        
        let description = viewModel.weather.current?.weather.first?.description ?? ""
        
        let tempDouble = viewModel.weather.current?.temp ?? 0.0
        let tempInt = Int(tempDouble.rounded())
        let temperature = String(tempInt)
        
        return (city, description, temperature)
    }
    
    static func convertHourForecast(_ hourly: Hourly) -> (hour: String, temperature: String, icon: String) {
        
        let unixTime = hourly.dt
        let hour = convert(unixTime: unixTime, with: "HH")
        
        let tempDouble = hourly.temp
        let tempInt = Int(tempDouble.rounded())
        let temperature = String(tempInt)
        
        let icon = hourly.weather.first?.icon ?? ""
        
        return (hour, temperature, icon)
    }
    
    private static func convert(unixTime: Int, with dateFormat: String!) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = .current
        return formatter.string(from: date)
    }
}
