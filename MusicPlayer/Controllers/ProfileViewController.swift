//
//  ProfileViewController.swift
//  MusicPlayer
//
//  Created by Eugene Kotovich on 07.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private let headerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let imageView: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    private let tableView: UITableView = {
        $0.isHidden = true
        $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView())
    
    private var models = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProfile()
        setDelegates()
        setupViews()
        setConstraints()
    }
    
    private func fetchProfile() {
        APICaller.shared.getCurrentUserProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self?.updateUI(with: model)
                case .failure(let error):
                    print("Profile Error: \(error.localizedDescription)")
                    self?.failedToGetProfile()
                }
            }
        }
    }
   
    private func updateUI(with model: UserProfile) {
        tableView.isHidden = false
        //configure table models
        models.append("Full Name: \(model.display_name)")
        models.append("Email Address: \(model.email)")
        models.append("User ID: \(model.id)")
        models.append("Plan: \(model.product)")
        fetchImage(with: model.images.first?.url)
        tableView.reloadData()
    }
    
    
    
    private func fetchImage(with string: String?) {
        guard let urlString = string, let url = URL(string: urlString) else {
            return
        }

        imageView.downloaded(from: url)
    }
    
    private func failedToGetProfile() {
        let label: UILabel = {
            $0.text = "Failed to load profile."
            $0.sizeToFit()
            $0.textColor = .secondaryLabel
            return $0
        }(UILabel())
        
        view.addSubview(label)
        
        label.center = view.center
    }
    
    private func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        title = "Profile"
        view.addSubview(tableView)
        view.addSubview(imageView)
        tableView.tableHeaderView = headerView
    }
}

//MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
}

//MARK: - Set Constraints

extension ProfileViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: view.widthAnchor),
            headerView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.8),
            imageView.widthAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.8)
        ])
    }
}
