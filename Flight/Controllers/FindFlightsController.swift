//
//  FindFlightsController.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import UIKit
import Combine
class FindFlightsController:UIViewController{
        
    
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let tripSelection:UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["One Way","Return"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor(light:.white, dark: .black)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let destinationStack:UIStackView = {
        let vStack = UIStackView(frame: .zero)
        vStack.axis = .vertical
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private let fromLabel : UILabel = {
        let label = UILabel()
        label.text = "From"
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fromButton : UIButton = {
        let button = UIButton()
        button.setTitle("From Where?", for: .normal)
        button.tintColor = UIColor(light: .black, dark: .white)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLayoutSubviews() {
        configureUI()
    }
    
    private func configureUI(){
        title = "FindFlights"
        view.backgroundColor = UIColor(light: .systemGroupedBackground, dark: .black)   /// For Dark and Light Mode support
        
        scrollView.addSubview(tripSelection)
        
        destinationStack.addArrangedSubview(fromLabel)
        destinationStack.addArrangedSubview(fromButton)
        scrollView.addSubview(destinationStack)
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tripSelection.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tripSelection.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 20),
            tripSelection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            tripSelection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
            tripSelection.heightAnchor.constraint(equalToConstant: 40),
            
            destinationStack.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            destinationStack.topAnchor.constraint(equalTo: tripSelection.bottomAnchor,constant: 20),
            destinationStack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            destinationStack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
            
            fromButton.heightAnchor.constraint(equalToConstant: 40),
            
            
        ])
        
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
