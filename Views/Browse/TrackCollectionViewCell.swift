//
//  TrackCollectionViewCell.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/19/25.
//

import UIKit
import SDWebImage
class TrackCollectionViewCell: UICollectionViewCell {
    static let identifier = "TrackCollectionViewCell"

    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackCoverView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .secondarySystemBackground
        contentView.clipsToBounds = true
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        trackCoverView.image = nil
    }
    func configure(with viewModel: RecommendedTrackCellViewModel) {
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = viewModel.artistName
        trackCoverView.sd_setImage(with: viewModel.artworkURL)
    }
}
