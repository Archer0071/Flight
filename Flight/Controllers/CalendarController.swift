//
//  calendarController.swift
//  Flight
//
//  Created by ARCHER on 18/08/2022.
//

import Foundation
import UIKit
import FSCalendar
import Combine
import CoreData

class CalendarController:UIViewController{
    private var cancellables: Set<AnyCancellable> = []
    var selectedDates = PassthroughSubject<[Date],Never>()
    var viewModel : CalendarViewModel
    init(viewModel:CalendarViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private let calendar : FSCalendar = {
        let calendar = FSCalendar(frame: .zero)
        calendar.allowsMultipleSelection = true
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    private let confirmButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(UIColor(light: .black, dark: .white), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()

    private let selectedLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Select Your Range"
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let selectedStack : UIStackView = {
        let hStack = UIStackView(frame: .zero)
        hStack.axis = .horizontal
        hStack.distribution = .fillEqually
        hStack.spacing = 5
        hStack.translatesAutoresizingMaskIntoConstraints = false
        return hStack
        
    }()
    override func viewDidLayoutSubviews() {
        configureUI()
        
        
        
    }
    
    private func configureUI(){
        title = "Pick Your Date"
        view.backgroundColor = UIColor(light: .systemGroupedBackground, dark: .black)   /// For Dark and Light Mode support
        
        view.addSubview(calendar)
        view.addSubview(confirmButton)
        selectedStack.addArrangedSubview(selectedLabel)
        view.addSubview(selectedStack)
        NSLayoutConstraint.activate([
            calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            calendar.topAnchor.constraint(equalTo: view.topAnchor,constant: 100),
            calendar.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 50),
            
            confirmButton.topAnchor.constraint(equalTo: view.topAnchor,constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            confirmButton.heightAnchor.constraint(equalToConstant: 20),
            

            
            selectedStack.topAnchor.constraint(equalTo: view.topAnchor,constant: 50),
            selectedStack.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            selectedStack.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
           
            
            
            
        ])
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalender()
        setupGestures()
        setupBindings()
        
    }
    
    func setupCalender(){
        calendar.delegate = self
    }
    func setupGestures(){
        confirmButton.addTarget(self, action: #selector(confirm), for: .touchUpInside)
    }
    @objc func confirm(){
        selectedDates.send(calendar.selectedDates)
    }
    func setupBindings(){
        viewModel.$isRange.sink {[weak self] isRange in
            if isRange{
                self?.selectedLabel.text = "Select Your Range"
                
            }else{
                self?.selectedLabel.text = "Select You Date"

            }
        }.store(in: &cancellables)
    }

 
}

