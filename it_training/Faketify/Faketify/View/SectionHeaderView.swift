//
//  SectionHeaderViewCell.swift
//  Faketify
//
//  Created by Nguyen Duc on 8/27/25.
//

import UIKit

class SectionHeaderView: UITableViewHeaderFooterView {
    static let identifier = "SectionHeaderView"

    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .label
    }

    func configure(with title: String) {
        titleLabel.text = title
    }
}
