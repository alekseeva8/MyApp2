//
//  DailyForecastCell.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/1/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class DailyForecastCell: UITableViewCell {
    
    static let reuseID = "DailyForecastCell"
    
    var daily: Daily! {
        didSet {
            let data = Converter.convert(daily)
            weekDayLabel.text = data.weekDay
            weatherImageView.image = UIImage(named: data.icon)
            tempMaxLabel.text = data.tempMax
            tempMinLabel.text = data.tempMin
        }
    }
    
    private let weekDayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let tempMaxLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let tempMinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = .lightText
        label.textAlignment = .left
        return label
    }()
    
    private let weatherImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        separatorInset = UIEdgeInsets(top: 0.0, left: UIScreen.main.bounds.width, bottom: 0.0, right: 0.0)
        
        addSubview(weekDayLabel)
        addSubview(weatherImageView)
        addSubview(tempMaxLabel)
        addSubview(tempMinLabel)
        
        weekDayLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: frame.size.width / 2, height: 0)
        weatherImageView.anchor(top: topAnchor, left: weekDayLabel.rightAnchor, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        tempMinLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 40, height: 40)
        tempMaxLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: tempMinLabel.leftAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 40, height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
