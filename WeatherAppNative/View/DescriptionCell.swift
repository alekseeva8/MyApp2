//
//  DescriptionCell.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/2/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class DescriptionCell: UITableViewCell {
    
    static let reuseID = "DescriptionCell"
    
    var viewModel: ViewModel! {
        didSet {
            let data = Converter.convert(viewModel)
            guard let today = viewModel.weather.daily?.first else {return}
            let todayData = Converter.convert(today)
            descriptionLabel.text = "Today: \(data.description). The highest temperature is \(todayData.tempMax)°C. The lowest temperature is \(todayData.tempMin)°C."
        }
    }
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 3
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 5, paddingRight: 10, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
