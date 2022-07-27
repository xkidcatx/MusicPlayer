//
//  User.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 27.07.2022.
//

import Foundation

struct User: Codable {
    let display_name: String
    let external_urls: [String: String]
    let id: String
}
