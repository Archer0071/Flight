//
//  SceneDelegate.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = scene as? UIWindowScene else { return }
        self.window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        self.window?.windowScene = windowScene
        self.window?.rootViewController = UINavigationController(rootViewController: FindFlightsController())
        self.window?.makeKeyAndVisible()
        
    }

}

