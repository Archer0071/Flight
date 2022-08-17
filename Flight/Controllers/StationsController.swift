//
//  StationsController.swift
//  Flight
//
//  Created by ARCHER on 17/08/2022.
//

import Foundation
import UIKit
import Combine
class StationsController:UIViewController{
    
    var viewModel : StationsViewModel
    init(viewModel:StationsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    private let indicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.style = UIActivityIndicatorView.Style.medium
        return activityIndicator
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout:StationsCollectionFlowLayout())
        collectionView.register(StationsCollectionCell.self, forCellWithReuseIdentifier: StationsCollectionCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor  = .clear
        return collectionView
        
    }()
    
    override func viewDidLayoutSubviews() {
        configureUI()
    }
    
    private func configureUI(){
        title = "STATIONS"
        view.backgroundColor = UIColor(light: .systemGroupedBackground, dark: .black)   /// For Dark and Light Mode support
        
        collectionView.frame = view.bounds
        view.addSubview(collectionView)                /// Adding CollectionVIew to ViewController View
        
        indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicator.center = CGPoint(x: UIScreen.main.bounds.size.width/2, y: 20)
        collectionView.addSubview(indicator)         /// Adding ActivityIndicatior Loading  to CollectionView
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupActivityIndicator()
        setupBindings()
    }
    
    private func setupCollectionView(){     /// Setting CollectionVIew Delegates/DataSource
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupActivityIndicator() { /// Animating ActivityIndication at creation
        indicator.startAnimating()
    }
    
    private func setupBindings() {      /// ViewBindings Reactive
        viewModel.$stations
            .receive(on:DispatchQueue.main)
            .sink {[weak self] station in
                if  self?.viewModel.stations?.stations.count ?? 0 > 0 {
                    self?.indicator.stopAnimating()
                    self?.indicator.hidesWhenStopped = true
                    
                }
                
                UIView.transition(
                    with: (self?.collectionView)!,
                    duration: 0.2,
                    options: .transitionCrossDissolve,
                    animations: { self?.collectionView.reloadData() },
                    completion: nil
                )
                
            }
            .store(in: &cancellables)
        
        viewModel.$showAlert        /// Showing Alert  on Error Fetching Networks
            .receive(on: DispatchQueue.main)
            .sink{[weak self] showAlert in
                if showAlert {
                    let alert = UIAlertController(title: "Error", message: self?.viewModel.listLoadingError, preferredStyle:.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alert, animated: true, completion: nil)
                    self?.indicator.stopAnimating()
                }
                
            }.store(in: &cancellables)
    }
}
