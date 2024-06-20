//
//  FullHeightCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 25/5/24.
//

import UIKit

class FullHeightCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FullHeightCollectionViewCell"
    
    @IBOutlet weak var backgroundcell: UIImageView!
    
    @IBOutlet weak var imageheader: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var plusButton: UIButton!
    
    @IBOutlet weak var previousButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var volumnButton: UIButton!
    
    @IBOutlet weak var bottomTitle: UILabel!
    
    @IBOutlet weak var labelartist: UILabel!
    
    
    private func setupUI(){
        //image header
        imageheader.layer.cornerRadius = 10.0
        imageheader.clipsToBounds = true
        
        // viewbottom
        bottomView.layer.cornerRadius = bottomView.height / 2.0
        bottomView.clipsToBounds = true
        
        //
    }
    
    func configuareModel(model : NewFeatureCellModel){
        backgroundcell.sd_setImage(with: model.urlString)
        imageheader.sd_setImage(with: model.urlString)
        title.text = model.name
        labelartist.text = model.createName
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 20.0
        clipsToBounds = true
        setupUI()
    }

}
