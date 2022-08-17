//
//  StationsController.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import UIKit
import Combine
class StationsController:UIViewController{
    
    var viewModel : StationsViewModel
    init(viewModel:StationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let indicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        activityIndicator.backgroundColor = .clear
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "STATIONS"
        view.backgroundColor = UIColor(light: .white, dark: .black)
    }
}
