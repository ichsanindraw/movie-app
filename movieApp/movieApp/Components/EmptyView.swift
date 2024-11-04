//
//  EmptyView.swift
//  movieApp
//
//  Created by Ichsan Indra Wahyudi on 28/10/24.
//

import Combine
import Foundation
import UIKit

class EmptyView: UIView {
    private let labelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    private let buttonView: UIButton = {
        let button = UIButton(configuration: .filled())
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Try Again", for: .normal)
        return button
    }()
    
    var errorMessage: String = "" {
        didSet {
            labelView.text = errorMessage
        }
    }
    
    var buttonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        
        buttonView.addTarget(self, action: #selector(handleTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(labelView)
        addSubview(buttonView)
        
        NSLayoutConstraint.activate([
            labelView.centerYAnchor.constraint(equalTo: centerYAnchor),
            labelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            buttonView.topAnchor.constraint(equalTo: labelView.bottomAnchor, constant: 16),
            buttonView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    @objc private func handleTapped() {
        buttonAction?()
    }
}
