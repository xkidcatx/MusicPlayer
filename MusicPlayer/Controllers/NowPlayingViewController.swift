//
//  NowPlayingViewController.swift
//  MusicPlayer
//
//  Created by Gleb Glushok on 06.07.2022.
//

import UIKit
import AVFoundation

class NowPlayingViewController: UIViewController {
    
    private var playerStop = true
    
    private let imageSong: UIImageView = {
        let imageSong = UIImageView()
        imageSong.image = UIImage(named: "Lightwire - City of Dreams")
        imageSong.contentMode = .scaleToFill
        imageSong.layer.cornerRadius = 10
        imageSong.layer.masksToBounds = true
        imageSong.translatesAutoresizingMaskIntoConstraints = false
        return imageSong
    }()
    
    private let titleSong: UILabel = {
        let titleSong = UILabel()
        titleSong.text = "Lightwire - City of Dreams"
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
        // Устанавливаем получения события valueChanged только тогда, когда пользователь перестает перемещать ползунок
        progressSongView.isContinuous = false
        progressSongView.translatesAutoresizingMaskIntoConstraints = false
        // добавляем экшн слайдеру
        progressSongView.addTarget(self, action: #selector(progressSongViewAction), for: .valueChanged)
        return progressSongView
    }()
    
    @objc func progressSongViewAction(sender: UISlider!) {
        // устанавливаем текущее время песни в зависимости от значения слайдера
        player?.seek(to: CMTime(seconds: Double(sender.value), preferredTimescale: 1000))
    }
    
    private let backwardButton: UIButton = {
        let backwardButton = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 50, weight: .medium, scale: .default)
        backwardButton.setImage(UIImage(systemName: "backward.end", withConfiguration: config), for: .normal)
        backwardButton.translatesAutoresizingMaskIntoConstraints = false
        return backwardButton
    }()
    
    lazy var playButton: UIButton = {
        let playButton = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 42, weight: .medium, scale: .default)
        playButton.setImage(UIImage(systemName: "play.circle", withConfiguration: config), for: .normal)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        // добавляем экшн кнопке
        playButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        return playButton
    }()
    
    @objc func buttonAction(sender: UIButton!) {
        let config = UIImage.SymbolConfiguration(pointSize: 42, weight: .medium, scale: .default)
        // включаем/отключаем вопсроизведение песни и меняем изображение на кнопке
        if player?.timeControlStatus == .paused {
            playButton.setImage(UIImage(systemName: "pause.circle", withConfiguration: config), for: .normal)
            player?.play()
            playerStop = !playerStop
        } else {
            playButton.setImage(UIImage(systemName: "play.circle", withConfiguration: config), for: .normal)
            player?.pause()
            playerStop = !playerStop
        }
    }
    
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
        playerConfiguration()
    }
    
    // Декларируем аудиоплеер в общей области видимости
    var player: AVPlayer?

    func playerConfiguration() {
        // создаем плеер с конкретной песней
        if let url = Bundle.main.url(forResource: "Lightwire - City of Dreams", withExtension: "mp3") {
            do {
                player = try AVPlayer(url: url)
            } catch {
                print(error.localizedDescription)
            }
        }
        
        if let durationSongSeconds = player?.currentItem?.asset.duration.seconds {
            // отображаем длительность песни
            durationSong.text = String(format: "%02d:%02d", Int(durationSongSeconds) / 60, Int(durationSongSeconds) % 60)
            // устанавливаем границы слайдеру в зависимости от длительности песни
            progressSongView.maximumValue = Float(durationSongSeconds)
        }
        
        // addPeriodicTimeObserver - переодические выполняется замыкание в котором обновляем текущее время песни и слайдер
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 10), queue: DispatchQueue.main, using: { time in
                self.currentTimeSong.text = String(format: "%02d:%02d", Int(time.seconds) / 60, Int(time.seconds) % 60)
                self.progressSongView.value = Float(time.seconds)
            // устанавливаем обнуляем время, слайдер когда песня закончилась
            if let duration = self.player?.currentItem?.asset.duration {
//                print(Int(duration.seconds))
//                print(Int(time.seconds))
                if time == duration {
                    self.player?.pause()
                    self.player?.seek(to: CMTime(seconds: 0, preferredTimescale: 1000))
                    self.currentTimeSong.text = "00:00"
                    self.progressSongView.value = 0
                }
            }
        })
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
