//
//  Artist.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 22.07.2022.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let external_urls: [String: String]
    let href: String
    let uri: String
}
