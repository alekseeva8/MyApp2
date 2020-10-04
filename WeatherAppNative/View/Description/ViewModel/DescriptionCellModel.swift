//
//  DescriptionCellModel.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/5/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import Foundation

struct DescriptionCellModel: TableViewCellModel {
    let descriptionText: String
    func set(_ cell: DescriptionCell) {
        cell.descriptionText = descriptionText
    }
}
