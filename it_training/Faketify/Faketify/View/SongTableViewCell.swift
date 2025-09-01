//
//  SongTableViewCell.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/13/25.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    
    static let identifier = "SongTableViewCell"
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
       private var song: Song?
       
    func configure(with song: Song) {
        songImageView.image = UIImage(named: song.imageName)
        titleLabel.text = song.title
        artistLabel.text = song.artist
    }

       
    @IBAction func favoriteTapped(_ sender: UIButton) {
        guard let song = song else { return }
        SongRepository.shared.toggleSave(song: song)
        
        if let updatedSong = SongRepository.shared.allSongs.first(where: { $0.title == song.title && $0.artist == song.artist }) {
            configure(with: updatedSong)
        }
    }
   }
