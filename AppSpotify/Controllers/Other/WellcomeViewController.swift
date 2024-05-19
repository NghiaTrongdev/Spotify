//
//  ViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import UIKit

class WellcomeViewController: UIViewController {
    let signInButton : UIButton = {
        let button = UIButton()
        button.setTitle("Sign in for Spotify", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .white
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Spotify"
        view.backgroundColor = .systemGreen
        signInButton.addTarget(self, action: #selector(signInButtonDidTapped), for: .touchUpInside)
        view.addSubview(signInButton)
        
    }
    @objc private func signInButtonDidTapped(){
        let vc = AuthViewController()
        vc.comletionHandler = {[weak self] success in
            
            DispatchQueue.main.async {
                self?.handleSignIn(success: success)
            }
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    private func handleSignIn(success : Bool){
        guard success else {
            let alert = UIAlertController(title: "Oops", message:"Somethings went wrong when Sign in", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
            present(alert, animated: true)
            return
        }
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.width - 40, height: 50)
    }

}

