//
//  TableViewDelegate.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/5/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class TableViewDelegate: NSObject, UITableViewDelegate {
    
    var viewModel: ViewModel?
    var tableView: UITableView?
    
    private let sections: [SectionCategory] = [.firstSection, .secondSection]
    private let headerViewHight = CGFloat(120)
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .firstSection:
            return 0
        case .secondSection:
            return headerViewHight
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch sections[section] {
        case .firstSection:
            return nil
        case .secondSection:
            guard let viewModel = viewModel else {return nil}
            return HourlyForecastView(viewModel: viewModel)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.section] {
        case .firstSection:
            switch indexPath.row {
            case 0:
                return 140
            default:
                return 40
            }
        case .secondSection: 
            let dailyCount = viewModel?.weather.daily?.count ?? 0
            let daysCount = dailyCount - 1
            switch indexPath.row {
            case daysCount:
                return 70
            case daysCount + 1, daysCount + 2, daysCount + 3, daysCount + 4, daysCount + 5:
                return 65
            default:
                return 40
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let tableView = tableView else {return}
        
        if scrollView.contentOffset.y >= 0.0 {
            let offset = abs(pow(scrollView.contentOffset.y, 1.1))
            if let temperatureCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) {
                changeTransparency(of: temperatureCell, offset: offset) 
            }
            if let todayCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) {
                changeTransparency(of: todayCell, offset: offset)
            } 
        }
        
        for cell in tableView.visibleCells {
            let paddingToDisapear = headerViewHight
            let hiddenFrameHeight = scrollView.contentOffset.y + paddingToDisapear - cell.frame.origin.y
            if (hiddenFrameHeight >= 0 || hiddenFrameHeight <= cell.frame.size.height) {
                let temperatureCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
                if cell != temperatureCell {
                    mask(cell: cell, fromTop: hiddenFrameHeight)
                }
            }
        }
    }
    
    // MARK: - make cells invisible under the headerView
    func mask(cell: UITableViewCell, fromTop margin: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = cell.bounds
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.withAlphaComponent(1).cgColor]
        let marginNumb = margin as NSNumber
        gradientLayer.locations = [marginNumb, marginNumb]
        cell.layer.mask = gradientLayer
        cell.layer.masksToBounds = true
    }
    
    // MARK: - changing cell's transperancy
    func changeTransparency(of cell: UITableViewCell, offset: CGFloat) { 
        if offset <= 100 {
            cell.alpha = 1.0 - (offset / 100)
        } else {
            cell.alpha = 0.0
        }
    }
}
