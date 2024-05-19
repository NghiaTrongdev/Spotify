//
//  LibraryViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import UIKit

class LibraryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.backgroundColor = .systemBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        let headerview = HeaderForLibrary(frame: CGRect(x: 0, y:96, width: view.width, height: 50))
        headerview.backgroundColor = .systemBackground
        view.addSubview(headerview)
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }


}
