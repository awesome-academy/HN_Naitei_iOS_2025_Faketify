//
//  PlaylistsCollectionViewCell.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/20/25.
//

import UIKit
import SDWebImage
class PlaylistsCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistsCollectionViewCell"
    
    @IBOutlet weak var playlistCoverImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        playlistCoverImageView.image = nil
    }
    func configure(with viewModel: PlaylistCellViewModel) {
        playlistCoverImageView.sd_setImage(with: viewModel.artworkURL)
    }
}
