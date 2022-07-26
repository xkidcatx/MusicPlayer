//
//  NowPlayingViewController.swift
//  MusicPlayer
//
//  Created by Gleb Glushok on 06.07.2022.
//

import UIKit
import AVFoundation

class NowPlayingViewController: UIViewController {
    
    static var isPlaing = false
    var trackName = "track"
    var artistName = "artist"
    var imageAlbum = UIImage()
    
    private var playerStop = true {
        didSet {
            let config = UIImage.SymbolConfiguration(pointSize: 42, weight: .medium, scale: .default)
            let myTabBar = tabBarController as? MainTabBarController
            if playerStop {
                NowPlayingViewController.isPlaing = true
                playButton.setImage(UIImage(systemName: "pause.circle", withConfiguration: config), for: .normal)
                myTabBar?.miniPlayer.pauseButton.setImage(UIImage(systemName: "pause.fill", withConfiguration: config), for: .normal)
                NowPlayingViewController.player?.play()
            } else {
                NowPlayingViewController.isPlaing = false
                playButton.setImage(UIImage(systemName: "play.circle", withConfiguration: config), for: .normal)
                myTabBar?.miniPlayer.pauseButton.setImage(UIImage(systemName: "play.fill", withConfiguration: config), for: .normal)
                NowPlayingViewController.player?.pause()
            }
        }
    }
    private var track: AudioTrack?
    private let imageSong: UIImageView = {
        let imageSong = UIImageView()
        imageSong.image = UIImage(named: "vinyl")
        imageSong.contentMode = .scaleToFill
        imageSong.layer.cornerRadius = 10
        imageSong.layer.masksToBounds = true
        imageSong.translatesAutoresizingMaskIntoConstraints = false
        return imageSong
    }()
    
    private let titleSong: UILabel = {
        let titleSong = UILabel()
        titleSong.text = "No track is playing"
        titleSong.font = .systemFont(ofSize: 25, weight: .bold)
        titleSong.textColor = .darkGray
        titleSong.numberOfLines = 0
        titleSong.textAlignment = .center
        titleSong.translatesAutoresizingMaskIntoConstraints = false
        return titleSong
    }()
    
    private let currentTimeSong: UILabel = {
        let currentTimeSong = UILabel()
        currentTimeSong.text = "00:00"
        currentTimeSong.font = .systemFont(ofSize: 15, weight: .medium)
        currentTimeSong.translatesAutoresizingMaskIntoConstraints = false
        return currentTimeSong
    }()
    
    private let durationSong: UILabel = {
        let durationSong = UILabel()
        durationSong.text = "00:00"
        durationSong.font = .systemFont(ofSize: 15, weight: .medium)
        durationSong.translatesAutoresizingMaskIntoConstraints = false
        return durationSong
    }()
    
    lazy var progressSongView: UISlider = {
        let progressSongView = UISlider()
        progressSongView.tintColor = UIColor(named: "lightBrown")
        // Устанавливаем получения события valueChanged только тогда, когда пользователь перестает перемещать ползунок
        progressSongView.isContinuous = false
        progressSongView.translatesAutoresizingMaskIntoConstraints = false
        // добавляем экшн слайдеру
        progressSongView.addTarget(self, action: #selector(progressSongViewAction), for: .valueChanged)
        return progressSongView
    }()
    
    @objc func progressSongViewAction(sender: UISlider!) {
        // устанавливаем текущее время песни в зависимости от значения слайдера
        NowPlayingViewController.player?.seek(to: CMTime(seconds: Double(sender.value), preferredTimescale: 1000))
    }
    
    lazy var backwardButton: UIButton = {
        let backwardButton = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .medium, scale: .default)
        backwardButton.setImage(UIImage(systemName: "backward.end", withConfiguration: config), for: .normal)
        backwardButton.tintColor = .black
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        backwardButton.addTarget(self, action: #selector(backwardButtonAction), for: .touchUpInside)
        return backwardButton
    }()
    
    lazy var playButton: UIButton = {
        let playButton = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 42, weight: .medium, scale: .default)
        playButton.setImage(UIImage(systemName: "play.circle", withConfiguration: config), for: .normal)
        playButton.tintColor = .black
        playButton.translatesAutoresizingMaskIntoConstraints = false
        // добавляем экшн кнопке
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        return playButton
    }()
    
    @objc func playButtonAction(sender: UIButton!) {
        
        if NowPlayingViewController.player?.timeControlStatus == .paused {
            playerStop = !playerStop
        } else {
            playerStop = !playerStop
        }
    }
    
    lazy var forwardButton: UIButton = {
        let forwardButton = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .medium, scale: .default)
        forwardButton.setImage(UIImage(systemName: "forward.end", withConfiguration: config), for: .normal)
        forwardButton.tintColor = .black
        forwardButton.translatesAutoresizingMaskIntoConstraints = false
        forwardButton.addTarget(self, action: #selector(forwardButtonAction), for: .touchUpInside)
        return forwardButton
    }()
    
    @objc func forwardButtonAction(sender: UIButton!) {
        
    }
    
    @objc func backwardButtonAction(sender: UIButton!) {
        // тут надо добавить переход на трек назад
    }
    
    //MARK: - Will appear method
    override func viewWillAppear(_ animated: Bool) {
        let myTabBar = tabBarController as? MainTabBarController
        myTabBar?.miniPlayer.view.isHidden = true
        myTabBar?.miniPlayer.artistLable.text = artistName
        myTabBar?.miniPlayer.trackLable.text = trackName
        myTabBar?.miniPlayer.imageAlbum.image = imageSong.image
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        let myTabBar = tabBarController as? MainTabBarController
        myTabBar?.miniPlayer.view.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "LightColour")
        view.addSubview(imageSong)
        view.addSubview(titleSong)
        view.addSubview(currentTimeSong)
        view.addSubview(durationSong)
        view.addSubview(progressSongView)
        view.addSubview(backwardButton)
        view.addSubview(playButton)
        view.addSubview(forwardButton)
        setupUI()
        //        playerConfiguration()
        //set()
    }
    
    // Декларируем аудиоплеер в общей области видимости
    static var player: AVPlayer?
    
    public func set(_ data: PlaylistDetailResponse, _ index: Int) {
        track = data.tracks.items[index].track
        
        if let trackName = track?.name, let artistName = track?.artists[0].name {
            titleSong.text = "\(trackName) - \(artistName)"
            self.trackName = trackName
            self.artistName = artistName
        }
        
        APICaller.shared.fetchImage(from: data.tracks.items[index].track.album?.images[0].url ?? data.images[0].url) { image in
            self.imageSong.image = image
        }
        
        if let url = URL(string: track?.preview_url ?? "") {
            NowPlayingViewController.player =  AVPlayer(url: url)
        }
        
        NowPlayingViewController.player?.play()
        playerStop = true
        
        if let durationSongSeconds = NowPlayingViewController.player?.currentItem?.asset.duration.seconds {
            durationSong.text = String(format: "-%02d:%02d", Int(durationSongSeconds) / 60, Int(durationSongSeconds) % 60)
            progressSongView.maximumValue = Float(durationSongSeconds)
        }
        
        NowPlayingViewController.player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 10), queue: DispatchQueue.main, using: { time in
            
            self.currentTimeSong.text = String(format: "%02d:%02d", Int(time.seconds) / 60, Int(time.seconds) % 60)
            if let durationSongSeconds = NowPlayingViewController.player?.currentItem?.asset.duration.seconds {
                self.durationSong.text = String(format: "-%02d:%02d", Int(durationSongSeconds - time.seconds) / 60, Int(durationSongSeconds - time.seconds) % 60)
            }
            self.progressSongView.value = Float(time.seconds)
            
            if let duration = NowPlayingViewController.player?.currentItem?.asset.duration {
                if time == duration {
                    NowPlayingViewController.player?.pause()
                    NowPlayingViewController.player?.seek(to: CMTime(seconds: 0, preferredTimescale: 1000))
                    self.currentTimeSong.text = "00:00"
                    self.progressSongView.value = 0
                }
            }
        })
    }
    
    public func set(_ data: AlbumDetailResponse, _ index: Int) {
        track = data.tracks.items[index]
        
        if let trackName = track?.name, let artistName = track?.artists[0].name {
            titleSong.text = "\(trackName) - \(artistName)"
            self.artistName = artistName
            self.trackName = trackName
        }
        
        APICaller.shared.fetchImage(from: data.tracks.items[index].album?.images[0].url ?? data.images[0].url) { image in
            self.imageSong.image = image
        }
        
        if let url = URL(string: track?.preview_url ?? "") {
            NowPlayingViewController.player =  AVPlayer(url: url)
        }
        
        NowPlayingViewController.player?.play()
        playerStop = true
        
        if let durationSongSeconds = NowPlayingViewController.player?.currentItem?.asset.duration.seconds {
            durationSong.text = String(format: "-%02d:%02d", Int(durationSongSeconds) / 60, Int(durationSongSeconds) % 60)
            progressSongView.maximumValue = Float(durationSongSeconds)
        }
        
        NowPlayingViewController.player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 10), queue: DispatchQueue.main, using: { time in
            
            self.currentTimeSong.text = String(format: "%02d:%02d", Int(time.seconds) / 60, Int(time.seconds) % 60)
            if let durationSongSeconds = NowPlayingViewController.player?.currentItem?.asset.duration.seconds {
                self.durationSong.text = String(format: "-%02d:%02d", Int(durationSongSeconds - time.seconds) / 60, Int(durationSongSeconds - time.seconds) % 60)
            }
            self.progressSongView.value = Float(time.seconds)
            
            if let duration = NowPlayingViewController.player?.currentItem?.asset.duration {
                if time == duration {
                    NowPlayingViewController.player?.pause()
                    NowPlayingViewController.player?.seek(to: CMTime(seconds: 0, preferredTimescale: 1000))
                    self.currentTimeSong.text = "00:00"
                    self.progressSongView.value = 0
                }
            }
        })
    }
    //    func playerConfiguration() {
    //
    //    }
    
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
