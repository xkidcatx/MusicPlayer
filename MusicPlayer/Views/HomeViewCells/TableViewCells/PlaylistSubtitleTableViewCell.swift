//
//  PlaylistSubtitleTableViewCell.swift
//  MusicPlayer
//
//  Created by Eugene Kotovich on 06.08.2022.
//

import UIKit

class PlaylistSubtitleTableViewCell: UITableViewCell {
    
    static let identifier = "PlaylistSubtitleTableViewCell"
    
    private let label: UILabel = {
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let subtitleLabel: UILabel = {
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 1
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    private let iconImageView: UIImageView = {
        $0.image = UIImage(systemName: "photo")
        $0.contentMode = .scaleAspectFill
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = UIColor(named: "LightColour")
        contentView.addSubview(label)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(iconImageView)
        accessoryType = .disclosureIndicator
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        subtitleLabel.text = nil
    }
    
func configure(with viewModel: PlaylistSubtitleTableViewCellViewModel) {
    label.text = viewModel.title
    subtitleLabel.text = viewModel.subtitle
    //iconImageView.downloaded(from: viewModel.imageURL)
}

}

extension PlaylistSubtitleTableViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            iconImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            iconImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9),
            
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            subtitleLabel.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
            subtitleLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
        ])
    }
}
