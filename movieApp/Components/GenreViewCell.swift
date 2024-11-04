//
//  GenreViewCell.swift
//  movieApp
//
//  Created by Ichsan Indra Wahyudi on 29/10/24.
//

import Foundation
import UIKit

class GenreViewCell: UICollectionViewCell {
    private var genreChipView: GenreChipView?
    
    static let identifier = "GenreViewCell.identifier"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        print(">>> INIT GENRE CELL")
//        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        genreChipView?.removeFromSuperview()
        genreChipView = nil
    }
    
    func setupData(for text: String) {
        genreChipView = GenreChipView(text: text)
        
        if let genreChipView {
            contentView.addSubview(genreChipView)
            
            NSLayoutConstraint.activate([
                genreChipView.topAnchor.constraint(equalTo: contentView.topAnchor),
                genreChipView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                genreChipView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                genreChipView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
            ])
        }
    }
}

class GenreChipView: UIView {
    private let textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    init(text: String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor.cyan
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.cyan.cgColor
        
        textLabel.text = text
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            textLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            textLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            textLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
