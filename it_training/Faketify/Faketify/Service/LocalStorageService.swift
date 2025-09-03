//
//  LocalStorageService.swift
//  Faketify
//
//  Created by Nguyen Duc on 9/3/25.
//

import Foundation

final class LocalStorageService {
    static let shared = LocalStorageService()
    private init() {}
    
    enum Key: String {
        case savedSongs
    }
    
    func set(_ value: Any?, forKey key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    func array(forKey key: Key) -> [Any]? {
        return UserDefaults.standard.array(forKey: key.rawValue)
    }
}
