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
    
    var descriptionText: String?
    
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
        separatorInset = UIEdgeInsets.zero
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: topAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        descriptionLabel.text = descriptionText
    }
}
