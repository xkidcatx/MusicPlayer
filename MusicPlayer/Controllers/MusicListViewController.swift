//
//  MusicListViewController.swift
//  MusicPlayer
//
//  Created by Eugene Kotovich on 07.07.2022.
//

import UIKit

class MusicListViewController: UIViewController {
    
    var playlists = [Playlist]()
    
    public var selectionHandler: ((Playlist) -> Void)?
    
    private let noPlaylistsView = ActionView()
    
    private let tableView: UITableView = {
        $0.register(PlaylistSubtitleTableViewCell.self, forCellReuseIdentifier: PlaylistSubtitleTableViewCell.identifier)
        $0.backgroundColor = UIColor(named: "LightColour")
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UITableView(frame: .zero, style: .grouped))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "LightColour")
        setupNoPlaylistsView()
        updateBarButtons()
        setConstraints()
        
        noPlaylistsView.isHidden = false
        fetchData()
        
        if selectionHandler != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        }
        
    }
    
    private func setupNoPlaylistsView() {
        view.addSubview(noPlaylistsView)
        view.addSubview(tableView)
        noPlaylistsView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        noPlaylistsView.configure(with: ActionLabelViewViewModel(text: "You don't have any playlists yet.", actionTitle: "Create"))
        
    }
    
    private func updateBarButtons() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    private func fetchData() {
        APICaller.shared.getCurrentUserPlaylists { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlists):
                    self?.playlists = playlists
                    self?.updateUI()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func updateUI() {
        if playlists.isEmpty {
            //Show label
            noPlaylistsView.isHidden = false
            tableView.isHidden = true
        } else {
            //Show table
            tableView.reloadData()
            tableView.isHidden = false
            noPlaylistsView.isHidden = true
        }
    }
    
    public func showCreatePlaylistAlert() {
        let alert = UIAlertController(title: "New Playlist", message: "Enter playlist name", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Example: Metal"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Create", style: .default, handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                return
            }
            
            APICaller.shared.createPlaylist(with: text) { [weak self] success in
                if success {
                    self?.fetchData()
                } else {
                    print("Failed to create playlist")
                }
            }
        }))
        
        present(alert, animated: true)
    }
    
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func didTapAdd() {
        showCreatePlaylistAlert()
    }
    
}

//MARK: - ActionViewDelegate Method

extension MusicListViewController: ActionViewDelegate {
    func actionViewDidTapButton(_ actionView: ActionView) {
        showCreatePlaylistAlert()
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource Methods

extension MusicListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaylistSubtitleTableViewCell.identifier, for: indexPath) as? PlaylistSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let playlist = playlists[indexPath.row]
        cell.configure(with: PlaylistSubtitleTableViewCellViewModel(title: playlist.name,
                                                                    subtitle: playlist.owner.display_name,
                                                                    imageURL: URL(string: playlist.images.first?.url ?? "")))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let playlist = playlists[indexPath.row]
        guard selectionHandler == nil else {
            selectionHandler?(playlist)
            dismiss(animated: true, completion: nil)
            return
        }
        
        let vc = PlaylistDetailViewController(playlist: playlist)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}

//MARK: - Set Constraints

extension MusicListViewController {
    
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            noPlaylistsView.widthAnchor.constraint(equalToConstant: 150),
            noPlaylistsView.heightAnchor.constraint(equalToConstant: 150),
            noPlaylistsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noPlaylistsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70)
        ])
        
    }
}



