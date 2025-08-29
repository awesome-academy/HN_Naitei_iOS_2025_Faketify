//
//  SongRepository.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/28/25.
//

import Foundation

final class SongRepository {
    static let shared = SongRepository()
    
    private init() {}
    
    // Toàn bộ bài hát trong app
    let allSongs: [Song] = [
        // Featured
        Song(title: "Síguelo", artist: "Wisin & Yandel", imageName: "siguelocover", fileName: "Síguelo"),
        Song(title: "Hold Me Close", artist: "Flux Pavilion", imageName: "holdmeclose", fileName: "Hold Me Close"),
        Song(title: "Good Looking", artist: "Don Omar", imageName: "goodlooking", fileName: "Good Looking"),
        Song(title: "Start Me Up - Remastered", artist: "The Rolling Stones", imageName: "startmeup", fileName: "Start Me Up"),
        Song(title: "Oh, Pretty Woman", artist: "Roy Orbison", imageName: "prettwoman", fileName: "Oh, Pretty Woman"),
        Song(title: "Mother Knows Best", artist: "Donna Murphy", imageName: "motherknowsbest", fileName: "Mother Knows Best"),
        
        // Songs
        Song(title: "Just Around The Riverbend", artist: "Judy Kuhn", imageName: "riverbend", fileName: "Just Around The Riverbend"),
        Song(title: "Right In", artist: "Skrillex", imageName: "rightin", fileName: "Right In"),
        Song(title: "This Land", artist: "Hans Zimmer", imageName: "thisland", fileName: "This Land"),
        Song(title: "Ải Hồng Nhan", artist: "DungHoangPham", imageName: "aihongnhan", fileName: "Ải Hồng Nhan"),
        Song(title: "Kamado Tanjiro No Uta", artist: "Go Shiina, Nami Nakagawa", imageName: "Kamado Tanjiro No Uta", fileName: "Kamado Tanjiro No Uta"),
        Song(title: "Nợ Nhau Một Lời", artist: "Phuc Chinh", imageName: "Nợ Nhau Một Lời", fileName: "Nợ Nhau Một Lời"),
        Song(title: "Phép Màu", artist: "MayDays, Minh Tốc & Lam", imageName: "Phép Màu", fileName: "Phép Màu"),
        Song(title: "lời tạm biệt chưa nói", artist: "GreyD, Orange, Kai Đinh", imageName: "lời tạm biệt chưa nói", fileName: "lời tạm biệt chưa nói")
    ]
}
