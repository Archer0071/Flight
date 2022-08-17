//
//  StationsCollectionCell.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import Foundation
import UIKit
import Kingfisher

class StationsCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let nameView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(light: .white, dark: .black)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let name : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let backView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(light: .white, dark: .opaqueSeparator)
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stationImage : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode  = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.backgroundColor = .systemGroupedBackground
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    private let stationDetailStack : UIStackView = {
        let vstack = UIStackView(frame: .zero)
        vstack.axis = .vertical
        vstack.distribution = .fillEqually
        vstack.alignment = .fill
        vstack.clipsToBounds = true
        vstack.translatesAutoresizingMaskIntoConstraints = false
        return vstack
    }()
    private let countryCode : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let countryName : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    private let boardingPassView : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let boardingPass : UILabel = {
        let label = UILabel()
        label.textColor = UIColor(light: .black, dark: .white)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
   
    private let boardingCheck : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode  = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.image = UIImage(named: "checkmark")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    func configureUI(){
        backView.addSubview(stationImage)
        
        boardingPassView.addSubview(boardingPass)
        boardingPassView.addSubview(boardingCheck)
        
            
        stationDetailStack.addArrangedSubview(countryName)
        stationDetailStack.addArrangedSubview(countryCode)
        stationDetailStack.addArrangedSubview(boardingPassView)
        
        backView.addSubview(stationDetailStack)
        contentView.addSubview(backView)
        
        nameView.addSubview(name)
        contentView.addSubview(nameView)
        
        
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5),
            backView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5),
            backView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5),
            backView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            
            stationImage.topAnchor.constraint(equalTo: backView.topAnchor),
            stationImage.leadingAnchor.constraint(equalTo: backView.leadingAnchor),
            stationImage.trailingAnchor.constraint(equalTo: backView.trailingAnchor),
            stationImage.heightAnchor.constraint(equalToConstant: contentView.bounds.height/1.8),
            
            stationDetailStack.topAnchor.constraint(equalTo: stationImage.bottomAnchor),
            stationDetailStack.leadingAnchor.constraint(equalTo: backView.leadingAnchor,constant: 5),
            stationDetailStack.trailingAnchor.constraint(equalTo: backView.trailingAnchor,constant: -5),
            stationDetailStack.bottomAnchor.constraint(equalTo: backView.bottomAnchor,constant: -5),
            
            
            boardingPass.leadingAnchor.constraint(equalTo: boardingPassView.leadingAnchor),
            boardingPass.topAnchor.constraint(equalTo: boardingPassView.topAnchor),
            boardingPass.bottomAnchor.constraint(equalTo: boardingPass.bottomAnchor),
            
            boardingCheck.heightAnchor.constraint(equalTo: boardingPass.heightAnchor),
            boardingCheck.widthAnchor.constraint(equalToConstant: 30),
            boardingCheck.leadingAnchor.constraint(equalTo: boardingPass.trailingAnchor),
            boardingCheck.topAnchor.constraint(equalTo: boardingPassView.topAnchor),
            
            
            nameView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            nameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 15),
            nameView.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -10),
            
            name.leadingAnchor.constraint(equalTo: nameView.leadingAnchor,constant: 5),
            name.trailingAnchor.constraint(equalTo: nameView.trailingAnchor,constant: -5),
            name.topAnchor.constraint(equalTo: nameView.topAnchor,constant: 5),
            name.bottomAnchor.constraint(equalTo: nameView.bottomAnchor,constant: -5),
            
            
        ])
        
        
    }
    func configureCell(station:Station){
        
        name.text = station.name
        countryCode.text = "Code: \(station.code)"
        countryName.text = "Country Name: \(station.countryName ?? "")"
        boardingPass.text = "Mobile Boarding Pass: "
        if let urlString = station.tripCardImageURL {
            stationImage.kf.indicatorType = .activity
            stationImage.kf.setImage(with: URL(string: urlString))
        }

    }
    
    
    
}
