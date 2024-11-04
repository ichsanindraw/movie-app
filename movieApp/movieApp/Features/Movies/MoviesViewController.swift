//
//  MoviesViewController.swift
//  movieApp
//
//  Created by Ichsan Indra Wahyudi on 28/10/24.
//

import Combine
import Foundation
import UIKit

class MoviesViewController: UIViewController {
    private let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let errorView: EmptyView = {
        let view = EmptyView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: MovieListView = {
        let view = MovieListView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let viewModel = MovieViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Popular Movie"
        view.backgroundColor = .white
        
        setupNavigation()
        setupUI()
        
        bindViewModel()
        bindAction()
        
        viewModel.getMovies()
    }
    
    private func setupNavigation() {
        let appearance = UINavigationBarAppearance()
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let favoritesButton = UIBarButtonItem(
            image: UIImage(systemName: "heart.fill"),
            style: .plain,
            target: self,
            action: #selector(handleFavoriteButton)
        )
        favoritesButton.tintColor = UIColor.red
        
        let themeButton = UIBarButtonItem(
            image: UIImage(systemName: "moon"),
            style: .plain,
            target: self,
            action: #selector(handleThemeButton)
        )
        themeButton.tintColor = UIColor.darkGray
        
        navigationItem.rightBarButtonItems = [
            themeButton,
            favoritesButton,
        ]
    }
    
    @objc private func handleFavoriteButton() {
        print(">>> handleFavoriteButton")
    }
    
    @objc private func handleThemeButton() {
        print(">>> handleThemeButton")
        UserDefaults.standard.setValue(true, forKey: "")
    }
    
    func bindViewModel() {
        viewModel.$viewState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                switch state {
                case .loading:
                    self?.activityIndicatorView.startAnimating()
                    self?.activityIndicatorView.isHidden = false
                    
                    self?.errorView.isHidden = true
                    
                    self?.contentView.isHidden = true
                    break
                case let .error(text):
                    self?.activityIndicatorView.stopAnimating()
                    self?.activityIndicatorView.isHidden = true
                    
                    self?.errorView.isHidden = false
                    self?.errorView.errorMessage = text.localizedDescription
                    
                    self?.contentView.isHidden = true
                    break
                    
                case let .success(data):
                    self?.activityIndicatorView.stopAnimating()
                    self?.activityIndicatorView.isHidden = true
                    
                    self?.errorView.isHidden = true
                    
                    self?.contentView.isHidden = false
                    self?.contentView.movies = data
                    break
                }
            }
            .store(in: &cancellables)
        
        viewModel.$genres
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.contentView.genres = data
            }
            .store(in: &cancellables)
    }
    
    func bindAction() {
        errorView.buttonAction = { [weak self] in
            self?.viewModel.getMovies()
        }
    }
    
    func setupUI() {
        view.addSubview(activityIndicatorView)
        
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        view.addSubview(errorView)
        
        NSLayoutConstraint.activate([
            errorView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            errorView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            errorView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
        
        view.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

//import UIKit
//
//class DynamicCollectionViewController: UIViewController, UICollectionViewDataSource {
//
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.dataSource = self
//        collectionView.register(DynamicCollectionViewCell.self, forCellWithReuseIdentifier: "DynamicCollectionViewCell")
//        collectionView.backgroundColor = .lightGray
//
//        return collectionView
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(collectionView)
//
//        NSLayoutConstraint.activate([
//            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
//            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
//
//    // ... other methods ...
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 30 // Replace with your actual data source
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DynamicCollectionViewCell", for: indexPath) as? DynamicCollectionViewCell else {
//            return UICollectionViewCell()
//        }
//
//        let longText = "This is a very long text to test dynamic height adjustment in UICollectionView cells. It should wrap to multiple lines and the cell should adjust accordingly."
//        cell.configure(with: longText, image: nil)
//
//        return cell
//    }
//}
