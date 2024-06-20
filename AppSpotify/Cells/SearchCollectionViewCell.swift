//
//  SearchCollectionViewCell.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/6/24.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionViewCell"
    
    @IBOutlet weak var imageMain: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.masksToBounds = true
        setupUi()
    }
    private func setupUi(){
        imageMain.transform = imageMain.transform.rotated(by: .pi/6)
        imageMain.layer.cornerRadius = 5.0
        imageMain.clipsToBounds = true
//        imageMain.layer.masksToBounds = true
        
        imageMain.layer.shadowColor = UIColor.black.cgColor
        imageMain.layer.shadowOpacity = 0.5
        imageMain.layer.shadowOffset = CGSize(width: 0, height: 2)
        imageMain.layer.shadowRadius = 4
        imageMain.layer.masksToBounds = true
        
//        NSLayoutConstraint.activate([imageMain.topAnchor.constraint(equalTo: imageMain.topAnchor, constant: 20)])
        
    }
    func configuareModel(model : Category){
        imageMain.sd_setImage(with: URL(string: model.icons.first?.url ?? ""))
        nameLabel.text = model.name
    }
    
}
