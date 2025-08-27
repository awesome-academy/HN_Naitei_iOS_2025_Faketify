//
//  ImageCollectionViewCell.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/27/25.
//

import UIKit

final class ImageCollectionViewCell: UICollectionViewCell {
    static let identifier = "ImageCollectionViewCell"
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            imageView.contentMode = .scaleAspectFill
            imageView.layer.cornerRadius = 8
            imageView.clipsToBounds = true
        }
        
        func configure(image: UIImage?, title: String) {
            imageView.image = image
            titleLabel.text = title
        }
}
