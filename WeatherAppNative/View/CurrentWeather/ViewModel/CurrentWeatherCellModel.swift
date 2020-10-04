//
//  CurrentWeatherCellModel.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/5/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct CurrentWeatherCellModel: TableViewCellModel {
    let leftTopLabelName: String
    let leftBottomLabelName: String
    let rightTopLabelName: String
    let rightBottomLabelName: String
    
    func set(_ cell: CurrentWeatherCell) {
        cell.leftTopLabelName = leftTopLabelName
        cell.leftBottomLabelName = leftBottomLabelName
        cell.rightTopLabelName = rightTopLabelName
        cell.rightBottomLabelName = rightBottomLabelName
    }
}
