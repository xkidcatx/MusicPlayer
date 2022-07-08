//
//  MusicListCell.swift
//  MusicPlayer
//
//  Created on 08.07.2022.
//

import UIKit

class MusicListCell: UITableViewCell {
    
    // Задаем идентификатор нашей ячейки (MusicListCell)
    static let identifier = "MusicListCell"
    
    // Создаем один из UI-элементов внутри нашей ячейки
    let mainLabel = UILabel()
    
    // Инициализируем нашу ячейку. Далее конфигурируем UI-элемент и добавляем его в ячейку
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(mainLabel)
        configureLayout()
        configureView()
    }
    
    // Этот инициализатор будет вызван, если MusicListCell будет вызван из storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Настраиваем констрейнты нашего UI-элемента
    private func configureLayout() {
        // Отключаем автоматическое добавление констрейнтов
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Добавляем констрейнты нашему UI-элементу
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            mainLabel.widthAnchor.constraint(equalToConstant: 120),
            mainLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // Настраиваем свойства UI-элемент
    private func configureView() {
        mainLabel.text = "music_name"
        mainLabel.backgroundColor = .blue
        mainLabel.textColor = .white
    }
}
