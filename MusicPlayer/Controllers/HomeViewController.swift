//
//  ViewController.swift
//  MusicPlayer
//
//  Created by Gleb on 05.07.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let sectionTitles = ["New Release", "Recommendations", "Top rated", "Lates", "Upcomming"]
    
    var newReleases: NewReleasesResponse?
    var recommendations: RecommendationsResponse?
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(NewReleasesTableViewCell.self, forCellReuseIdentifier: NewReleasesTableViewCell.identifire)
        table.register(RecommendationsTableViewCell.self, forCellReuseIdentifier: RecommendationsTableViewCell.identifire)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.systemBackground.cgColor,
            UIColor.systemGray.cgColor,
            UIColor.systemBackground.cgColor,
        ]
        view.layer.addSublayer(gradientLayer)
        createTable()
        fetchData()
        fetchRecommendationsData()
    }
    
    private func fetchData() {
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
        tableView.frame = view.bounds
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
        return 2
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
        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: RecommendationsTableViewCell.identifire, for: indexPath) as? RecommendationsTableViewCell else { return UITableViewCell() }
            if let data = recommendations {
                cell.configure(with: data)
            }
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NewReleasesTableViewCell.identifire, for: indexPath) as? NewReleasesTableViewCell else { return UITableViewCell() }
            if let data = newReleases {
                cell.configure(with: data)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 220
        case 1:
            return 260
        default:
            return 220
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
