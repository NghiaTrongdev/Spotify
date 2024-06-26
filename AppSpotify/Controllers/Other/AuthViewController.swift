//
//  AuthViewController.swift
//  AppSpotify
//
//  Created by Trọng Nghĩa Nguyễn on 8/5/24.
//

import UIKit
import WebKit

class AuthViewController: UIViewController, WKNavigationDelegate {
    private let webview : WKWebView = {
        let pref = WKWebpagePreferences()
        pref.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = pref
        let web = WKWebView(frame: .zero,configuration: config)
        return web
    }()

     var completionHandler: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sign In"
        view.backgroundColor = .systemBackground
        webview.navigationDelegate = self
        view.addSubview(webview)
        guard let url = AuthManager.shared.signInUrl else {
            return
        }
        webview.load(URLRequest(url: url))
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webview.frame = view.bounds
    }
    

 
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        guard let url = webview.url  else {
            return
        }
        
        guard let code = URLComponents(string: url.absoluteString)?.queryItems?.first(where: {$0.name == "code"})?.value else {
            return
        }
        
        AuthManager.shared.exchangeCodeforToken(code: code){[weak self] success in
            DispatchQueue.main.async {
                self?.navigationController?.popToRootViewController(animated: true)
                self?.completionHandler?(success)
            }
            
        }
    }
}
