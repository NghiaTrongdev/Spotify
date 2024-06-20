//
//  BottomTypeGridCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 9/6/24.
//

import UIKit

class BottomTypeGridCollectionViewCell: UICollectionViewCell {
    static let identifier = "BottomTypeGridCollectionViewCell"

    @IBOutlet weak var otherButton: UIButton!
    @IBOutlet weak var artistButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    private func setupUI(){
        artistButton.imageView?.layer.cornerRadius = artistButton.height / 2.0
        artistButton.imageView?.layer.masksToBounds = true
        
        otherButton.imageView?.layer.cornerRadius = 8.0
        otherButton.imageView?.layer.masksToBounds = true

    }
}
