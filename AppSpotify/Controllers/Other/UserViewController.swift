//
//  UserViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 6/6/24.
//

import UIKit

class UserViewController: UIViewController {
    var isOpen : Bool = false
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var followLabel: UILabel!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var shareButton: UIButton!
    
    @IBOutlet weak var moreButton: UIButton!
    
    @IBOutlet weak var txtNotification: UILabel!
    
    @IBOutlet weak var smalllabel: UILabel!
    
    private func setupUI(){
        userImage.layer.cornerRadius = userImage.height / 2.0
        username.clipsToBounds = true
        
        addGradientToView(view: view)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        isOpen = true
        setupUI()
        
        let vc = HomeViewController()
        
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
        editButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @objc func didTapEditButton(){
        // handle
        let vc = EditUserViewController()
        vc.title = "Chỉnh sửa hồ sơ"
        present(UINavigationController(rootViewController: vc), animated: true)
        
    }
    @objc func didTapShareButton(){
        // handle
        
    }
    @objc func didTapMoreButton(){
        // handle
        
    }

    private func addGradientToView(view: UIView) {
           let gradientLayer = CAGradientLayer()
           gradientLayer.frame = view.bounds

           // Set the start and end colors
           gradientLayer.colors = [
               UIColor(red: 1.0, green: 0.8, blue: 0.0, alpha: 1.0).cgColor, // Màu vàng
               UIColor.black.cgColor // Màu đen
           ]

        gradientLayer.locations = [
            NSNumber(value: 0.0),
            NSNumber(value: 0.3)
        ]
           gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
           gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)

           view.layer.insertSublayer(gradientLayer, at: 0)
       }

    

}
