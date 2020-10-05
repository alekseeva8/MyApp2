//
//  TableViewCellModel.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/2/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

protocol TableViewCellModel {
    associatedtype CellType: UITableViewCell
    func set(_ cell: CellType)
}
