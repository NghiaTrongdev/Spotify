//
//  HeaderForSearch.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 11/5/24.
//

import UIKit

class HeaderForSearch: UIView {

    struct ConstButton {
        static let buttonheight = 40.0
        static let spacing = 10.0
    }
    
    private let profileButton : UIButton = {
        let button = UIButton()
        button.setImage( UIImage(named: "download"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        button.titleLabel?.textColor = .label
        button.layer.masksToBounds = true
        button.layer.cornerRadius = ConstButton.buttonheight / 2.0
        button.backgroundColor = .white
        return button
    }()
    private let cameraButton : UIImageView = {
        let img = UIImageView()
        img.tintColor = .label
         img.image = UIImage(systemName: "camera")
         img.contentMode = .scaleAspectFill
         return img
    }()
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 25,weight: .bold)
        label.text = "Tìm kiếm"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileButton)
        addSubview(cameraButton)
        addSubview(titleLabel)
        configuareLayout()
    }
    private func configuareLayout(){
            profileButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ConstButton.spacing),
                profileButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                profileButton.heightAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight)),
                profileButton.widthAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight))
            ])
            
            cameraButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                cameraButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ConstButton.spacing),
                cameraButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                cameraButton.heightAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight-15)),
                cameraButton.widthAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight-15))
            ])
            
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: profileButton.trailingAnchor, constant: ConstButton.spacing),
                titleLabel.trailingAnchor.constraint(equalTo: cameraButton.leadingAnchor, constant: -ConstButton.spacing),
                titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
