//
//  PlaylistGridCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 10/6/24.
//

import UIKit

class PlaylistGridCollectionViewCell: UICollectionViewCell {
    static let identifier = "PlaylistGridCollectionViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageview: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
   
    func configuareModel(model : PlayList){
        imageview.sd_setImage(with: URL(string: model.images?.first?.url ?? ""))
        nameLabel.text = model.name
    }
    override func prepareForReuse() {
        imageview.image = nil
        nameLabel.text = nil
    }
}
