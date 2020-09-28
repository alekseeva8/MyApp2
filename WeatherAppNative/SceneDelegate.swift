//
//  SceneDelegate.swift
//  WeatherAppNative
//
//  Created by Elena Alekseeva on 9/28/20.
//  Copyright © 2020 Elena Alekseeva. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = ViewController()
        window?.makeKeyAndVisible()
    }
}

