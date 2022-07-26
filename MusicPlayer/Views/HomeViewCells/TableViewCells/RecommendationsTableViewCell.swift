//
//  RecommendationsTableViewCell.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 26.07.2022.
//

import UIKit

class RecommendationsTableViewCell: UITableViewCell {
    
    static let identifire = "RecommendationsTableViewCell"
    public var navigationController: UINavigationController?
    
    var recommendations: RecommendationsResponse? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
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
        collectionView.backgroundColor = UIColor(named: "LightColour")
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let album = recommendations?.tracks[indexPath.row].album else { return }
        let vc = AlbumDetailViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
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
            APICaller.shared.fetchImage(from: track.album?.images[0].url ?? "") { image in
                cell.setupData(image: image, title: track.name, subTitle: track.artists[0].name)
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
