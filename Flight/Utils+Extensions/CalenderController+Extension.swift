//
//  CalenderController+Extension.swift
//  Flight
//
//  Created by ARCHER on 19/08/2022.
//

import Foundation
import UIKit
import FSCalendar
extension CalendarController:FSCalendarDelegate{

    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
        cell.titleLabel.textColor = UIColor(light: .black, dark: .white)
        
    }
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        return viewModel.shouldSelectDate()
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.selectedDates = calendar.selectedDates
        selectedDates.send(calendar.selectedDates)
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        viewModel.selectedDates = calendar.selectedDates
        selectedDates.send(calendar.selectedDates)
    }
}
