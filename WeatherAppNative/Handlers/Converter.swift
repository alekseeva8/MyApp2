//
//  Converter.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct Converter {
    
    static func convert(_ viewModel: ViewModel) -> (city: String, description: String, temperature: String, sunriseTime: String, sunsetTime: String, humidity: String, precipitation: String, windSpeed: String, feelsLike: String, pressure: String, visibility: String, uvindex: String, cloudiness: String) {
        
        let timezone = viewModel.weather.timezone
        let timezoneSplitted = timezone.split(separator: "/")
        var city = String(timezoneSplitted.last ?? "")
        city = city.contains("_") ? city.replacingOccurrences(of: "_", with: " ") : city
        
        let description = viewModel.weather.current?.weather.first?.main ?? ""
        
        let tempDouble = viewModel.weather.current?.temp ?? 0.0
        let temperature = convert(tempDouble) + "°"
        
        var sunriseTime = ""
        if let sunriseUnixTime = viewModel.weather.current?.sunrise {
            sunriseTime = convert(unixTime: sunriseUnixTime, with: "HH:mm")
        }
        var sunsetTime = ""
        if let sunsetUnixTime = viewModel.weather.current?.sunset {
            sunsetTime = convert(unixTime: sunsetUnixTime, with: "HH:mm")
        }
        
        let humidityInt = viewModel.weather.current?.humidity
        let humidity = humidityInt?.description ?? "--"
        
        var precipitation = "0 mm"
        if let precipitationDouble = viewModel.weather.current?.rain?.forLastHour {
            precipitation = convert(precipitationDouble) + " mm"
        }
        
        var windSpeed = "-- km/h"
        if let windSpeedDouble = viewModel.weather.current?.windSpeed {
            let windSpeedDoubleKmh = windSpeedDouble * 3.6
            windSpeed = convert(windSpeedDoubleKmh) + " km/h"
        }
        
        var feelsLike = "--°"
        if let feelsLikeDouble = viewModel.weather.current?.feelsLike {
            feelsLike = convert(feelsLikeDouble) + "°"
        }
        
        var pressure = "-- hPa"
        if let pressureInt = viewModel.weather.current?.pressure {
            pressure = String(pressureInt) + " hPa"
        }
        
        var visibility = "-- km"
        if let visibilityInt = viewModel.weather.current?.visibility {
            var visabilityDecimal = (visibilityInt % 1000)/100
            if (visibilityInt % 100) >= 50 {
                visabilityDecimal += 1
            }
            switch visabilityDecimal {
            case 0:
                visibility = String(visibilityInt/1000) + " km"
            default:
                visibility = String(visibilityInt/1000) + "," + String(visabilityDecimal) + " km"
            }
        }
        
        var uvindex = "--"
        if let uvindexDouble = viewModel.weather.current?.uvi {
            uvindex = String(uvindexDouble)
        }
        
        var cloudiness = "-- %"
        if let cloudsInt = viewModel.weather.current?.clouds {
            cloudiness = String(cloudsInt) + " %"
        }
        
        return (city, description, temperature, sunriseTime, sunsetTime, humidity, precipitation, windSpeed, feelsLike, pressure, visibility, uvindex, cloudiness)
    }
    
    
    static func convert(_ hourly: Hourly) -> (hour: String, temperature: String, icon: String) {
        
        let unixTime = hourly.dt
        let hour = convert(unixTime: unixTime, with: "HH")
        
        let tempDouble = hourly.temp
        let temperature = convert(tempDouble) + "°"
        
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
    
    private static func convert(_ value: Double) -> String {
        let valueInt = Int(value.rounded())
        return String(valueInt)
    }
    
    private static func convert(unixTime: Int, with dateFormat: String) -> String {
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
