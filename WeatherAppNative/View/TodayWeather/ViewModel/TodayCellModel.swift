//
//  TodayCellModel.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/5/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct TodayCellModel: TableViewCellModel {
    let weekDay: String
    let temMin: String
    let tempMax: String
    
    func set(_ cell: TodayCell) {
        cell.weekDay = weekDay
        cell.temMin = temMin
        cell.tempMax = tempMax
    }
}
