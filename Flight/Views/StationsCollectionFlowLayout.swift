//
//  StationsCollectionFlowlayout.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import UIKit

class StationsCollectionFlowLayout:UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        self.scrollDirection = .vertical
        self.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        self.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = 0
    }
   
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
