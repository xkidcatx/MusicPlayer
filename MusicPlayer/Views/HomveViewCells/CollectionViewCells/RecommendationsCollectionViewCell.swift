//
//  RecommendationsCollectionViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 26.07.2022.
//

import UIKit

class RecommendationsCollectionViewCell: UICollectionViewCell {
    static let identifire = "RecommendationsCollectionViewCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.text = "Name of Song"
        title.font = .systemFont(ofSize: 17, weight: .bold)
        title.textColor = .darkGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.text = "Artist"
        subtitle.font = .systemFont(ofSize: 15)
        subtitle.textColor = .lightGray
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
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
            
            title.bottomAnchor.constraint(equalTo: subtitle.topAnchor),
            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.heightAnchor.constraint(equalToConstant: 20),
            
            subtitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            subtitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            subtitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            subtitle.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
