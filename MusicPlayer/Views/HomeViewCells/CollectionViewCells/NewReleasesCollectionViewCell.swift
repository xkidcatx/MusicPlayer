//
//  NewReleasesCollectionViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 09.07.2022.
//

import UIKit

class NewReleasesCollectionViewCell: BaseCollectionViewCell {
    
    static let identifire = "NewReleasesCollectionViewCell"
    
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
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.height - 50),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
            
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2.5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            title.heightAnchor.constraint(equalToConstant: 20),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2.5),
            subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            subtitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subtitle.heightAnchor.constraint(equalToConstant: 20),
            
        ])
    }
}
