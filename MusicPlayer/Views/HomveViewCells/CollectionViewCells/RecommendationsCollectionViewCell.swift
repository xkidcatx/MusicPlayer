//
//  RecommendationsCollectionViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 26.07.2022.
//

import UIKit

class RecommendationsCollectionViewCell: BaseCollectionViewCell {
    
    static let identifire = "RecommendationsCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        contentView.backgroundColor = .systemGroupedBackground
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 75),
            imageView.widthAnchor.constraint(equalToConstant: 75),
            
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor, constant: -2.5),
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            title.heightAnchor.constraint(equalToConstant: 20),
            
            subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            subtitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            subtitle.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
