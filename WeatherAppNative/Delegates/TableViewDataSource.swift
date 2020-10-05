//
//  TableViewDataSource.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/5/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var viewModel: ViewModel? 
    var tableView: UITableView?
    
    private let sections: [SectionCategory] = [.firstSection, .secondSection]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .firstSection: 
            return 2
        case .secondSection:
            let dailyCount = viewModel?.weather.daily?.count ?? 0
            let daysCount = dailyCount - 1
            return daysCount + 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let viewModel = viewModel else {return UITableViewCell()}
        let currentWeather = Converter.convert(viewModel)
        
        switch sections[indexPath.section] {
        case .firstSection:
            switch indexPath.row {
            case 0:
                let cellModel = TemperatureCellModel(temperature: currentWeather.temperature)
                cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
            default:
                if let daily = viewModel.weather.daily?.first {
                    let data = Converter.convert(daily)
                    let cellModel = TodayCellModel(weekDay: data.weekDay, temMin: data.tempMin, tempMax: data.tempMax)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
            }
        case .secondSection:
            let dailyCount = viewModel.weather.daily?.count ?? 0
            let daysCount = dailyCount - 1
            let isDailyForecastRow = indexPath.row < daysCount
            
            switch  isDailyForecastRow {
            case true:
                if let daily = viewModel.weather.daily?[indexPath.row+1] {
                    let data = Converter.convert(daily)
                    let cellModel = DailyForecastCellModel(weekDay: data.weekDay, icon: data.icon, temMin: data.tempMin, tempMax: data.tempMax)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                    if indexPath.row == daysCount-1 {
                        cell.separatorInset = UIEdgeInsets.zero
                    }
                }
            default:
                let startIndex = daysCount
                if indexPath.row == startIndex {
                    if let today = viewModel.weather.daily?.first {
                        let todayData = Converter.convert(today)
                        let text = "Today: \(currentWeather.description). The highest temperature is \(todayData.tempMax)°C. The lowest temperature is \(todayData.tempMin)°C."
                        let cellModel = DescriptionCellModel(descriptionText: text)
                        cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                    }
                }
                if indexPath.row == startIndex + 1 {
                    let cellModel = CurrentWeatherCellModel(leftTopLabelName: "SUNRISE", leftBottomLabelName: currentWeather.sunriseTime, rightTopLabelName: "SUNSET", rightBottomLabelName: currentWeather.sunsetTime)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
                if indexPath.row == startIndex + 2 {
                    let cellModel = CurrentWeatherCellModel(leftTopLabelName: "CLOUDINESS", leftBottomLabelName: currentWeather.cloudiness, rightTopLabelName: "HUMIDITY", rightBottomLabelName: currentWeather.humidity + " %")
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
                if indexPath.row == startIndex + 3 {
                    let cellModel = CurrentWeatherCellModel(leftTopLabelName: "WIND", leftBottomLabelName: currentWeather.windSpeed, rightTopLabelName: "FEELS LIKE", rightBottomLabelName: currentWeather.feelsLike)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
                if indexPath.row == startIndex + 4 {
                    let cellModel = CurrentWeatherCellModel(leftTopLabelName: "PRECIPITATION", leftBottomLabelName: currentWeather.precipitation, rightTopLabelName: "PRESSURE", rightBottomLabelName: currentWeather.pressure)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
                if indexPath.row == startIndex + 5 {
                    let cellModel = CurrentWeatherCellModel(leftTopLabelName: "VISIBILITY", leftBottomLabelName: currentWeather.visibility, rightTopLabelName: "UV INDEX", rightBottomLabelName: currentWeather.uvindex)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                    cell.separatorInset = UIEdgeInsets(top: 0, left: tableView.bounds.width, bottom: 0, right: 0)
                }
            }
        }
        return cell
    }
}
