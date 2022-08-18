//
//  FindFlightsController.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import UIKit
import Combine
import SwiftUI
class FindFlightsController:UIViewController{
    private var cancellables: Set<AnyCancellable> = []
    
    private let scrollView:UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private let tripType:UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["One Way","Return"])
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor(light:.white, dark: .black)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    private let tripDetails:UIStackView = {
        let vStack = UIStackView(frame: .zero)
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private let fromLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "From"
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fromButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Where From?", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor(light: .black, dark: .white), for: .normal)
        button.tintColor = UIColor(light: .black, dark: .white)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let fromSeprator : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(light: .black, dark: .white)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let fromSpacing : UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let toSpacing : UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let toLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "To"
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Where To?", for: .normal)
        button.contentHorizontalAlignment = .leading
        button.setTitleColor(UIColor(light: .black, dark: .white), for: .normal)
        button.tintColor = UIColor(light: .black, dark: .white)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    private let toSeprator : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(light: .black, dark: .white)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let flyHStack:UIStackView = {
        let hStack = UIStackView(frame: .zero)
        hStack.axis = .horizontal
        hStack.distribution = .equalSpacing
        
        hStack.spacing = 0
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
    }()
    private let flyOutVstack:UIStackView = {
        let vStack = UIStackView(frame: .zero)
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private let flyOutLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Fly Out"
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let flyOutDate : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Select Date"
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let flyImageVstack:UIStackView = {
        let vStack = UIStackView(frame: .zero)
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    private let flyImage : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.image = UIImage(systemName: "calendar.circle")
        image.tintColor = UIColor(light: .blue, dark: .blue)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let flyBackVstack:UIStackView = {
        let vStack = UIStackView(frame: .zero)
        vStack.axis = .vertical
        vStack.spacing = 0
        vStack.translatesAutoresizingMaskIntoConstraints = false
        return vStack
    }()
    
    private let flyBackLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Fly Back"
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let flyBackDate : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Select Date"
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override func viewDidLayoutSubviews() {
        configureUI()
    }
    
    private func configureUI(){
        title = "FindFlights"
        view.backgroundColor = UIColor(light: .systemGroupedBackground, dark: .black)   /// For Dark and Light Mode support
        
        scrollView.addSubview(tripType)
        
        tripDetails.addArrangedSubview(fromLabel)
        tripDetails.addArrangedSubview(fromButton)
        tripDetails.addArrangedSubview(fromSeprator)
        tripDetails.addArrangedSubview(fromSpacing)
        tripDetails.addArrangedSubview(toLabel)
        tripDetails.addArrangedSubview(toButton)
        tripDetails.addArrangedSubview(toSeprator)
        tripDetails.addArrangedSubview(toSpacing)
        
        
        flyOutVstack.addArrangedSubview(flyOutLabel)
        flyOutVstack.addArrangedSubview(flyOutDate)
        
        flyImageVstack.addArrangedSubview(flyImage)
        
        
        flyBackVstack.addArrangedSubview(flyBackLabel)
        flyBackVstack.addArrangedSubview(flyBackDate)
        
        flyHStack.addArrangedSubview(flyOutVstack)
        flyHStack.addArrangedSubview(flyImageVstack)
        flyHStack.addArrangedSubview(flyBackVstack)
    
        tripDetails.addArrangedSubview(flyHStack)
        scrollView.addSubview(tripDetails)
        
        view.addSubview(scrollView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tripType.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tripType.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 20),
            tripType.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            tripType.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
            tripType.heightAnchor.constraint(equalToConstant: 40),
            
            tripDetails.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            tripDetails.topAnchor.constraint(equalTo: tripType.bottomAnchor,constant: 20),
            tripDetails.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20),
            tripDetails.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20),
            
            fromButton.heightAnchor.constraint(equalToConstant: 40),
            fromSeprator.heightAnchor.constraint(equalToConstant: 2),
            fromSpacing.heightAnchor.constraint(equalToConstant: 5),
            toButton.heightAnchor.constraint(equalToConstant: 40),
            toSeprator.heightAnchor.constraint(equalToConstant: 2),
            toSpacing.heightAnchor.constraint(equalToConstant: 20),
            
            flyImage.widthAnchor.constraint(equalToConstant: 40),
            flyImage.heightAnchor.constraint(equalToConstant: 40),
            
            
            
        ])
        
      
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromButton.addTarget(target, action: #selector(selectFrom), for: .touchUpInside)
        toButton.addTarget(target, action: #selector(selectTo), for: .touchUpInside)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.calenderPopView(_:)))
        flyHStack.addGestureRecognizer(tap)

        
        
    }
    @objc func calenderPopView(_ sender: UITapGestureRecognizer) {
       
    }

    @objc func selectFrom(){
        let service = Service()
        let viewModel = StationsViewModel(dataService: service)
        let vc = StationsController(viewModel:viewModel)
        vc.selectedStation.sink {[weak self] station in
            self?.fromButton.setTitle("\(station.name) (\(station.code))", for: .normal)
        }.store(in: &cancellables)
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func selectTo(){
        let service = Service()
        let viewModel = StationsViewModel(dataService: service)
        let vc = StationsController(viewModel:viewModel)
        vc.selectedStation.sink {[weak self] station in
            self?.toButton.setTitle("\(station.name) (\(station.code))", for: .normal)
        }.store(in: &cancellables)
        navigationController?.pushViewController(vc, animated: true)

    }

}
