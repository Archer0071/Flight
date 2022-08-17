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
        
        return viewModel.numberOfStations()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StationsCollectionCell.reuseIdentifier, for: indexPath) as! StationsCollectionCell
        cell.configureCell(station: viewModel.stationAt(indexPath: indexPath))
    
        
        return cell
        
    }

    
}
extension StationsController : UISearchBarDelegate {
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCancel = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCancel = true

    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
    
}
