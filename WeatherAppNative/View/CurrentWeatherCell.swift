//
//  CurrentWeatherCell.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 10/2/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class CurrentWeatherCell: UITableViewCell {
    
    static let reuseID = "CurrentWeatherCell"
    
    var leftTopLabelName: String! {
        didSet {
            leftTopLabel.text = leftTopLabelName
        }
    }
    var leftBottomLabelName: String! {
        didSet {
            leftBottomLabel.text = leftBottomLabelName
        }
    }
    var rightTopLabelName: String! {
        didSet {
            rightTopLabel.text = rightTopLabelName
        }
    }
    var rightBottomLabelName: String! {
        didSet {
            rightBottomLabel.text = rightBottomLabelName
        }
    }
    
    private let leftTopLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let leftBottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let rightTopLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private let rightBottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        isUserInteractionEnabled = false
        
        addSubview(leftTopLabel)
        addSubview(leftBottomLabel)
        addSubview(rightTopLabel)
        addSubview(rightBottomLabel)
        leftTopLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 20, paddingBottom: 0, paddingRight: 0, width: frame.size.width/2, height: 0)
        leftBottomLabel.anchor(top: nil, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 20, paddingBottom: 5, paddingRight: 0, width: frame.size.width/2, height: 0)
        
        rightTopLabel.anchor(top: topAnchor, left: rightAnchor, bottom: nil, right: nil, paddingTop: 10, paddingLeft: -120, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        rightBottomLabel.anchor(top: nil, left: rightAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: -120, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
