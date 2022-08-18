//
//  PassengerViewModel.swift
//  Flight
//
//  Created by ARCHER on 18/08/2022.
//

import Foundation

class PassengerViewModel{
    
    @Published var passengers = [Passenger]()
    
    init(passengers:[Passenger]) {
        self.passengers = passengers
    }
    
    func numberOfPassengers()->Int {
        return passengers.count
    }
    func passengerAt(indexPath:IndexPath)->Passenger{
        return passengers[indexPath.row]
    }
    func selectPassengerAt(indexPath:IndexPath,count:Int){
        passengers[indexPath.row].selected =  Double(count)
    }
    
    
}
