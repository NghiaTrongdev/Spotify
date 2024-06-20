//
//  BottomTypeListCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 10/6/24.
//

import UIKit

class BottomTypeListCollectionViewCell: UICollectionViewCell {
    static let identifier = "BottomTypeListCollectionViewCell"
    @IBOutlet weak var artistButton: UIButton!
    
    @IBOutlet weak var otherButton: UIButton!
    
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
