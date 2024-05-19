//
//  HeaderForLibrary.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 11/5/24.
//

import UIKit

class HeaderForLibrary: UIView {
    
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
    private let plusButton : UIImageView = {
       let img = UIImageView()
        img.tintColor = .label
        img.image = UIImage(systemName: "plus")
        img.contentMode = .scaleAspectFill
        return img
        
    }()
    
    private let searchButton : UIImageView = {
       let img = UIImageView()
        img.tintColor = .label
        img.image = UIImage(systemName: "magnifyingglass")
        img.contentMode = .scaleAspectFill
        return img
        
    }()
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 25,weight: .bold)
        label.text = "Thư viện"
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileButton)
        addSubview(plusButton)
        addSubview(titleLabel)
        addSubview(searchButton)
        configuareLayout()
    }
    private func configuareLayout() {
        // Profile Button
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ConstButton.spacing),
            profileButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileButton.heightAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight)),
            profileButton.widthAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight))
        ])
        
        // Plus Button
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -ConstButton.spacing),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusButton.heightAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight - 15)),
            plusButton.widthAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight - 15))
        ])
        
         
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchButton.trailingAnchor.constraint(equalTo: plusButton.leadingAnchor, constant: -ConstButton.spacing),
            searchButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight - 15)),
            searchButton.widthAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight - 15))
        ])
        
        // Title Label
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: profileButton.trailingAnchor, constant: ConstButton.spacing),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }


    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
