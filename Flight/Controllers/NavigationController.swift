//
//  NavigationController.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import UIKit

// The root view controller for our app
class NavigationController: UINavigationController {
    
    // The root view controller for our app
    init() {
       
        super.init(rootViewController: DependencyProvider.stationsController)
    }
    
    // Helper init
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

