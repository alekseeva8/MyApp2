//
//  TemperatureCellModel.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/5/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct TemperatureCellModel: TableViewCellModel {
    let temperature: String
    func set(_ cell: TemperatureCell) {
        cell.temperature = temperature
    }
}
