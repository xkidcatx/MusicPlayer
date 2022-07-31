//
//  FeaturedPlaylistsCollectionViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 27.07.2022.
//

import UIKit

class FeaturedPlaylistsCollectionViewCell: BaseCollectionViewCell {
    
    static let identifire = "FeaturedPlaylistsCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupUI() {
        contentView.backgroundColor = .clear
        contentView.layer.cornerRadius = 10
        
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
        ])
    }
}
