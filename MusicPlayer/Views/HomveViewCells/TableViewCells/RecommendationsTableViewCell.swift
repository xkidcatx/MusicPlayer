//
//  RecommendationsTableViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 26.07.2022.
//

import UIKit

class RecommendationsTableViewCell: UITableViewCell {
    
    static let identifire = "RecommendationsTableViewCell"
    private let imageCache = NSCache<NSString, UIImage>()
    private let songCache = NSCache<NSString, NSString>()
    private let artistCache = NSCache<NSString, NSString>()
    
    var recommendations: RecommendationsResponse? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(RecommendationsCollectionViewCell.self, forCellWithReuseIdentifier: RecommendationsCollectionViewCell.identifire)
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
    
    func configure(with model: RecommendationsResponse) {
        self.recommendations = model
    }
}

extension RecommendationsTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendations?.tracks.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.frame.width, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationsCollectionViewCell.identifire, for: indexPath) as? RecommendationsCollectionViewCell else { return UICollectionViewCell() }
        if let data = recommendations {
            let track = data.tracks[indexPath.row]
            fetchImage(from: track.album.images[0].url) { imageData in
                if let image = imageData {
                    cell.title.text = track.name
                    cell.subtitle.text = track.artists[0].name
                    cell.imageView.image = UIImage(data: image)
                } else {
                    print("Error loading image");
                }
            }
        }
        return cell
    }
    
    func fetchImage(from urlString: String, completionHandler: @escaping (_ data: Data?) -> ()) {
        let session = URLSession.shared
        let url = URL(string: urlString)
        
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("Error fetching the image!")
                completionHandler(nil)
            } else {
                DispatchQueue.main.async {
                    completionHandler(data)
                }
            }
        }
        dataTask.resume()
    }
}
