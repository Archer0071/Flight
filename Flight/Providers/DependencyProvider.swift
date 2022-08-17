//
//  DependencyProvider.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import UIKit

struct DependencyProvider {
    static var serviceProtocol:ServiceProtocol {
        return Service()
    }
    static var stationsViewModel:StationsViewModel {
        return StationsViewModel(dataService: self.serviceProtocol)
    }
    static var stationsController:StationsController {
       return StationsController(viewModel: self.stationsViewModel)
    }
}
