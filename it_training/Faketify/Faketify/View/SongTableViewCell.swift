//
//  SongTableViewCell.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/8/25.
//

import UIKit

class SongTableViewCell: UITableViewCell {
    static let identifier = "SongTableViewCell"

    private let songImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()

    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(songImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(artistLabel)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize: CGFloat = contentView.frame.height - 10
        songImageView.frame = CGRect(x: 10, y: 5, width: imageSize, height: imageSize)
        titleLabel.frame = CGRect(x: songImageView.frame.maxX + 10,
                                  y: 5,
                                  width: contentView.frame.width - songImageView.frame.maxX - 20,
                                  height: 22)
        artistLabel.frame = CGRect(x: songImageView.frame.maxX + 10,
                                   y: titleLabel.frame.maxY + 2,
                                   width: contentView.frame.width - songImageView.frame.maxX - 20,
                                   height: 20)
    }

    public func configure(with song: Song) {
        songImageView.image = UIImage(named: song.imageName)
        titleLabel.text = song.title
        artistLabel.text = song.artist
    }
}
