//
//  AlbumHeaderFooterView.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 30.07.2022.
//

import UIKit

class AlbumHeaderFooterView: UITableViewHeaderFooterView {
    
    static let identifire = "sectionHeader"
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 20, weight: .regular)
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    lazy var subTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.font = .systemFont(ofSize: 15, weight: .regular)
        subTitle.textColor = .black
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        return subTitle
    }()
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.addSubview(imageView)
        contentView.addSubview(title)
        contentView.addSubview(subTitle)
        contentView.addSubview(spinner)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        spinner.startAnimating()
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            imageView.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor),
            subTitle.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            spinner.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: contentView.topAnchor),
            spinner.heightAnchor.constraint(equalToConstant: contentView.frame.width / 2),
            spinner.widthAnchor.constraint(equalToConstant: contentView.frame.width / 2),
        ])
    }
}


