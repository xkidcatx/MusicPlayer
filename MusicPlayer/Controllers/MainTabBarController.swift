//
//  MainTabBarController.swift
//  MusicPlayer
//
//  Created by Eugene Kotovich on 07.07.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let miniPlayer: MiniPlayerViewController = {
        $0.view.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(MiniPlayerViewController())
    
    private let containerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupItems()
        addChildView()
        setConstraints()
        miniPlayer.delegate = self
    }
    
    
    private func setupTabBar() {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 2, y: self.tabBar.bounds.minY - 20, width: self.tabBar.bounds.width - 4, height: self.tabBar.bounds.height + 40), cornerRadius: (self.tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.black.cgColor
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        
        
        if let items = self.tabBar.items {
            items.forEach { item in item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0) }
        }
        
        self.tabBar.itemWidth = 30.0
        self.tabBar.itemPositioning = .fill
    }
    
    private func setupItems() {
        let homeVC = HomeViewController()
        let nowPlayingVC = NowPlayingViewController()
        let musicListVC = MusicListViewController()
        let profileVC = ProfileViewController()
        
        homeVC.title = "Home"
        nowPlayingVC.title = "Now Playing"
        musicListVC.title = "Music List"
        profileVC.title = "Profile"
        
        
        homeVC.navigationItem.largeTitleDisplayMode = .always
        nowPlayingVC.navigationItem.largeTitleDisplayMode = .always
        musicListVC.navigationItem.largeTitleDisplayMode = .always
        profileVC.navigationItem.largeTitleDisplayMode = .always
        
        let nav1 = UINavigationController(rootViewController: homeVC)
        let nav2 = UINavigationController(rootViewController: nowPlayingVC)
        let nav3 = UINavigationController(rootViewController: musicListVC)
        let nav4 = UINavigationController(rootViewController: profileVC)
        
        nav1.tabBarItem.image = UIImage(systemName: "house")
        nav2.tabBarItem.image = UIImage(systemName: "play.circle")
        nav3.tabBarItem.image = UIImage(systemName: "music.note.list")
        nav4.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        nav3.navigationBar.prefersLargeTitles = true
        nav4.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1,nav2,nav3,nav4,miniPlayer], animated: true)
        
        tabBar.tintColor = .systemBackground
        tabBar.unselectedItemTintColor = .darkGray
        
        if let childIndex = viewControllers?.firstIndex(of: miniPlayer) {
            viewControllers?.remove(at: childIndex)
        }
        
    }
    
    func addChildView() {
        view.addSubview(containerView)
        addChild(miniPlayer)
        containerView.addSubview(miniPlayer.view)
        miniPlayer.didMove(toParent: self)
    }
}

extension MainTabBarController {
    
    private func setConstraints() {
        
        let g = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 35),
            containerView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: -35),
            containerView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 64),
            
            miniPlayer.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            miniPlayer.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            miniPlayer.view.topAnchor.constraint(equalTo: containerView.topAnchor),
            miniPlayer.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}

extension MainTabBarController: MiniPlayerDelegate {
    func presentPlayerView() {
        let vc = NowPlayingViewController()
        vc.modalPresentationStyle = .formSheet
        present(vc, animated: true)
    }
}
