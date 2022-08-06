//
//  ActionView.swift
//  MusicPlayer
//
//  Created by Eugene Kotovich on 05.08.2022.
//

import UIKit

struct ActionLabelViewViewModel {
    let text: String
    let actionTitle: String
}

protocol ActionViewDelegate: AnyObject {
    func actionViewDidTapButton(_ actionView: ActionView)
}

class ActionView: UIView {
    
    weak var delegate: ActionViewDelegate?
    
    private let label: UILabel = {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 20)
        $0.numberOfLines = 0
        $0.textColor = .secondaryLabel
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var button: UIButton = {
        $0.setTitleColor(.link, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 20)
        $0.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIButton(type: .system))

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        isHidden = true
        addSubview(label)
        addSubview(button)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func didTapButton() {
        delegate?.actionViewDidTapButton(self)
    }
    
    func configure(with viewModel: ActionLabelViewViewModel) {
        label.text = viewModel.text
        button.setTitle(viewModel.actionTitle, for: .normal)
    }
}

extension ActionView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            button.widthAnchor.constraint(equalTo: widthAnchor),
            button.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
