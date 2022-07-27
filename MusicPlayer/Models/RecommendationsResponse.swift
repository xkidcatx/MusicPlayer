//
//  RecommendationsResponse.swift
//  MusicPlayer
//
//  Created by Даниил Симахин on 25.07.2022.
//

import Foundation

struct RecommendationsResponse: Codable {
    let tracks: [AudioTrack]
}
