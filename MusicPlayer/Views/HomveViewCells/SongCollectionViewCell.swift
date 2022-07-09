//
//  SongCollectionViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 09.07.2022.
//

import UIKit

class SongCollectionViewCell: UICollectionViewCell {
    
    static let identifire = "SongCollectionViewCell"
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .vertical
        stack.distribution = .fill
        stack.contentMode = .scaleToFill
        stack.spacing = 1
        stack.backgroundColor = .systemBackground
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "test")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 25
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let title: UILabel = {
        let title = UILabel()
        title.text = "asd"
        title.font = .systemFont(ofSize: 17, weight: .bold)
        title.textColor = .darkGray
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    private let subtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.text = "a"
        subtitle.font = .systemFont(ofSize: 15)
        subtitle.textColor = .lightGray
        subtitle.translatesAutoresizingMaskIntoConstraints = false
        return subtitle
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(stackView)
        contentView.backgroundColor = .systemBackground
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(title)
        stackView.addArrangedSubview(subtitle)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            
            imageView.heightAnchor.constraint(equalToConstant: 130),
            //title.heightAnchor.constraint(equalToConstant: 15),
            //subtitle.heightAnchor.constraint(equalToConstant: 15),
        ])
    }
}
