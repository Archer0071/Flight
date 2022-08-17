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
    
    @Published  var stations = [Station]()
    @Published  var oldData = [Station]()
    @Published  var listLoadingError: String = ""
    @Published  var searchText:String = ""
    @Published  var searchCancel:Bool = false
    @Published  var showAlert: Bool = false
    
    private var cancellables: Set<AnyCancellable> = []
    let dataService : ServiceProtocol
    
    init(dataService:ServiceProtocol) {
        self.dataService = dataService
        getList()
        getSearchText()
        getSearchCancel()
        
        
    }
    
    func getList() {
        dataService.fetchStations()
            .sink { (dataResponse) in
                if dataResponse.error != nil {
                    self.createAlert(with: dataResponse.error!)
                } else {
                    if let data = dataResponse.value {
                        self.stations = data.stations
                        self.oldData = data.stations
                    }
                    
                }
            }.store(in: &cancellables)
        
    }
    func getSearchText(){
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main) // debounces the string publisher, such that it delays the process of sending request to remote server.
            .removeDuplicates()
            .map({ (string) -> String? in
                if string.count < 1 {
                    self.stations = self.oldData
                    return nil
                }
                
                return string
            })// prevents sending numerous requests and sends nil if the count of the characters is less than 1.
            .compactMap{ $0 } // removes the nil values so the search string does not get passed down to the publisher chain
            .sink { (_) in
                //
            } receiveValue: { [self] _ in
                
                self.searchList(searchText: searchText)
                
            }.store(in: &cancellables)
    }
    func getSearchCancel(){
        $searchCancel.sink { canceled in
            if canceled {
                self.stations = self.oldData
            }else{
                
            }
        }.store(in: &cancellables)
    }
    
    
    func searchList(searchText:String){
        
        self.stations = oldData.filter {$0.name.contains(searchText) || $0.code.contains(searchText)}
        
    }
    
    
    func createAlert( with error: NetworkError ) {
        listLoadingError = error.backendError == nil ? error.initialError.localizedDescription : error.backendError!.message
        self.showAlert = true
        
    }
    
    func numberOfStations() -> Int {
        
        return stations.count
    }
    
    func stationAt(indexPath: IndexPath) -> Station {
        return stations[indexPath.row]
    }
}

