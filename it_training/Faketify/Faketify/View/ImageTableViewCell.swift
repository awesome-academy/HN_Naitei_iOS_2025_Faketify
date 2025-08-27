//
//  ImageTableViewCell.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/26/25.
//

import UIKit

struct CoverItem {
    let imageName: String
    let title: String
}

// MARK: - Protocol
protocol ImageTableViewCellDelegate: AnyObject {
    func imageTableViewCell(_ cell: ImageTableViewCell, didSelectItemAt index: Int)
}

final class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var items: [CoverItem] = []
        weak var delegate: ImageTableViewCellDelegate?
        
        override func awakeFromNib() {
            super.awakeFromNib()
            setupCollectionView()
        }
        
    private func setupCollectionView() {
        let nib = UINib(nibName: "ImageCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier) // ✅ Đăng ký nib

        collectionView.delegate = self
        collectionView.dataSource = self

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 8
            layout.itemSize = CGSize(width: 120, height: 160)
        }
    }

        func configure(items: [CoverItem]) {
            self.items = items
            collectionView.reloadData()
        }
    }

    // MARK: - CollectionView
    extension ImageTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return items.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: ImageCollectionViewCell.identifier,
                for: indexPath
            ) as? ImageCollectionViewCell else {
                return UICollectionViewCell()
            }
            let item = items[indexPath.row]
            cell.configure(image: UIImage(named: item.imageName), title: item.title)
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            delegate?.imageTableViewCell(self, didSelectItemAt: indexPath.row)
        }
        
        // Kích thước item
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 140, height: 180)
        }
    }
