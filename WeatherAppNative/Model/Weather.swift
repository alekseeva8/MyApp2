//
//  Weather.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/29/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let lat, lon: Double?
    let timezone: String
    let current: Current?
    let hourly: [Hourly]?
    let daily: [Daily]?
}

struct Current: Codable {
    let dt, sunrise, sunset, pressure, humidity, windDeg: Int
    let temp, feelsLike, dewPoint, uvi, windSpeed: Double
    let clouds, visibility: Int?
    let weather: [WeatherAPI]
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, sunrise, sunset, temp, pressure, humidity, uvi, clouds, visibility, weather, rain
        case feelsLike = "feels_like"
        case dewPoint = "dew_point"
        case windSpeed = "wind_speed"
        case windDeg = "wind_deg"
    }
}

struct Hourly: Codable {
    let dt: Int
    let temp: Double
    let weather: [WeatherAPI]
}

struct Daily: Codable {
    let dt: Int
    let temp: Temp
    let weather: [WeatherAPI]
}

struct WeatherAPI: Codable {
    let id: Int?
    let main: String
    let description: String
    let icon: String
}

struct Rain: Codable {
    let forLastHour: Double?
    
    enum CodingKeys: String, CodingKey {
        case forLastHour = "1h"
    }
}

struct Temp: Codable {
    let min, max: Double
}

