//
//  PlaylistListCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 10/6/24.
//

import UIKit

class PlaylistListCollectionViewCell: UICollectionViewCell {
    static let identifier = "PlaylistListCollectionViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configuareModel(model : PlayList){
        image.sd_setImage(with: URL(string: model.images?.first?.url ?? ""))
        nameLabel.text = model.name
    }
    override func prepareForReuse() {
        image.image = nil
        nameLabel.text = nil
    }
}
