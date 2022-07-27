//
//  BaseCollectionViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 27.07.2022.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let title: UILabel = {
        let title = UILabel()
        title.text = "Name of Song"
        title.font = .systemFont(ofSize: 18, weight: .bold)
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
    }
    
    func setupData(image: UIImage?, title: String, subTitle: String) {
        self.imageView.image = image
        self.title.text = title
        self.subtitle.text = subTitle
    }
}
