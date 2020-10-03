//
//  TodayCell.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/3/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class TodayCell: UITableViewCell {
    
    static let reuseID = "TodayCell"
    
    var daily: Daily! {
        didSet {
            let data = Converter.convert(daily)
            weekDayLabel.text = data.weekDay
            todayLabel.text = "TODAY"
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
    
    private let todayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        separatorInset = UIEdgeInsets(top: 0.0, left: UIScreen.main.bounds.width, bottom: 0.0, right: 0.0)
        
        addSubview(weekDayLabel)
        addSubview(todayLabel)
        addSubview(tempMaxLabel)
        addSubview(tempMinLabel)
        
        weekDayLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        todayLabel.anchor(top: nil, left: weekDayLabel.rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        tempMinLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 40, height: 40)
        tempMaxLabel.anchor(top: topAnchor, left: nil, bottom: nil, right: tempMinLabel.leftAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 40, height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
