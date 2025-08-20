//
//  Playlist.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/19/25.
//

import Foundation

struct Playlist: Codable {
    let description: String
    let external_urls: [String : String]
    let id: String
    let images: [APIImage]
    let name: String
    let owner: User
}
