//
//  StationsViewModel.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import Combine
import UIKit

class StationsViewModel: ObservableObject {
    
    @Published  var stations: Stations!
    @Published  var listLoadingError: String = ""
    @Published  var showAlert: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    let dataService : ServiceProtocol
    
    init(dataService:ServiceProtocol) {
        self.dataService = dataService
        getLaunchesList()
        
    }
    
    func getLaunchesList() {
        dataService.fetchStations()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    if let data = dataResponse.value {
                        self.stations = data
                    }
                    
                }
            }.store(in: &cancellables)
    }
    
    func createAlert( with error: NetworkError ) {
        listLoadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
        
    }
    
    func numberOfPosts() -> Int {
        
       return stations.stations.count
     }
     
    func postAt(indexPath: IndexPath) -> Station {
        return stations.stations[indexPath.row]
     }
}

