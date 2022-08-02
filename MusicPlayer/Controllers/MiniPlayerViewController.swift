//
//  MiniPlayerViewController.swift
//  MusicPlayer
//
//  Created by Eugene Kotovich on 27.07.2022.
//

import UIKit

protocol MiniPlayerDelegate {
    func presentPlayerView()
}

class MiniPlayerViewController: UIViewController {
    
    var delegate: MiniPlayerDelegate?
    
    let pauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(named: "LightColour")
        let config = UIImage.SymbolConfiguration( pointSize: 32, weight: .medium, scale: .default)
        button.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(named: "LightColour")
        let config = UIImage.SymbolConfiguration( pointSize: 18, weight: .medium, scale: .default)
        button.setImage(UIImage(systemName: "backward.fill", withConfiguration: config), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    let forwardButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor(named: "LightColour")
        let config = UIImage.SymbolConfiguration( pointSize: 18, weight: .medium, scale: .default)
        button.setImage(UIImage(systemName: "forward.fill", withConfiguration: config), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    } ()
    let imageAlbum: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "Lightwire - City of Dreams")
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 23
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    } ()
    let artistLable: UILabel = {
        let label = UILabel()
        label.text = "Artist Name"
        label.textColor = UIColor(named: "LightColour")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let trackLable: UILabel = {
        let label = UILabel()
        label.text = "Track"
        label.textColor = UIColor(named: "LightColour")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        let leftColor = UIColor(named: "BrownColour")
        let rightColor = UIColor(named: "LightColour")
        gradientLayer.frame = .init(x: 0, y: 0, width: view.frame.width, height: 120)
        gradientLayer.colors = [leftColor!.cgColor, rightColor!.cgColor, leftColor!.cgColor]
        gradientLayer.locations = [0.0, 1.5]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
        
        // add a tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        
        // add buttons
        view.addSubview(pauseButton)
        view.addSubview(backButton)
        view.addSubview(forwardButton)
        view.addSubview(imageAlbum)
        view.addSubview(artistLable)
        view.addSubview(trackLable)
        setupconstraints()
    }
    
    @objc func tapDetected() {
        guard let delegate = delegate else { return }
        delegate.presentPlayerView()
    }
    
    private func setupconstraints() {
        NSLayoutConstraint.activate([
            pauseButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            pauseButton.topAnchor.constraint(equalTo: view.topAnchor, constant: +25),
            pauseButton.heightAnchor.constraint(equalToConstant: 32),
            pauseButton.widthAnchor.constraint(equalToConstant: 32),
            
            backButton.rightAnchor.constraint(equalTo: pauseButton.leftAnchor, constant: -5),
            backButton.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 25),
            
            forwardButton.leftAnchor.constraint(equalTo: pauseButton.rightAnchor, constant: +5),
            forwardButton.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor),
            forwardButton.heightAnchor.constraint(equalToConstant: 20),
            forwardButton.widthAnchor.constraint(equalToConstant: 25),
            
            imageAlbum.leftAnchor.constraint(equalTo: view.leftAnchor, constant: +20),
            imageAlbum.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor),
            imageAlbum.heightAnchor.constraint(equalToConstant: 46),
            imageAlbum.widthAnchor.constraint(equalToConstant: 46),
            
            artistLable.leftAnchor.constraint(equalTo: imageAlbum.rightAnchor, constant: +10),
            artistLable.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor, constant: -10),
            artistLable.heightAnchor.constraint(equalToConstant: 20),
            artistLable.rightAnchor.constraint(equalTo: backButton.leftAnchor, constant: -20),
            
            trackLable.leftAnchor.constraint(equalTo: imageAlbum.rightAnchor, constant: +10),
            trackLable.centerYAnchor.constraint(equalTo: pauseButton.centerYAnchor, constant: +10),
            trackLable.heightAnchor.constraint(equalToConstant: 20),
            trackLable.rightAnchor.constraint(equalTo: backButton.leftAnchor, constant: -20)
            
        ])
    }
}
