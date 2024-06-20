//
//  HoldOnViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 3/6/24.
//
import SDWebImage
import UIKit
protocol HoldOnViewControllerDelegate : AnyObject {
    func handlePlusButtonClick()
    func handleShareButtonClick()
    func handleCloseButtonClick()
}
class HoldOnViewController: UIViewController {
    @IBOutlet weak var stackviewMain: UIStackView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var plusLibrary: UIButton!
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var topview: UIView!
    weak var delegate: HoldOnViewControllerDelegate?
    private func setupUI() {
        NSLayoutConstraint.activate([
            shareButton.leadingAnchor.constraint(equalTo: stackviewMain.leadingAnchor, constant: 10),
        ])
        NSLayoutConstraint.activate([
            plusLibrary.leadingAnchor.constraint(equalTo: stackviewMain.leadingAnchor, constant: 10),
        ])
        // Set the background color to a semi-transparent color
        view.backgroundColor = UIColor(white: 0, alpha: 0.9) // Adjust the alpha value as needed

        // Ensure the content views are fully opaque
        stackviewMain.alpha = 1.0
        closeButton.alpha = 1.0
        shareButton.alpha = 1.0
        plusLibrary.alpha = 1.0
        topLabel.alpha = 1.0
        topImage.alpha = 1.0
        topview.alpha = 1.0
    }

    func configuareView(url : URL?,mess : String){
        guard let urlstring = url else {
            return
        }
        topImage.sd_setImage(with: urlstring)
        topLabel.text = mess
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        closeButton.addTarget(self, action: #selector(didtapCloseButton), for: .touchUpInside)
        plusLibrary.addTarget(self, action: #selector(didtapPlusButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didtapShareButton), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    @objc func didtapCloseButton(){
        dismiss(animated: true, completion: nil)
//        delegate?.handleCloseButtonClick()
    }
    @objc func didtapPlusButton(){
        delegate?.handlePlusButtonClick()
    }
    
    @objc func didtapShareButton(){
        delegate?.handleShareButtonClick()
    }
    
    
    
    
}
