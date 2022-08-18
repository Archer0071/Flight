//
//  PassengerTableCell.swift
//  Flight
//
//  Created by ARCHER on 18/08/2022.
//

import Foundation
import UIKit
import Combine
class PassengerTableCell: UITableViewCell {
    static let reuseIdentifier = "Cell"
    var viewModel:PassengerViewModel?
    var indexPath:IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private let passengerType : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Type"
        label.textColor = UIColor(light: .black, dark: .white)
        
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let passengerDescription : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Detail"
        label.textColor = UIColor(light: .black, dark: .white)
       
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let passengerCounter : UIStepper = {
        let steper = UIStepper(frame: .zero)
        steper.translatesAutoresizingMaskIntoConstraints = false
        return steper
    }()
    
    
    private let passengerCounterLabel : UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "0"
        label.textAlignment = .center
        label.textColor = UIColor(light: .black, dark: .white)
        label.backgroundColor = UIColor(light: .white, dark: .gray)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    func configureUI(){
        backgroundColor = .clear
        selectionStyle  = .none
    
        passengerCounter.addTarget(self, action: #selector(self.passengerCount), for: .valueChanged)
        contentView.addSubview(passengerType)
        contentView.addSubview(passengerDescription)
        contentView.addSubview(passengerCounter)
        contentView.addSubview(passengerCounterLabel)
        NSLayoutConstraint.activate([
            passengerType.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            passengerType.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            
            passengerDescription.topAnchor.constraint(equalTo: passengerType.bottomAnchor),
            passengerDescription.leadingAnchor.constraint(equalTo: passengerType.leadingAnchor),
            
            passengerCounter.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20),
            passengerCounter.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            passengerCounterLabel.trailingAnchor.constraint(equalTo: passengerCounter.leadingAnchor,constant: -10),
            passengerCounterLabel.centerYAnchor.constraint(equalTo: passengerCounter.centerYAnchor),
            passengerCounterLabel.heightAnchor.constraint(equalTo: passengerCounter.heightAnchor),
            passengerCounterLabel.widthAnchor.constraint(equalToConstant: 40),

        ])
    }
    @objc func passengerCount(){
        passengerCounterLabel.text = passengerCounter.value.formatted()
        if let viewModel = viewModel {
            if let indexPath = indexPath {
             viewModel.selectPassengerAt(indexPath: indexPath, count: Int(passengerCounter.value))
            }
            
        }
    }

    func configureCell(viewModel:PassengerViewModel,indexPath:IndexPath){
        self.viewModel = viewModel
        self.indexPath = indexPath
        passengerCounter.value = viewModel.passengerAt(indexPath: indexPath).selected
        passengerCounter.minimumValue = viewModel.passengerAt(indexPath: indexPath).min
        passengerCounter.maximumValue = viewModel.passengerAt(indexPath: indexPath).max
        passengerCounterLabel.text = viewModel.passengerAt(indexPath: indexPath).selected.formatted()
        passengerType.text = viewModel.passengerAt(indexPath: indexPath).type
        passengerDescription.text = viewModel.passengerAt(indexPath: indexPath).des
    }
    
  
}


