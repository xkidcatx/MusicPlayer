//
//  PlaylistDetailResponse.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 31.07.2022.
//

import Foundation

struct PlaylistDetailResponse: Codable {
    let description: String
    let external_urls: [String: String]
    let id: String
    let images: [APIImage]
    let name: String
    let tracks: PlaylistTrackResponse
}

struct PlaylistTrackResponse: Codable {
    let items: [PlaylistItem]
}

struct PlaylistItem: Codable {
    let track: AudioTrack
}
