//
//  SongCollectionViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 09.07.2022.
//

import UIKit

class SongCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "SongCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.text = "Name of Song"
        title.font = .systemFont(ofSize: 17, weight: .bold)
        title.textColor = .darkGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.text = "Artist"
        subtitle.font = .systemFont(ofSize: 15)
        subtitle.textColor = .lightGray
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        contentView.addSubview(subtitle)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 160),
            imageView.widthAnchor.constraint(equalToConstant: 160),
            
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 2.5),
            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            title.heightAnchor.constraint(equalToConstant: 20),
            
            subtitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2.5),
            subtitle.trailingAnchor.constraint(equalTo: title.trailingAnchor),
            subtitle.leadingAnchor.constraint(equalTo: title.leadingAnchor),
            subtitle.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
