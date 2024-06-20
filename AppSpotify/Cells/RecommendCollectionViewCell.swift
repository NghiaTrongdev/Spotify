//
//  RecommendCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 16/5/24.
//

import UIKit

class RecommendCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "RecommendCollectionViewCell"
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var namelabel: UILabel!
    
    private func setupUI(){
        image.contentMode = .scaleAspectFit
        namelabel.textColor = .gray
    }
    func configuareModel(model : RecommendationCellModel){
        image.sd_setImage(with: model.image)
        namelabel.text = model.name
    }
    func configuareforNewReleaser(model : NewReleaseCellViewModel){
        image.sd_setImage(with: model.artworkURL)
        namelabel.text = model.name
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        namelabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        backgroundColor = .systemBackground
        clipsToBounds = true
        // Initialization code
    }

}
