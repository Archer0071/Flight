//
//  FindFlightsController.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import UIKit
import Combine
class FindFlights:UIViewController{
        
    
   
    
    override func viewDidLayoutSubviews() {
        configureUI()
    }
    
    private func configureUI(){
        title = "STATIONS"
        view.backgroundColor = UIColor(light: .systemGroupedBackground, dark: .black)   /// For Dark and Light Mode support
        
        
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
