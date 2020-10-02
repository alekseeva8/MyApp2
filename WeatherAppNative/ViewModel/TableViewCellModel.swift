//
//  TableViewCellModel.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/2/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

protocol TableViewCellModel {
    associatedtype CellType: UIView
    func set(_ cell: CellType)
}

struct DailyForecastCellModel: TableViewCellModel {
    
    let daily: Daily
    func set(_ cell: DailyForecastCell) {
        cell.daily = daily
    }
}

struct DescriptionCellModel: TableViewCellModel {
    
    var viewModel: ViewModel
    func set(_ cell: DescriptionCell) {
        cell.viewModel = viewModel
    }
}

struct CurrentWeatherCelllModel: TableViewCellModel {
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
