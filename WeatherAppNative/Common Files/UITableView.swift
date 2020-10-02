//
//  UITableView.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/1/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

extension UITableView {
    
    func dequeueReusableCell<T: TableViewCellModel>(with model: T, for indexPath: IndexPath) -> UITableViewCell {
        let identifier = String(describing: T.CellType.self)
        let cell = self.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        if let cell = cell as? T.CellType {
            model.set(cell)
        }
        return cell
    }
}


