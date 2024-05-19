//
//  HeaderUIView.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 11/5/24.
//

import UIKit
protocol HeaderUIViewDelgate : AnyObject{
    func profileButtonDidTapped()
    func allbuttonDidTapped()
    func songbuttonDidTapped()
    func podcastsButtonDidTapped()
}
class HeaderUIView: UIView {
    weak var delegate : HeaderUIViewDelgate?
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
    private let allButton : UIButton = {
        let button = UIButton()
        
        // Tạo NSAttributedString với khoảng cách giữa các ký tự
        let buttonText = "Tất cả"
        let attributedString = NSMutableAttributedString(string: buttonText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 0.7, range: NSRange(location: 0, length: attributedString.length))
        
        // Thiết lập attributed title cho button
        button.setAttributedTitle(attributedString, for: .normal)
        
        // Thiết lập font và các thuộc tính khác
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        button.backgroundColor = .systemGray
        button.titleLabel?.textColor = .black
        button.layer.cornerRadius = ConstButton.buttonheight / 2.0
        button.backgroundColor = .systemGreen
        
        return button
    }()
    
    
    private let songsButton : UIButton = {
        let button = UIButton()
        
        // Tạo NSAttributedString với khoảng cách giữa các ký tự
        let buttonText = "Nhạc"
        let attributedString = NSMutableAttributedString(string: buttonText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 0.7, range: NSRange(location: 0, length: attributedString.length))
        
        // Thiết lập attributed title cho button
        button.setAttributedTitle(attributedString, for: .normal)
        
        // Thiết lập font và các thuộc tính khác
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        button.backgroundColor = .systemGray
        button.titleLabel?.textColor = .label
        button.layer.cornerRadius = ConstButton.buttonheight / 2.0
        
        return button
    }()
   
    private let podcastButton : UIButton = {
        let button = UIButton()
        
        // Tạo NSAttributedString với khoảng cách giữa các ký tự
        let buttonText = "Podcasts"
        let attributedString = NSMutableAttributedString(string: buttonText)
        attributedString.addAttribute(NSAttributedString.Key.kern, value: 0.7, range: NSRange(location: 0, length: attributedString.length))
        
        // Thiết lập attributed title cho button
        button.setAttributedTitle(attributedString, for: .normal)
        
        // Thiết lập font và các thuộc tính khác
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentEdgeInsets = UIEdgeInsets(top: 20, left: 15, bottom: 20, right: 15)
        button.backgroundColor = .systemGray
        button.titleLabel?.textColor = .label
        button.layer.cornerRadius = ConstButton.buttonheight / 2.0
        
        return button
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(profileButton)
        addSubview(allButton)
        addSubview(songsButton)
        addSubview(podcastButton)
        profileButton.addTarget(self, action: #selector(profileOnclick), for: .touchUpInside)
        allButton.addTarget(self, action: #selector(allbuttonOnclick), for: .touchUpInside)
        songsButton.addTarget(self, action: #selector(songbuttonOnclick), for: .touchUpInside)
        podcastButton.addTarget(self, action: #selector(podcastbuttonOnclick), for: .touchUpInside)
        configuareLayout()
    }
    private func configuareLayout(){
        // Cấu hình layout cho profileButton
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: ConstButton.spacing),
            profileButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            profileButton.heightAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight)),
            profileButton.widthAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight))
        ])

        // Cấu hình layout cho allButton
        allButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            allButton.leadingAnchor.constraint(equalTo: profileButton.trailingAnchor, constant: ConstButton.spacing),
            allButton.centerYAnchor.constraint(equalTo: profileButton.centerYAnchor),
            allButton.heightAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight))
        ])

        // Cấu hình layout cho songsButton
        songsButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songsButton.leadingAnchor.constraint(equalTo: allButton.trailingAnchor, constant: ConstButton.spacing),
            songsButton.centerYAnchor.constraint(equalTo: profileButton.centerYAnchor),
            songsButton.heightAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight))
        ])

        // Cấu hình layout cho podcastButton
        podcastButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            podcastButton.leadingAnchor.constraint(equalTo: songsButton.trailingAnchor, constant: ConstButton.spacing),
            podcastButton.centerYAnchor.constraint(equalTo: profileButton.centerYAnchor),
            podcastButton.heightAnchor.constraint(equalToConstant: CGFloat(ConstButton.buttonheight))
        ])
    }
    @objc private func profileOnclick(){
        delegate?.profileButtonDidTapped()
    }
    
    @objc private func allbuttonOnclick(){
        UIView.animate(withDuration: 0.1, animations: {
            // Thiết lập scale và opacity cho nút khi ấn
            self.allButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.allButton.alpha = 0.8
        }) { _ in
            // Sau khi animation kết thúc, thiết lập các thuộc tính cho nút
            self.allButton.backgroundColor = .systemGreen
            self.allButton.titleLabel?.textColor = .black
            
            self.songsButton.backgroundColor = .gray
            self.songsButton.titleLabel?.textColor = .white
            
            self.podcastButton.backgroundColor = .gray
            self.podcastButton.titleLabel?.textColor = .white
            
            // Trả lại kích thước ban đầu của nút và opacity
            UIView.animate(withDuration: 0.1) {
                self.allButton.transform = .identity
                self.allButton.alpha = 1.0
            }
        }
        
        // Gọi delegate khi nút được nhấn
        delegate?.allbuttonDidTapped()
    }


    @objc private func songbuttonOnclick(){
        UIView.animate(withDuration: 0.1, animations: {
            // Thiết lập scale và opacity cho nút khi ấn
            self.songsButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.songsButton.alpha = 0.8
        }) {  _ in
            // Sau khi animation kết thúc, thiết lập các thuộc tính cho nút
            self.songsButton.backgroundColor = .systemGreen
            self.songsButton.titleLabel?.textColor = .black
            
            self.allButton.backgroundColor = .gray
            self.allButton.titleLabel?.textColor = .white
            
            self.podcastButton.backgroundColor = .gray
            self.podcastButton.titleLabel?.textColor = .white
            // Trả lại kích thước ban đầu của nút và opacity
            UIView.animate(withDuration: 0.1) {
                self.songsButton.transform = .identity
                self.songsButton.alpha = 1.0
            }
        }
        
        delegate?.songbuttonDidTapped()
    }
    @objc private func podcastbuttonOnclick(){
        UIView.animate(withDuration: 0.1, animations: {
            // Thiết lập scale và opacity cho nút khi ấn
            self.podcastButton.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            self.podcastButton.alpha = 0.8
        }) {   _ in
            // Sau khi animation kết thúc, thiết lập các thuộc tính cho nút
            self.podcastButton.backgroundColor = .systemGreen
            self.podcastButton.titleLabel?.textColor = .black
            
            self.allButton.backgroundColor = .gray
            self.allButton.titleLabel?.textColor = .white
            
            self.songsButton.backgroundColor = .gray
            self.songsButton.titleLabel?.textColor = .white
            // Trả lại kích thước ban đầu của nút và opacity
            UIView.animate(withDuration: 0.1) {
                self.podcastButton.transform = .identity
                self.podcastButton.alpha = 1.0
            }
        }
        
        
        
        delegate?.podcastsButtonDidTapped()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
