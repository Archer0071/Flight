//
//  PassengerController.swift
//  Flight
//
//  Created by ARCHER on 18/08/2022.
//

import Foundation
import UIKit
import Combine
class PassengerController:UIViewController{
    private var cancellables: Set<AnyCancellable> = []
    var passengers = PassthroughSubject<[Passenger],Never>()
    var viewModel : PassengerViewModel
    init(viewModel:PassengerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
   private let tableView : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(PassengerTableCell.self, forCellReuseIdentifier: PassengerTableCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
        
    }()

   private let confirmButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Confirm", for: .normal)
        button.backgroundColor = UIColor(light: .black, dark: .white)
        button.setTitleColor(UIColor(light: .white, dark: .black), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
  
    
    override func viewDidLayoutSubviews() {
        configureUI()
    }
    
    private func configureUI(){
        title = "Select Passengers"
        view.backgroundColor = UIColor(light: .systemGroupedBackground, dark: .black)   /// For Dark and Light Mode support
        view.addSubview(confirmButton)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            confirmButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -50),
            confirmButton.heightAnchor.constraint(equalToConstant: 40),
            
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor)
            
        ])
      
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupBindings()
        setupGestures()
       
    }
    
    private func setupTableView(){     /// Setting TableView Delegates/DataSource
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func setupBindings(){
        viewModel.$passengers.sink {[weak self] passengers in
            self?.passengers.send(passengers)
        }.store(in: &cancellables)
    }
    private func setupGestures(){
        confirmButton.addTarget(self, action: #selector(self.confirm), for: .touchUpInside)
        
    }
    @objc func confirm(){
        dismiss(animated: true)
    }
}

