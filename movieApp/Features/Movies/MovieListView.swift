//
//  MovieListView.swift
//  movieApp
//
//  Created by Ichsan Indra Wahyudi on 28/10/24.
//

import Foundation
import UIKit

class MovieListView: UIView {
    enum SectionType: Int, CaseIterable {
        case genres
        case movies
    }
    
    private let collectionView: AutoResizableCollectionView = {
        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.estimatedItemSize.height = UICollectionViewFlowLayout.automaticSize.height
//        layout.minimumLineSpacing = 8
//        layout.minimumInteritemSpacing = 8
        
        let view = AutoResizableCollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .systemRed
        return view
    }()
    
    var genres: [Genre] = [] {
        didSet {
            print(">>> RELOAD genres \(genres.count)")
//            collectionView.reloadSections(IndexSet(integer: SectionType.genres.rawValue))
            collectionView.reloadData()
        }
    }
    
    var movies: [Movie] = [] {
        didSet {
            print(">>> RELOAD movies \(movies.count)")
            collectionView.reloadData()
        }
    }
    
    init() {
        super.init(frame: .zero)
        
        setupUI()
        setupCollection()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func setupCollection() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = createLayout()
      
        
        collectionView.register(
            MovieViewCell.self,
            forCellWithReuseIdentifier: MovieViewCell.identifier
        )
        
        collectionView.register(
            GenreViewCell.self,
            forCellWithReuseIdentifier: GenreViewCell.identifier
        )
        
        collectionView.register(
            UICollectionViewCell.self,
            forCellWithReuseIdentifier: "empty_cell"
        )
    }
    
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        collectionView.collectionViewLayout.invalidateLayout() // Invalidate layout to ensure it recalculates size
//    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        collectionView.collectionViewLayout.invalidateLayout()
//        let contentHeight = collectionView.collectionViewLayout.collectionViewContentSize.height
//        collectionView.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
//        
//        print(">>> layoutSubviews collectionView size: \(collectionView.collectionViewLayout.collectionViewContentSize)")
////        genreCollectionView.frame.size.height = height
//        layoutIfNeeded()
//    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            guard let sectionType = SectionType(rawValue: sectionIndex) else {
                return nil
            }
            
            switch sectionType {
            case .movies:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(150))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 8
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                
                return section
                
            case .genres:
                let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .absolute(40))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.interGroupSpacing = 8
                section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
                return section
            }
        }
    }
}

extension MovieListView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return SectionType.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch SectionType(rawValue: section) {
        case .movies:
            return movies.count
            
        case .genres:
            return genres.count
            
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch SectionType(rawValue: indexPath.section) {
        case .movies:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieViewCell.identifier, for: indexPath) as? MovieViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setupData(for: movies[indexPath.item], with: genres);
            
            return cell
            
        case .genres:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreViewCell.identifier, for: indexPath) as? GenreViewCell else {
                return UICollectionViewCell()
            }
            
            cell.setupData(for: genres[indexPath.item].name)
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
       
    }
}

extension MovieListView: UICollectionViewDelegateFlowLayout {}

class AutoResizableCollectionView: UICollectionView {
    override var intrinsicContentSize: CGSize {
        /// include the contentInset
        /// since we have cases where we are going have the contentInset & contentSize
        ///
        return CGSize(
            width: contentSize.width + contentInset.left + contentInset.right,
            height: contentSize.height + contentInset.top + contentInset.bottom
        )
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !__CGSizeEqualToSize(bounds.size, self.intrinsicContentSize) {
            self.invalidateIntrinsicContentSize()
        }
    }
}
