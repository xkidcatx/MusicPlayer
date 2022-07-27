//
//  Playlist.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 27.07.2022.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
}
