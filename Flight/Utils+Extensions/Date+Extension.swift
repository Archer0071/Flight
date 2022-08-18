//
//  UIDate+Extension.swift
//  Flight
//
//  Created by ARCHER on 18/08/2022.
//

import Foundation

extension Date {
    func convertToString()->String{
        let dateFormatter = DateFormatter()
         dateFormatter.locale = Locale(identifier: "en_US_POSIX")
         dateFormatter.dateFormat = "dd MMM YYYY"
         return dateFormatter.string(from: self)
    }
}
