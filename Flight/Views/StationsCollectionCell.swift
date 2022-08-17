//
//  StationsCollectionCell.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import Foundation
import UIKit

class StationsCollectionCell: UICollectionViewCell {
    static let reuseIdentifier = "Cell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let Name : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let BackgroundImage : UIImageView = {
        let image = UIImageView(frame: .zero)
        image.contentMode  = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        image.image = UIImage(named: "stationsBackground")
        return image
    }()
    
    
    func configureUI(){
        
        contentView.addSubview(BackgroundImage)
        contentView.addSubview(Name)
        
        
        NSLayoutConstraint.activate([
            BackgroundImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            BackgroundImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            BackgroundImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5),
            BackgroundImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5),
            
            
            Name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            Name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            Name.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            Name.topAnchor.constraint(equalTo: contentView.topAnchor)
            
        ])
        
        
    }
    func configureCell(station:Station){
        Name.text = station.name

    }
    
    
    
}
