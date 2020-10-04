//
//  TemperatureCell.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/3/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class TemperatureCell: UITableViewCell {
    
    static let reuseID = "TemperatureCell"
    
    var temperature: String?
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 70, weight: .thin)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        separatorInset = UIEdgeInsets(top: 0.0, left: UIScreen.main.bounds.width, bottom: 0.0, right: 0.0)
        
        addSubview(temperatureLabel)
        temperatureLabel.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        temperatureLabel.text = temperature
    }
}
