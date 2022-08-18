//
//  CalendarViewModel.swift
//  Flight
//
//  Created by ARCHER on 19/08/2022.
//

import Foundation
class CalendarViewModel{
    @Published var isRange:Bool
    @Published var selectedDates = [Date]()
    init(selectedDates:[Date],isRange:Bool){
        self.selectedDates = selectedDates
        self.isRange = isRange
    }
    
    func shouldSelectDate()->Bool{
        if isRange {
        if selectedDates.isEmpty || selectedDates.count == 1 {
            return true
        }else{
            return false
        }
        }else{
            if selectedDates.isEmpty {
                return true
            }else{
                return false
            }
        }
    }
    

}
