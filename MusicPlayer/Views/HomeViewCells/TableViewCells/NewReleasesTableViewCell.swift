//
//  NewReleasesTableViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 09.07.2022.
//

import UIKit

class NewReleasesTableViewCell: UITableViewCell {
    
    static let identifire = "NewReleasesTableViewCell"
    private let imageCache = NSCache<NSString, UIImage>()
    private let albumCache = NSCache<NSString, NSString>()
    private let artistCache = NSCache<NSString, NSString>()
    
    public var navigationController: UINavigationController?
    
    var newReleases: NewReleasesResponse? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(NewReleasesCollectionViewCell.self, forCellWithReuseIdentifier: NewReleasesCollectionViewCell.identifire)
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
        collectionView.frame = contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: NewReleasesResponse) {
        self.newReleases = model
    }
}

extension NewReleasesTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let album = newReleases?.albums.items[indexPath.row] else { return }
        let vc = AlbumDetailViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newReleases?.albums.items.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width / 2 - 10, height: contentView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewReleasesCollectionViewCell.identifire, for: indexPath) as? NewReleasesCollectionViewCell else { return UICollectionViewCell() }
        if let data = newReleases {
            let album = data.albums.items[indexPath.row]
            APICaller.shared.fetchImage(from: album.images[0].url) { image in
                cell.setupData(image: image, title: album.name, subTitle: album.artists[0].name)
            }
        }
        return cell
    }
}
