//
//  StationsController+Extensions.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import UIKit

extension StationsController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.stations?.stations.count ?? 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StationsCollectionCell.reuseIdentifier, for: indexPath) as! StationsCollectionCell
        cell.configureCell(station: viewModel.stations.stations[indexPath.row])
    
        
        return cell
        
    }

    
}
