//
//  ViewController.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/28/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    private let backgroundView: UIImageView = {
        let image = UIImage(named: "Splash")
        let bgView = UIImageView(image: image)
        return bgView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configure()
    
    }
    
    private func configure() {
        view.addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

