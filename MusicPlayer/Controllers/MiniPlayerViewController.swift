//
//  MiniPlayerViewController.swift
//  MusicPlayer
//
//  Created by Eugene Kotovich on 27.07.2022.
//

import UIKit

protocol MiniPlayerDelegate {
    func presentPlayerView()
}

class MiniPlayerViewController: UIViewController {
    
    var delegate: MiniPlayerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .brown
        
        // add a tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
    }
    
    @objc func tapDetected() {
        guard let delegate = delegate else { return }
        delegate.presentPlayerView()
    }
}
