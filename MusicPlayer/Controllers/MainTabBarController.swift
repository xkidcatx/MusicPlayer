//
//  MainTabBarController.swift
//  MusicPlayer
//
//  Created by Eugene Kotovich on 07.07.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let miniPlayer: MiniPlayerViewController = {
        $0.view.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(MiniPlayerViewController())
    
    private let containerView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private let bottomView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupItems()
        addChildView()
        setBottomView()
        setConstraints()
        miniPlayer.delegate = self
    }
    
    
    private func setupTabBar() {
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: self.tabBar.bounds.minY - 20, width: self.tabBar.bounds.width - 0, height: self.tabBar.bounds.height + 40), cornerRadius: (self.tabBar.frame.width/2)).cgPath
        layer.shadowColor = .none
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.0
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor(named: "DarkColour")?.cgColor //.black.cgColor
        
        self.tabBar.layer.insertSublayer(layer, at: 0)
        
        
        if let items = self.tabBar.items {
            items.forEach { item in item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0) }
        }
        
        self.tabBar.itemWidth = 30.0
        self.tabBar.itemPositioning = .fill

        let app = UITabBarAppearance()
        app.backgroundEffect = .none
        app.shadowColor = .clear
        tabBar.standardAppearance = app
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
        
        tabBar.unselectedItemTintColor = UIColor(named: "MiddleColour")
        tabBar.tintColor = UIColor(named: "LightColour")
        
        
        if let childIndex = viewControllers?.firstIndex(of: miniPlayer) {
            viewControllers?.remove(at: childIndex)
        }

    }
    
    func addChildView() {
        view.insertSubview(containerView, at: 1)
        view.insertSubview(bottomView, at: 2)
        //view.addSubview(containerView)
        addChild(miniPlayer)
        containerView.addSubview(miniPlayer.view)
        miniPlayer.didMove(toParent: self)
        tabBar.sendSubviewToBack(containerView)
    }
}

extension MainTabBarController {
    
    private func setConstraints() {
        
        let g = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: g.leadingAnchor, constant: 0),
            containerView.trailingAnchor.constraint(equalTo: g.trailingAnchor, constant: 0),
            containerView.bottomAnchor.constraint(equalTo: bottomView.topAnchor, constant: +20),
            containerView.heightAnchor.constraint(equalToConstant: 140),
            
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

extension MainTabBarController {
    private func setBottomView() {
        bottomView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: +25).isActive = true
        bottomView.backgroundColor = UIColor(named: "DarkColour")
    }
}
