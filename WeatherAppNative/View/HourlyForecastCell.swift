//
//  HourlyForecastCell.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/30/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class HourlyForecastCell: UICollectionViewCell {
    
    static let reuseID = "HourlyForecastCell"
    
    let hourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    let imageView = UIImageView()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    var weatherCode: String?
    var hour: String?
    var temperature: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        addSubview(hourLabel)
        addSubview(imageView)
        addSubview(temperatureLabel)
        
        hourLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        
        hourLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        hourLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temperatureLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        hourLabel.text = hour
        if let weatherCode = weatherCode, weatherCode != "" {
            imageView.image = UIImage(named: weatherCode)
        }
        temperatureLabel.text = temperature
    }
}
