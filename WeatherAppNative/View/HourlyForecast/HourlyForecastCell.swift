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
    
    var icon: String?
    var hour: String?
    var temperature: String?
    
    let hourLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let imageView = UIImageView()
    
    let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
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
        if let icon = icon, icon != "" {
            imageView.image = UIImage(named: icon)
        }
        temperatureLabel.text = temperature
    }
}
