//
//  Song.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/8/25.
//

import Foundation

struct Song: Codable, Hashable {
    let title: String
    let artist: String
    let imageName: String
    let fileName: String
    var isSaved: Bool = false

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(artist)
    }
    
    static func == (lhs: Song, rhs: Song) -> Bool {
        return lhs.title == rhs.title && lhs.artist == rhs.artist
    }
}
