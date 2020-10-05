//
//  DailyForecastCellModel.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/5/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct DailyForecastCellModel: TableViewCellModel {
    let weekDay: String
    let icon: String
    let temMin: String
    let tempMax: String
    
    func set(_ cell: DailyForecastCell) {
        cell.weekDay = weekDay
        cell.icon = icon
        cell.temMin = temMin
        cell.tempMax = tempMax
    }
}
