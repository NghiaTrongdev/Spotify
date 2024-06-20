//
//  PlaylistCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 15/6/24.
//

import UIKit

class PlaylistCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlaylistCollectionViewCell"

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var imagePlaylist: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configuareModel(model : TrackObject){
        artistLabel.text = model.artists.map { $0.name }.joined(separator: " , ")
        nameLabel.text = model.name
        imagePlaylist.sd_setImage(with:URL(string: model.album.images.first?.url ?? ""))
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        artistLabel.text = nil
        nameLabel.text = nil
        imagePlaylist.image = nil
    }
}
