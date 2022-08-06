//
//  WelcomeViewController.swift
//  MusicPlayer
//
//  Created by Eugene Kotovich on 18.07.2022.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        $0.image = UIImage(named: "Watermellon Music App Icon")
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    lazy var signInButton: UIButton = {
        $0.backgroundColor = UIColor(named: "lightBrown")
        $0.setTitle("Sign in with Spotify", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 20)
        $0.layer.cornerRadius = 15
        $0.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton())

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Watermellon"
        view.backgroundColor = UIColor(named: "LightColour")
        setupViews()
        setConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    private func setupViews() {
        view.addSubview(signInButton)
        view.addSubview(logoImageView)
    }
    
    @objc func didTapSignIn() {
        let vc = AuthViewController()
        vc.completionHandler = { [weak self] success in
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func handleSignIn(success: Bool) {
        // Log user in of yell at them for error
        guard success else {
            let alert = UIAlertController(title: "Oops", message: "Something went wrong when signing in.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true)
            return
        }
        
        let mainAppTabBarVc = MainTabBarController()
        mainAppTabBarVc.modalPresentationStyle = .fullScreen
        present(mainAppTabBarVc, animated: true )
    }
}

extension WelcomeViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
