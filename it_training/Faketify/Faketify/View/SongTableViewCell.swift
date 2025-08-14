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
    }

    func configure(with song: Song) {
        songImageView.image = UIImage(named: song.imageName)
        titleLabel.text = song.title
        artistLabel.text = song.artist
    }
}
