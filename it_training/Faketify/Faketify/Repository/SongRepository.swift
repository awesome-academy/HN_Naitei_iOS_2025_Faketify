//
//  SongRepository.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/28/25.
//

import Foundation

final class SongRepository {
    static let shared = SongRepository()
    
    private init() {
        loadSavedSongs()
    }
    
    // Toàn bộ bài hát trong app
    private(set) var allSongs: [Song] = [
        // Featured
        Song(title: "Còn Gì Đẹp Hơn", artist: "Nguyễn Hùng", imageName: "Còn Gì Đẹp Hơn", fileName: "Còn Gì Đẹp Hơn"),
        Song(title: "Nỗi Đau Giữa Hoà Bình", artist: "Hoà Minzy", imageName: "Nỗi Đau Giữa Hoà Bình", fileName: "Nỗi Đau Giữa Hoà Bình"),
        Song(title: "Viết Tiếp Câu Chuyện Hoà Bình", artist: "Nguyễn Văn Chung, Nguyễn Duyên Quỳnh", imageName: "Viết Tiếp Câu Chuyện Hoà Bình", fileName: "Viết Tiếp Câu Chuyện Hoà Bình"),
        Song(title: "Việt Nam Tôi", artist: "Jack, K-ICM", imageName: "Việt Nam Tôi", fileName: "Việt Nam Tôi"),
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
    
    private let storage = LocalStorageService.shared
        
        var savedSongs: [Song] {
            return allSongs.filter { $0.isSaved }
        }
        
        func toggleSave(song: Song) {
            if let index = allSongs.firstIndex(where: { $0.title == song.title && $0.artist == song.artist }) {
                allSongs[index].isSaved.toggle()
                saveSongs()
                NotificationCenter.default.post(name: .didUpdateSavedSongs, object: nil)
            }
        }
        
        func isSaved(song: Song) -> Bool {
            return savedSongs.contains { $0.title == song.title && $0.artist == song.artist }
        }
        
        private func saveSongs() {
            let saved = allSongs
                .filter { $0.isSaved }
                .map { "\($0.title)|\($0.artist)" }
            storage.set(saved, forKey: .savedSongs)
        }
        
        private func loadSavedSongs() {
            let saved = storage.array(forKey: .savedSongs) as? [String] ?? []
            for i in 0..<allSongs.count {
                let key = "\(allSongs[i].title)|\(allSongs[i].artist)"
                if saved.contains(key) {
                    allSongs[i].isSaved = true
                }
            }
        }
    }

extension Notification.Name {
    static let didUpdateSavedSongs = Notification.Name("didUpdateSavedSongs")
}
