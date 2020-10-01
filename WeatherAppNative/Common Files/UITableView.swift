//
//  UITableView.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/1/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

protocol TableViewCellModel {
    associatedtype CellType: UIView
    func configure(_ cell: CellType)
}

extension UITableView {
    
    func dequeueReusableCell<T: TableViewCellModel>(with model: T, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: T.CellType.self)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = cell as? T.CellType {
            model.configure(cell)
        }
        return cell
    }
}

struct DailyForecastCellModel: TableViewCellModel {
    
    let daily: Daily
    func configure(_ cell: DailyForecastCell) {
        cell.daily = daily
    }
    
}


