//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Gleb on 05.07.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles = ["New Release", "Featured Playlists", "Recommendations"]
    
    var newReleases: NewReleasesResponse?
    var recommendations: RecommendationsResponse?
    var featuredPlaylists: FeaturedPlaylistsResponse?
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(NewReleasesTableViewCell.self,
                       forCellReuseIdentifier: NewReleasesTableViewCell.identifire)
        table.register(RecommendationsTableViewCell.self,
                       forCellReuseIdentifier: RecommendationsTableViewCell.identifire)
        table.register(FeaturedPlaylistsTableViewCell.self,
                       forCellReuseIdentifier: FeaturedPlaylistsTableViewCell.identifire)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(named: "LightColour")
        createGradient()
        createTable()
        fetchNewReleasesData()
        fetchRecommendationsData()
        fetchFeaturedPlaylistsData()
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
    
    private func fetchFeaturedPlaylistsData() {
        APICaller.shared.getFeaturedPlaylist { result in
            switch result {
            case .success(let model):
                self.featuredPlaylists = model
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case .failure(let error):
                print("Error with fetch data for get featured playlists, \(error)")
                break
            }
        }
    }
    
    private func fetchNewReleasesData() {
        APICaller.shared.getNewReleases { result in
            switch result {
            case .success(let model):
                self.newReleases = model
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                break
            case .failure(let error):
                print("Error with fetch data for get new releases, \(error)")
                break
            }
        }
    }
    
    private func fetchRecommendationsData() {
        APICaller.shared.getRecommendedGenres(competion: { result in
            switch result {
            case .success(let model):
                let genred = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let randomElement = genred.randomElement() {
                        seeds.insert(randomElement)
                    }
                }
                APICaller.shared.getRecommendations(genres: seeds) { res in
                    switch res {
                    case .success(let model):
                        self.recommendations = model
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        break
                    case .failure(let error):
                        print("Error with fetch data for recommendations, \(error)")
                    }
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = CGRect(x: view.bounds.origin.x, y: view.bounds.origin.y, width: view.bounds.width, height: view.bounds.height - 129)
        tableView.frame = size
    }
    
    func createTable() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        
        tableView.layoutMargins = .zero
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewReleasesTableViewCell.identifire, for: indexPath) as? NewReleasesTableViewCell else { return UITableViewCell() }
            if let data = newReleases {
                cell.configure(with: data)
                cell.navigationController = self.navigationController
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FeaturedPlaylistsTableViewCell.identifire, for: indexPath) as? FeaturedPlaylistsTableViewCell else { return UITableViewCell() }
            if let data = featuredPlaylists {
                cell.configure(with: data)
                cell.navigationController = self.navigationController
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationsTableViewCell.identifire, for: indexPath) as? RecommendationsTableViewCell else { return UITableViewCell() }
            if let data = recommendations {
                cell.configure(with: data)
                cell.navigationController = self.navigationController
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return view.frame.width / 2
        case 1:
            return view.frame.width
        case 2:
            return 380
        default:
            return 220
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
