//
//  ArtistListCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 10/6/24.
//

import UIKit

class ArtistListCollectionViewCell: UICollectionViewCell {
    static let identifier = "ArtistListCollectionViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    private func setupUI()
    {
        image.layer.cornerRadius = image.height / 4.0
        image.clipsToBounds = true
        image.layer.masksToBounds = true
    }
    func configuareModel(artist : ArtistResponse){
        image.sd_setImage(with: URL(string: artist.images.first?.url ?? ""))
        nameLabel.text = artist.name
    }
    override func prepareForReuse() {
        image.image = nil
        nameLabel.text = nil
    }

}
