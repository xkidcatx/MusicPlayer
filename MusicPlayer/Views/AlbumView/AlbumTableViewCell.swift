//
//  AlbumTableViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 29.07.2022.
//

import UIKit

class AlbumTableViewCell: UITableViewCell {

    static let identifire = "AlbumTableViewCell"
    
    lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = .systemFont(ofSize: 15, weight: .medium)
        timeLabel.textColor = .black
        timeLabel.textAlignment = .right
        timeLabel.text = "3:56"
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        return timeLabel
    }()
    
    lazy var imageview: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.text = "Example"
        title.font = .systemFont(ofSize: 20, weight: .medium)
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    lazy var subTitle: UILabel = {
        let subTitle = UILabel()
        subTitle.text = "Example"
        subTitle.font = .systemFont(ofSize: 15, weight: .medium)
        subTitle.textColor = .lightGray
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        return subTitle
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        spinner.startAnimating()
    }
    
    private func setupUI() {
        contentView.addSubview(title)
        contentView.addSubview(subTitle)
        contentView.addSubview(imageview)
        contentView.addSubview(timeLabel)
        contentView.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            imageview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imageview.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            imageview.heightAnchor.constraint(equalToConstant: 60),
            imageview.widthAnchor.constraint(equalToConstant: 60),
            
            title.leadingAnchor.constraint(equalTo: imageview.trailingAnchor, constant: 10),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 80 / 2 - 20),
            title.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -10),
            
            subTitle.leadingAnchor.constraint(equalTo: imageview.trailingAnchor, constant: 10),
            subTitle.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 0),
            subTitle.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -10),
            
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            timeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            spinner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            spinner.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            spinner.heightAnchor.constraint(equalToConstant: 60),
            spinner.widthAnchor.constraint(equalToConstant: 60),
        ])
    }
}
