//
//  ViewController.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/28/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private let backgroundView: UIImageView = {
        let image = UIImage(named: "Splash")
        let bgView = UIImageView(image: image)
        bgView.isUserInteractionEnabled = true
        return bgView
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = ""
        return label
    }()
    
    private let tableView: UITableView = {
        let frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        let tableView = UITableView(frame: frame)
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.separatorColor = .lightText
        return tableView
    }()
    
    var viewModel: ViewModel! {
        didSet {
            let data = Converter.convert(viewModel)
            locationLabel.text = data.city
            descriptionLabel.text = data.description
        }
    }
    
    private var locationManagerDelegate: LocationManagerDelegate?
    private var locationManager = CLLocationManager()
    
    private let headerViewHight = CGFloat(120)
    
    private enum SectionCategory {
    case firstSection 
    case secondSection
    }
    
    private let sections: [SectionCategory] = [.firstSection, .secondSection]
    
    override func loadView() {
        super.loadView()
        view = backgroundView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let weatherData = Weather(lat: 0.0, lon: 0.0, timezone: " ", current: nil, hourly: nil, daily: nil)
        viewModel = ViewModel(weather: weatherData)
        viewModel.viewModelDelegate = self
        
        viewModel.getWeatherFromCache()
        
        configureLocationManager()
        APIHandler.viewController = self
    }
    
    private func configureLocationManager() {
        locationManagerDelegate = LocationManagerDelegate()
        locationManager.delegate = locationManagerDelegate
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManagerDelegate?.locationDelegate = self.viewModel
    }
    
    private func configure() {
        
        view.addSubview(locationLabel)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25).isActive = true
        locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 3).isActive = true
        descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TemperatureCell.self, forCellReuseIdentifier: TemperatureCell.reuseID)
        tableView.register(TodayCell.self, forCellReuseIdentifier: TodayCell.reuseID)
        tableView.register(DailyForecastCell.self, forCellReuseIdentifier: DailyForecastCell.reuseID)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.reuseID)
        tableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: CurrentWeatherCell.reuseID)
    }
}

//MARK: - ViewModelDelegate
extension ViewController: ViewModelDelegate {
    func useData(_ data: Weather) {
        viewModel = ViewModel(weather: data)
        configure()
        configureTableView()
        tableView.reloadData()
    }
    
    func updateData(_ data: Weather) {
        viewModel = ViewModel(weather: data)
        configure()
        configureTableView()
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch sections[section] {
        case .firstSection: 
            return 2
        case .secondSection:
            let dailyCount = viewModel.weather.daily?.count ?? 0
            let daysCount = dailyCount - 1
            return daysCount + 6
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        let currentWeather = Converter.convert(viewModel)
        
        switch sections[indexPath.section] {
        case .firstSection:
            switch indexPath.row {
            case 0:
                let cellModel = TemperatureCellModel(temperature: currentWeather.temperature)
                cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
            default:
                if let daily = viewModel.weather.daily?[indexPath.row] {
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
                    cell.separatorInset = UIEdgeInsets(top: 0, left: self.tableView.bounds.width, bottom: 0, right: 0)
                }
            }
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
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
            let dailyCount = viewModel.weather.daily?.count ?? 0
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
}

//MARK: - Scrolling
extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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
