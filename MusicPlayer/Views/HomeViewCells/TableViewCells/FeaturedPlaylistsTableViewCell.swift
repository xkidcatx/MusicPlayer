//
//  FeaturedPlaylistsTableViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 27.07.2022.
//

import UIKit

class FeaturedPlaylistsTableViewCell: UITableViewCell {
    
    static let identifire = "FeaturedPlaylistsTableViewCell"
    public var navigationController: UINavigationController?
    
    var featuredPlaylists: FeaturedPlaylistsResponse? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(FeaturedPlaylistsCollectionViewCell.self, forCellWithReuseIdentifier: FeaturedPlaylistsCollectionViewCell.identifire)
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: FeaturedPlaylistsResponse) {
        self.featuredPlaylists = model
    }
}

extension FeaturedPlaylistsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let playlist = featuredPlaylists?.playlists.items[indexPath.row] else { return }
        let vc = PlaylistDetailViewController(playlist: playlist)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuredPlaylists?.playlists.items.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width, height: contentView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedPlaylistsCollectionViewCell.identifire, for: indexPath) as? FeaturedPlaylistsCollectionViewCell else { return UICollectionViewCell() }
        if let data = featuredPlaylists?.playlists {
            let playlist = data.items[indexPath.row]
            APICaller.shared.fetchImage(from: playlist.images[0].url) { image in
                cell.setupData(image: image, title: "", subTitle: "")
            }
        }
        return cell
    }
}
