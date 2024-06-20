//
//  CreatePlaylistViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 13/6/24.
//

import UIKit

class CreatePlaylistViewController: UIViewController {

    @IBOutlet weak var ceateButton: UIButton!
    
    @IBOutlet weak var txtName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        addShadowToButton(button: ceateButton)
    }

    private func setupUI(){
        addGradientToView(view: view)
    }
    
    func configuare(size : Int){
        txtName.placeholder = "Danh sách phát thứ \(size)"
        txtName.text = "Test \(size)"
    }

    @IBAction func closeButtonOnclick(_ sender: Any) {
        dismiss(animated: true)
    }
    private func addGradientToView(view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        
        // Set the start and end colors
        gradientLayer.colors = [
            UIColor.white.cgColor,
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
    private func addShadowToButton(button: UIButton) {
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 4
        button.layer.masksToBounds = false
    }
}
