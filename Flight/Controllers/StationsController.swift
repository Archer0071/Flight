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
    
    private let searchController : UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.tintColor = UIColor(light: .black, dark: .white)
        return searchController
        
    }()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout:StationsCollectionFlowLayout())
        collectionView.register(StationsCollectionCell.self, forCellWithReuseIdentifier: StationsCollectionCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor  = .clear
        return collectionView
        
    }()
    
    private let refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl(frame: .zero)
        refresh.attributedTitle = NSAttributedString(string: "Refreshing", attributes: nil)
        return refresh
        
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
        
        if #available(iOS 10.0, *) {                         /// Checking IOS Version is Greater than 10
            collectionView.refreshControl = refreshControl   /// Adding Pull Down Refresh  to CollectionView
        } else {
            collectionView.addSubview(refreshControl)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupActivityIndicator()
        setupSearchController()
        setupRefreshController()
        setupBindings()
    }
    
    private func setupCollectionView(){     /// Setting CollectionVIew Delegates/DataSource
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setupActivityIndicator() { /// Animating ActivityIndication at creation
        indicator.startAnimating()
    }
    
    private func setupSearchController(){   /// Adding SearchController to Navigation Bar and setting delegate
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    private func setupRefreshController(){ /// Adding  Listener  For  RefreshController on pulling CollectionvIew
        refreshControl.addTarget(self, action: #selector(self.refreshData), for: UIControl.Event.valueChanged)
        
    }
    @objc private func refreshData(){     /// Refreshing CollectionVIew Datasource with delay and making sure searchbar becomes empty
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.viewModel.getList()
            self.searchController.searchBar.text = ""
            self.searchController.dismiss(animated: true)
            self.refreshControl.endRefreshing()
        }
        
    }
    
    private func setupBindings() {      /// ViewBindings Reactive
        viewModel.$stations
            .receive(on:DispatchQueue.main)
            .sink {[weak self] station in
                if  self?.viewModel.stations.count ?? 0 > 0 {
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
