//
//  SignInViewController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 15/11/23.
//

import UIKit
import WebKit

final class SignInViewController: UIViewController {
    private let authURL = "https://oauth.vk.com/authorize?client_id=" + clientID + "&redirect_uri=https://oauth.vk.com/blank.html&scope=262150&display=mobile&response_type=token"
    
    // MARK: - UI components
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: view.bounds)
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        openSignInPage()
    }
    
    // MARK: - Navigation
    
    private func goToTabBarController() {
        navigationController?.pushViewController(
            TabBarController(),
            animated: true
        )
    }
    
    private func openSignInPage() {
        guard let url = URL(string: authURL) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

// MARK: - WebKit navigation delegate

extension SignInViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path() == "/blank.html",
              let fragment = url.fragment(),
              let token = fragment
            .components(separatedBy: "&")
            .first(where: { $0.hasPrefix("access_token") })?
            .components(separatedBy: "=").last
        else {
            decisionHandler(.allow)
            return
        }
        
        NetworkService.token = token
        print(token)
        decisionHandler(.cancel)
        webView.removeFromSuperview()
        goToTabBarController()
    }
}
