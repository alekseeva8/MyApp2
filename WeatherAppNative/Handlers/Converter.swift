//
//  Converter.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct Converter {
    
    static func convert(_ viewModel: ViewModel) -> (city: String, description: String, temperature: String) {
        
        let timezone = viewModel.weather.timezone
        let timezoneSplitted = timezone.split(separator: "/")
        var city = String(timezoneSplitted.last ?? "")
        city = city.contains("_") ? city.replacingOccurrences(of: "_", with: " ") : city
        
        let description = viewModel.weather.current?.weather.first?.description ?? ""
        
        let tempDouble = viewModel.weather.current?.temp ?? 0.0
        let temperature = convert(tempDouble)
        
        return (city, description, temperature)
    }
    
    static func convert(_ hourly: Hourly) -> (hour: String, temperature: String, icon: String) {
        
        let unixTime = hourly.dt
        let hour = convert(unixTime: unixTime, with: "HH")
        
        let tempDouble = hourly.temp
        let temperature = convert(tempDouble)
        
        let icon = hourly.weather.first?.icon ?? ""
        
        return (hour, temperature, icon)
    }
    
    static func convert(_ daily: Daily) -> (weekDay: String, icon: String, tempMax: String, tempMin: String) {
        
        let unixTime = daily.dt
        let weekDay = getWeekDay(from: unixTime)
        
        let icon = daily.weather.first?.icon ?? ""
        
        let tempMaxDouble = daily.temp.max
        let tempMax = convert(tempMaxDouble)
        
        let temMinDouble = daily.temp.min
        let tempMin = convert(temMinDouble)
        
        return (weekDay, icon, tempMax, tempMin)
    }
    
    private static func convert(_ temperature: Double) -> String {
        let tempInt = Int(temperature.rounded())
        return String(tempInt)
    }
    
    private static func convert(unixTime: Int, with dateFormat: String!) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = .current
        return formatter.string(from: date)
    }
    
    private static func getWeekDay(from unixTime: Int) -> String {
        
        let date = Date(timeIntervalSince1970: TimeInterval(unixTime))
        let calendar = Calendar(identifier: .gregorian)
        switch calendar.component(.weekday, from: date) {
            case 1:
                return "Sunday"
            case 2:
                return "Monday"
            case 3:
                return "Tuesday"
            case 4:
                return "Wednesday"
            case 5:
                return "Thursday"
            case 6:
                return "Friday"
            case 7:
                return "Saturday"
            default:
                return ""
        }
    }
}
