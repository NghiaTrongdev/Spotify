//
//  SeactionHeaderReusableView.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 2/6/24.
//

import UIKit

class SeactionHeaderReusableView: UICollectionReusableView {
    static let identifier = "SeactionHeaderReusableView"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 26, weight: .black)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 10, y: height / 2.0 + 10, width: width, height: height)
        
    }
    
    func configure(with title: String) {
        label.text = title
    }
}
