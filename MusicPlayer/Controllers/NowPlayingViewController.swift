//
//  NowPlayingViewController.swift
//  MusicPlayer
//
//  Created by Gleb Glushok on 06.07.2022.
//

import UIKit

class NowPlayingViewController: UIViewController {

    private let imageSong: UIImageView = {
        let imageSong = UIImageView()
        imageSong.image = UIImage(named: "Scandroid")
        imageSong.contentMode = .scaleToFill
        imageSong.layer.cornerRadius = 10
        imageSong.layer.masksToBounds = true
        imageSong.translatesAutoresizingMaskIntoConstraints = false
        return imageSong
    }()
    
    private let titleSong: UILabel = {
        let titleSong = UILabel()
        titleSong.text = "Scandroid - Neo Tokyo (Dance With The Dead Remix)"
        titleSong.font = .systemFont(ofSize: 25, weight: .bold)
        titleSong.textColor = .darkGray
        titleSong.numberOfLines = 0
        titleSong.textAlignment = .center
        titleSong.translatesAutoresizingMaskIntoConstraints = false
        return titleSong
    }()
    
    private let currentTimeSong: UILabel = {
        let currentTimeSong = UILabel()
        currentTimeSong.text = "1:42"
        currentTimeSong.font = .systemFont(ofSize: 15, weight: .medium)
        currentTimeSong.translatesAutoresizingMaskIntoConstraints = false
        return currentTimeSong
    }()
    
    private let durationSong: UILabel = {
        let durationSong = UILabel()
        durationSong.text = "5:53"
        durationSong.font = .systemFont(ofSize: 15, weight: .medium)
        durationSong.translatesAutoresizingMaskIntoConstraints = false
        return durationSong
    }()
    
    private let progressSongView: UIProgressView = {
        let progressSongView = UIProgressView()
        progressSongView.progress = 0.40
        progressSongView.translatesAutoresizingMaskIntoConstraints = false
        return progressSongView
    }()
    
    private let backwardButton: UIButton = {
        let backwardButton = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .medium, scale: .default)
        backwardButton.setImage(UIImage(systemName: "backward.end", withConfiguration: config), for: .normal)
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        return backwardButton
    }()
    
    private let playButton: UIButton = {
        let playButton = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 42, weight: .medium, scale: .default)
        playButton.setImage(UIImage(systemName: "play.circle", withConfiguration: config), for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private let forwardButton: UIButton = {
        let forwardButton = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .medium, scale: .default)
        forwardButton.setImage(UIImage(systemName: "forward.end", withConfiguration: config), for: .normal)
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        return forwardButton
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(imageSong)
        view.addSubview(titleSong)
        view.addSubview(currentTimeSong)
        view.addSubview(durationSong)
        view.addSubview(progressSongView)
        view.addSubview(backwardButton)
        view.addSubview(playButton)
        view.addSubview(forwardButton)
        setupUI()
    }
    
    func setupUI() {
        NSLayoutConstraint.activate([
            imageSong.topAnchor.constraint(equalTo: view.topAnchor, constant: 170),
            imageSong.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageSong.heightAnchor.constraint(equalToConstant: 280),
            imageSong.widthAnchor.constraint(equalToConstant: 280),
            
            titleSong.topAnchor.constraint(equalTo: imageSong.bottomAnchor, constant: 10),
            titleSong.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleSong.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            currentTimeSong.topAnchor.constraint(equalTo: titleSong.bottomAnchor, constant: 20),
            currentTimeSong.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            durationSong.topAnchor.constraint(equalTo: titleSong.bottomAnchor, constant: 20),
            durationSong.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            progressSongView.topAnchor.constraint(equalTo: currentTimeSong.bottomAnchor, constant: 10),
            progressSongView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressSongView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            backwardButton.topAnchor.constraint(equalTo: progressSongView.bottomAnchor, constant: 40),
            backwardButton.trailingAnchor.constraint(equalTo: playButton.leadingAnchor, constant: -30),
            
            playButton.topAnchor.constraint(equalTo: progressSongView.bottomAnchor, constant: 40),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            forwardButton.topAnchor.constraint(equalTo: progressSongView.bottomAnchor, constant: 40),
            forwardButton.leadingAnchor.constraint(equalTo: playButton.trailingAnchor, constant: 30),
        ])
    }
}
