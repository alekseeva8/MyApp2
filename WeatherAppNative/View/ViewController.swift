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
    
    private let headerViewHight = CGFloat(120)
    
    var viewModel: ViewModel! {
        didSet {
            let data = Converter.convert(viewModel)
            locationLabel.text = data.city
            descriptionLabel.text = data.description
        }
    }
    
    private var locationManagerDelegate: LocationManagerDelegate?
    private var locationManager = CLLocationManager()
    
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
        tableView.register(DailyForecastCell.self, forCellReuseIdentifier: DailyForecastCell.reuseID)
        tableView.register(DescriptionCell.self, forCellReuseIdentifier: DescriptionCell.reuseID)
        tableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: CurrentWeatherCell.reuseID)
        tableView.register(TemperatureCell.self, forCellReuseIdentifier: TemperatureCell.reuseID)
        tableView.register(TodayCell.self, forCellReuseIdentifier: TodayCell.reuseID)
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
    }
}

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
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: 
            return 2
        case 1:
            let dailyCount = viewModel.weather.daily?.count ?? 0
            let daysCount = dailyCount - 1
            return daysCount + 6
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cellModel = TemperatureCellModel(viewModel: viewModel)
                cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
            default:
                if let daily = viewModel.weather.daily?[indexPath.row] {
                    let cellModel = TodayCellModel(daily: daily)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
            }
        case 1:
            let dailyCount = viewModel.weather.daily?.count ?? 0
            let daysCount = dailyCount - 1
            let isDailyForecastRow = indexPath.row < daysCount
            
            switch  isDailyForecastRow {
            case true:
                if let daily = viewModel.weather.daily?[indexPath.row+1] {
                    let cellModel = DailyForecastCellModel(daily: daily)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
            default:
                let startIndex = daysCount
                let currentWeather = Converter.convert(viewModel)
                if indexPath.row == startIndex {
                    let cellModel = DescriptionCellModel(viewModel: viewModel)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
                if indexPath.row == startIndex + 1 {
                    let cellModel = CurrentWeatherCelllModel(leftTopLabelName: "SUNRISE", leftBottomLabelName: currentWeather.sunriseTime, rightTopLabelName: "SUNSET", rightBottomLabelName: currentWeather.sunsetTime)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
                if indexPath.row == startIndex + 2 {
                    let cellModel = CurrentWeatherCelllModel(leftTopLabelName: "CLOUDINESS", leftBottomLabelName: currentWeather.cloudiness, rightTopLabelName: "HUMIDITY", rightBottomLabelName: currentWeather.humidity + " %")
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
                if indexPath.row == startIndex + 3 {
                    let cellModel = CurrentWeatherCelllModel(leftTopLabelName: "WIND", leftBottomLabelName: currentWeather.windSpeed, rightTopLabelName: "FEELS LIKE", rightBottomLabelName: currentWeather.feelsLike)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
                if indexPath.row == startIndex + 4 {
                    let cellModel = CurrentWeatherCelllModel(leftTopLabelName: "PRECIPITATION", leftBottomLabelName: currentWeather.precipitation, rightTopLabelName: "PRESSURE", rightBottomLabelName: currentWeather.pressure)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
                if indexPath.row == startIndex + 5 {
                    let cellModel = CurrentWeatherCelllModel(leftTopLabelName: "VISIBILITY", leftBottomLabelName: currentWeather.visibility, rightTopLabelName: "UV INDEX", rightBottomLabelName: currentWeather.uvindex)
                    cell = tableView.dequeueReusableCell(with: cellModel, for: indexPath)
                }
            }
        default: cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseID, for: indexPath)
        }
        return cell
    }
}

//MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch  section {
        case 0:
            return 0
        case 1:
            return headerViewHight
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch  section {
        case 0:
            return nil
        case 1:
            return HourlyForecastView(viewModel: viewModel)
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                return 140
            case 1:
                return 40
            default:
                return 0
            }
        case 1: 
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
        default:
            return 0
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
