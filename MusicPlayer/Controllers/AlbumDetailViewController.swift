//
//  AlbumDetailViewController.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 29.07.2022.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    private let album: Album
    private var albumDetail: AlbumDetailResponse?
    
    lazy private var tableView: UITableView = UITableView()
    
    init(album: Album) {
        self.album = album
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTableView()
        setup()
        createGradient()
        setupUI()
        APICaller.shared.getAlbumDetail(with: album) { result in
            switch result {
            case .success(let model):
                self.albumDetail = model
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case .failure(let error):
                print("Error with get album detail data, \(error)")
                break
            }
        }
    }
    
    private func recommendationsCellDelegate(index: Int) {
        let vc = NowPlayingViewController()
        let data = albumDetail?.tracks.items[index]
        vc.set(data)
        tabBarController?.selectedIndex = 1
    }
    
    private func createTableView() {
        tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: AlbumTableViewCell.identifire)
        tableView.register(AlbumHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: AlbumHeaderFooterView.identifire)
        tableView.backgroundColor = .systemBackground
        tableView.layoutMargins = .zero
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.width, height: view.bounds.height - 129)
        tableView.frame = size
    }
    
    private func setupUI() {
        view.addSubview(tableView)
    }
    
    private func setup() {
        title = album.name
        view.backgroundColor = .systemBackground
    }
    
    private func createGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.systemGray.cgColor,
            UIColor.systemBackground.cgColor,
        ]
        view.layer.addSublayer(gradientLayer)
    }
}

extension AlbumDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumDetail?.tracks.items.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumTableViewCell.identifire, for: indexPath) as! AlbumTableViewCell? else { return UITableViewCell() }
        guard let track = albumDetail?.tracks.items[indexPath.row] else { return cell}
        cell.title.text = track.name
        cell.subTitle.text = track.artists[0].name
        let minuts = Int(Double(track.duration_ms) / 1000.0 / 60)
        let seconds = Int(round(Double(track.duration_ms) / 1000)) - minuts * 60
        cell.timeLabel.text = seconds < 10 ? "\(minuts):0\(seconds)" : "\(minuts):\(seconds)"
        APICaller.shared.fetchImage(from: albumDetail?.images[0].url ?? "") { data in
            if let data = data {
                cell.spinner.stopAnimating()
                cell.imageview.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AlbumHeaderFooterView.identifire) as? AlbumHeaderFooterView else { return UITableViewHeaderFooterView() }
        header.title.text = albumDetail?.name
        header.subTitle.text = albumDetail?.artists[0].name
        APICaller.shared.fetchImage(from: albumDetail?.images[0].url ?? "", completionHandler: { data in
            if let data = data {
                header.spinner.stopAnimating()
                header.imageView.image = UIImage(data: data)
            }
        })
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 275
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        recommendationsCellDelegate(index: indexPath.row)
    }
}
