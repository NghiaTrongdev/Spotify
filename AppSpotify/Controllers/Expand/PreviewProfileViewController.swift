//
//  PreviewProfileViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 4/6/24.
//

import UIKit

class PreviewProfileViewController: UIViewController {
    @IBOutlet weak var topview: UIView!
    @IBOutlet weak var stack1: UIStackView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var recentButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        
        view.addGestureRecognizer(panGesture)
        setupUI()
        let tapOpenProfile = UITapGestureRecognizer(target: self, action: #selector(openProfile))
        topview.addGestureRecognizer(tapOpenProfile)
        
        newButton.addTarget(self, action: #selector(newbuttondidtapped), for: .touchUpInside)
        recentButton.addTarget(self, action: #selector(recentbuttondidtapped), for: .touchUpInside)
        settingButton.addTarget(self, action: #selector(settingbuttondidtapped), for: .touchUpInside)
    }
    private func setupUI(){
        profileImage.layer.cornerRadius = profileImage.height / 2.0
        profileImage.clipsToBounds = true
        
        
    }
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        guard let view = gesture.view else { return }
        
        
        if gesture.state == .changed {
            // Di chuyển view theo tay kéo
            if translation.x < 0 {
                view.frame.origin.x = translation.x
            }
        } else if gesture.state == .ended {
            // Nếu kéo đủ xa, đóng view
            if translation.x < -view.frame.width * 0.3 {
                UIView.animate(withDuration: 0.3, animations: {
                    view.frame.origin.x = -view.frame.width
                }) { _ in
                    self.dismiss(animated: false, completion: nil)
                }
            } else {
                // Quay về vị trí ban đầu nếu kéo không đủ xa
                UIView.animate(withDuration: 0.3) {
                    view.frame.origin.x = 0
                }
            }
            
        }
    }
    func configuare(){
        
    }
    @objc func newbuttondidtapped(){
        
    }
    @objc func recentbuttondidtapped(){
        
    }
    @objc func settingbuttondidtapped(){
        
    }
    @objc func openProfile(){
        let vc = UserViewController()
        vc.title = "Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
       
    }
}
