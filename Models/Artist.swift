//
//  Artist.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/14/25.
//

import Foundation

struct Artist: Codable {
    let id: String
    let name: String
    let type: String
    let images: [APIImage]?
    let external_urls: [String : String]

}
