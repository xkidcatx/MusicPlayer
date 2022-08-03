//
//  MusicListViewController.swift
//  MusicPlayer
//
//  Created by Gleb Glushok on 06.07.2022.
//

import UIKit

class MusicListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Регистрируем UITableViewCell для его использования при создании новых ячеек в MusicListViewController
        tableView.register(MusicListCell.self, forCellReuseIdentifier: "MusicListCell")

        
        view.backgroundColor = UIColor(named: "LightColour")
    }
    
    // устанавливаем кол-во строк в таблице
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    // устанавливаем ячейку которая будет использоваться в табличке
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // создаем нашу ячейку MusicListCell что будет использоваться в таблице
        let cell = tableView.dequeueReusableCell(withIdentifier: MusicListCell.identifier, for: indexPath) as! MusicListCell
        
        // убираем выделение ячейки при выборе
        cell.selectionStyle = .none
        return cell
    }
    
    // Высота ячейки
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

