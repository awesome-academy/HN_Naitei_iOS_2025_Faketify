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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure image view
        songImageView.layer.cornerRadius = 4
        songImageView.clipsToBounds = true
        songImageView.contentMode = .scaleAspectFill
        
        // Configure title label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .label
        
        // Configure artist label
        artistLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        artistLabel.textColor = .secondaryLabel
        
        // Set selection style
        selectionStyle = .default
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.systemGray5
    }

    func configure(with song: Song) {
        print("🎵 Configuring cell for song: \(song.title)")
        print("🖼️ Image name: \(song.imageName)")
        
        songImageView.image = UIImage(named: song.imageName)
        titleLabel.text = song.title
        artistLabel.text = song.artist
        
        print("✅ Cell configured - Title: \(titleLabel.text ?? "nil"), Artist: \(artistLabel.text ?? "nil")")
    }
}
