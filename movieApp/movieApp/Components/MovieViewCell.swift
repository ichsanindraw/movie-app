//
//  MovieViewCell.swift
//  movieApp
//
//  Created by Ichsan Indra Wahyudi on 28/10/24.
//

import Foundation
import Kingfisher
import SnapKit
import UIKit

class MovieViewCell: UICollectionViewCell {
    private let posterImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let wrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let starIconView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "star.fill")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = UIColor.yellow
        return view
    }()
    
    private let ratingView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let releaseIconView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "clock")
        view.translatesAutoresizingMaskIntoConstraints = false
        view.tintColor = UIColor.cyan
        view.frame.size = CGSize(width: 20, height: 20)
        return view
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let favoriteButtonView: UIButton = {
        let button = UIButton(configuration: .plain())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let genreCollectionView: AutoResizableCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = AutoResizableCollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    private let ratingStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 8
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemMint
        return view
    }()
    
    private let relaseStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillProportionally
        view.spacing = 8
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemTeal
        return view
    }()
    
    
    private let collectionWrapperView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var genresName: [String] = [] {
        didSet {
//            print(">>> didSet genresName")
            genreCollectionView.reloadData()
//            layoutIfNeeded()
//            setNeedsLayout()
        }
    }
  
    static let identifier = "MovieViewCell.identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        print(">>> INIT MOVIE CELL")
        
        backgroundColor = .blue
        
        setupUI()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        titleView.text = nil
        ratingView.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionWrapperView.layoutIfNeeded()
        genreCollectionView.collectionViewLayout.invalidateLayout()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        genreCollectionView.collectionViewLayout.invalidateLayout()
//        let contentHeight = genreCollectionView.collectionViewLayout.collectionViewContentSize.height
////        genreCollectionView.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
//        
//        print(">>> layoutSubviews size: \(genreCollectionView.collectionViewLayout.collectionViewContentSize)")
////        genreCollectionView.frame.size.height = height
//        layoutIfNeeded()
//    }
    
//    override func updateConstraints() {
//        super.updateConstraints()
//        let height = genreCollectionView.collectionViewLayout.collectionViewContentSize.height
//        print(">>> updateConstraints height: \(height)")
//        genreCollectionView.heightAnchor.constraint(equalToConstant: height).isActive = true
//    }
//    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        setNeedsLayout()
//        layoutIfNeeded()
//        
//        let targetSize = CGSize(width: layoutAttributes.frame.width, height: UIView.layoutFittingCompressedSize.height)
//        let calculatedSize = contentView.systemLayoutSizeFitting(targetSize,
//                                                                 withHorizontalFittingPriority: .required,
//                                                                 verticalFittingPriority: .fittingSizeLevel)
//        
//        layoutAttributes.frame.size = calculatedSize
//        return layoutAttributes
//    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        super.preferredLayoutAttributesFitting(layoutAttributes)
//        
//        // Ensure that the cell resizes based on its content
//        let targetSize = CGSize(width: layoutAttributes.bounds.width, height: 0)
//        let size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
//        
//        var newFrame = layoutAttributes.frame
//        newFrame.size.height = size.height
//        layoutAttributes.frame = newFrame
//        
//        return layoutAttributes
//    }
    
    private func setupUI() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(wrapperView)
        
        wrapperView.backgroundColor = .brown
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(8)
//            make.trailing.equalTo(wrapperView.snp.leading).offset(-8)
            make.width.equalTo(UIScreen.main.bounds.width * 0.2)
            make.bottom.equalTo(wrapperView.snp.bottom)
        }
        
        wrapperView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
        
    titleView: do {
        wrapperView.addSubview(titleView)
        
        titleView.snp.makeConstraints { make in
            make.top.equalTo(wrapperView.snp.top)
            make.leading.equalTo(wrapperView.snp.leading)
            make.trailing.equalTo(wrapperView.snp.trailing)
            make.height.equalTo(20)
        }
    }
        
    ratingStackView: do {
        wrapperView.addSubview(ratingStackView)
        
        ratingStackView.addArrangedSubview(starIconView)
        ratingStackView.addArrangedSubview(ratingView)
        
        ratingStackView.snp.makeConstraints { make in
            make.top.equalTo(titleView.snp.bottom).offset(8)
            make.leading.equalTo(wrapperView.snp.leading)
            make.height.equalTo(20)
        }
    }
        
    collectionWrapperView: do {
        wrapperView.addSubview(collectionWrapperView)
        
        collectionWrapperView.snp.makeConstraints { make in
            make.top.equalTo(ratingStackView.snp.bottom).offset(8)
            make.leading.equalTo(wrapperView.snp.leading)
            make.trailing.equalTo(wrapperView.snp.trailing)
            make.bottom.equalTo(wrapperView.snp.bottom)
        }
        
        collectionWrapperView.addSubview(genreCollectionView)
        
        genreCollectionView.snp.makeConstraints { make in
            make.size.equalTo(collectionWrapperView.snp.size)
//            make.top.equalTo(collectionWrapperView.snp.top)
//            make.leading.equalTo(collectionWrapperView.snp.leading)
//            make.trailing.equalTo(collectionWrapperView.snp.trailing)
//            make.bottom.equalTo(collectionWrapperView.snp.bottom)
        }
    }
        
    relaseStackView: do {
        wrapperView.addSubview(relaseStackView)
        
        relaseStackView.snp.makeConstraints { make in
//            make.top.equalTo(collectionWrapperView.snp.bottom).offset(8)
            make.leading.equalTo(wrapperView.snp.leading)
            make.trailing.equalTo(wrapperView.snp.trailing)
            make.bottom.equalTo(wrapperView.snp.bottom)
        }
    }
        
       
        
    }
   
//    private func setupUI() {
//        contentView.addSubview(posterImageView)
//        contentView.addSubview(wrapperView)
//        wrapperView.backgroundColor = .brown
//        
//        posterImageView.layer.cornerRadius = 8
//        
//        NSLayoutConstraint.activate([
//            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            posterImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.2),
//            posterImageView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor, constant: -8),
//            
//            wrapperView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            wrapperView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
//            wrapperView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            wrapperView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
//        ])
//        
//        wrapperView.addSubview(titleView)
//        wrapperView.addSubview(ratingStackView)
//        wrapperView.addSubview(collectionWrapperView)
//        wrapperView.addSubview(relaseStackView)
//        
//        collectionWrapperView.backgroundColor = .systemGray5
//        titleView.backgroundColor = .systemGray2
//        bottomView.backgroundColor = .systemTeal
//        
//        ratingStackView.addArrangedSubview(starIconView)
//        ratingStackView.addArrangedSubview(ratingView)
//        
//        NSLayoutConstraint.activate([
//            starIconView.widthAnchor.constraint(equalToConstant: 20),
//            starIconView.heightAnchor.constraint(equalToConstant: 20)
//        ])
//        
//        NSLayoutConstraint.activate([
//            titleView.topAnchor.constraint(equalTo: wrapperView.topAnchor),
//            titleView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 8),
//            titleView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -8),
//            titleView.heightAnchor.constraint(equalToConstant: 21),
//            
//            ratingStackView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
//            ratingStackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 8),
//            ratingStackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -8),
//            ratingStackView.heightAnchor.constraint(equalToConstant: 22),
//            
//            collectionWrapperView.topAnchor.constraint(equalTo: ratingStackView.bottomAnchor),
//            collectionWrapperView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 8),
//            collectionWrapperView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -8),
//            collectionWrapperView.bottomAnchor.constraint(equalTo: relaseStackView.topAnchor),
////            collectionWrapperView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
////            collectionWrapperView.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
////            collectionWrapperView.heightAnchor.constraint(equalToConstant: 400)
//            
//            relaseStackView.topAnchor.constraint(equalTo: collectionWrapperView.bottomAnchor),
//            relaseStackView.leadingAnchor.constraint(equalTo: wrapperView.leadingAnchor, constant: 8),
//            relaseStackView.trailingAnchor.constraint(equalTo: wrapperView.trailingAnchor, constant: -8),
//            relaseStackView.bottomAnchor.constraint(equalTo: wrapperView.bottomAnchor),
//            relaseStackView.heightAnchor.constraint(equalToConstant: 23),
//        ])
//        
//        collectionWrapperView.addSubview(genreCollectionView)
//        
//        NSLayoutConstraint.activate([
//            genreCollectionView.topAnchor.constraint(equalTo: collectionWrapperView.topAnchor, constant: 8),
//            genreCollectionView.leadingAnchor.constraint(equalTo: collectionWrapperView.leadingAnchor, constant: 8),
//            genreCollectionView.trailingAnchor.constraint(equalTo: collectionWrapperView.trailingAnchor, constant: -8),
//            genreCollectionView.bottomAnchor.constraint(equalTo: collectionWrapperView.bottomAnchor, constant: -8),
////            genreCollectionView.heightAnchor.constraint(equalToConstant: 400)
//        ])
//        
//        relaseStackView.addArrangedSubview(releaseIconView)
//        relaseStackView.addArrangedSubview(releaseLabel)
//        
////        titleView.setContentHuggingPriority(.defaultLow, for: .vertical)
////        titleView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
////        
////        genreCollectionView.setContentHuggingPriority(.defaultHigh, for: .vertical)
////        genreCollectionView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
//    }
    
    private func setupCollectionView() {
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
//        genreCollectionView.isScrollEnabled = false

        genreCollectionView.collectionViewLayout = createLayout()
        
        genreCollectionView.register(
            GenreViewCell.self,
            forCellWithReuseIdentifier: GenreViewCell.identifier
        )
    }
    
    private func createLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(40))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            group.interItemSpacing = .fixed(8)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .none
            
            return section
        }
    }
    
    func setupData(for movie: Movie, with genres: [Genre]) {
        if let url = URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath)") {
            posterImageView.kf.setImage(
                with: url,
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]
            )
        }
       
        titleView.text = movie.title
//        titleView.text = "lorem ipsum dajdo dahsuod hdao dhsauo dhsuao hdusao dhsuaod shauodsa hduisap dshuaid shuai dshaui dgsai dgsai dgsuaid gsuia dhgsuaid gsuaid gsuaid ghsaui dghsuiap dgusaip dgusaip dgsuia dgusip dgsuiap gdusip gdis gduisgpaduia sgduiasp d"
        ratingView.text = "\(String(format: "%.1f", movie.voteAverage))/10"
        releaseLabel.text = movie.releaseDate
        
        genresName.removeAll()
        
        for genreId in movie.genreIDS {
            for genre in genres {
                if genreId == genre.id {
                    genresName.append(genre.name)
//                    print(">>> movie \(movie.title) || genresName.count: \(genresName)")
                }
            }
        }
    }
}

extension MovieViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genresName.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreViewCell.identifier, for: indexPath) as? GenreViewCell else {
            return UICollectionViewCell()
        }
        
        cell.setupData(for: genresName[indexPath.item])
        
        return cell
    }
}

//import UIKit
//
//class DynamicCollectionViewCell: UICollectionViewCell {
//
//    let posterImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//
//    let titleLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
//        label.font = .systemFont(ofSize: 16) // Adjust font size as needed
//        return label
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        backgroundColor = .systemBlue
//
//        contentView.addSubview(posterImageView)
//        contentView.addSubview(titleLabel)
//
//        NSLayoutConstraint.activate([
//            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
//            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
//            posterImageView.widthAnchor.constraint(equalToConstant: 100),
//            posterImageView.heightAnchor.constraint(equalToConstant: 150),
//
//            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
//            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 8),
//            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
//            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
//        ])
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configure(with titleText: String, image: UIImage?) {
//        titleLabel.text = titleText
//        posterImageView.image = image
//    }
//
//    override var intrinsicContentSize: CGSize {
//        let titleLabelSize = titleLabel.sizeThatFits(.zero)
//        let contentViewSize = CGSize(width: contentView.bounds.width, height: max(posterImageView.frame.maxY, titleLabelSize.height + 8))
//        
//        let size = systemLayoutSizeFitting(.zero, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
////               return size
//        print(">>> contentViewSize: \(contentViewSize) || size: \(size)")
//       
//        return contentViewSize
//    }
//}
