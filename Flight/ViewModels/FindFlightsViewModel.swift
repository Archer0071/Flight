//
//  FindFlightsViewModel.swift
//  Flight
//
//  Created by ARCHER on 18/08/2022.
//

import Foundation
import SwiftUI

class FindFlightsViewModel {
    var passengers : [Passenger] = [Passenger(type: "Adults",   des: "16+ years",  min: 1.0, max: 6.0,selected: 1.0),
                                    Passenger(type: "Teens",    des: "12-15 years",min: 0.0, max: 6.0,selected: 0.0),
                                    Passenger(type: "Childrens", des: "2-11 years", min: 0.0, max: 6.0,selected: 0.0),
                                    Passenger(type: "Infants",  des: "Under 2",    min: 0.0, max: 6.0,selected: 0.0)]
                
    var passengersString : [String] = []
    
    var selectedDates:[Date] = []

    func getPassengers(passengers:[Passenger]) -> String {
        self.passengersString.removeAll()
        self.passengers = passengers
        let selected = passengers.filter { $0.selected > 0.0 }.map({$0.selected})
        let type = passengers.filter { $0.selected > 0.0 }.map({$0.type})
        let des = passengers.filter { $0.selected > 0.0 }.map({$0.des})
        let merge = Array(zip(selected,type))
        let merge2 = Array(zip(merge,des))
        
            for ((selected,type),des) in merge2 {
                passengersString.append("\(Int(selected)) \(type)(\(des))")
            }
        return passengersString.joined(separator: ",")
        }
}
