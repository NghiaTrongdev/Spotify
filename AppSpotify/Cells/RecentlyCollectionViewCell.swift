//
//  RecentlyCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 12/5/24.
//

import UIKit

class RecentlyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var testImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier = "RecentlyCollectionViewCell"

    private func setupUI(){

        nameLabel.numberOfLines = 2
        nameLabel.text = "Xin chao tat ca moi nguoi nhe hihiiiiii"
        nameLabel.lineBreakMode = .byTruncatingTail
    }

    
    public func configuareModel(model : RecentlyPlayedViewModels){
        testImage.sd_setImage(with: model.artworkURL)
        nameLabel.text = model.name
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        testImage.image = nil
        nameLabel.text = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        layer.cornerRadius = 5.0
        clipsToBounds = true
//        backgroundColor = .gray
        // Initialization code
    }

}
