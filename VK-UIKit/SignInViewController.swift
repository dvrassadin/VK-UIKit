//
//  SignInViewController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 15/11/23.
//

import UIKit

final class SignInViewController: UIViewController {
    
    // MARK: - UI components
    
    private let logoImageView = UIImageView(image: UIImage(named: "VK Logo"))
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign In to VK"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Login"
        textField.backgroundColor = .systemGray5
        textField.borderStyle = .roundedRect
        textField.textContentType = .username
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.backgroundColor = .systemGray5
        textField.borderStyle = .roundedRect
        textField.textContentType = .password
        return textField
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.configuration = .filled()
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setUpConstraints()
        
        logInButton.addTarget(
            self,
            action: #selector(goToTabBarController),
            for: .touchUpInside
        )
    }
    
    // MARK: - Setup UI
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(signInLabel)
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(logInButton)
    }
    
    private func setUpConstraints() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        signInLabel.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
            logoImageView.widthAnchor.constraint(equalToConstant: view.frame.size.width / 7),
            logoImageView.heightAnchor.constraint(equalToConstant: view.frame.size.width / 7),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signInLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 22),
            signInLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginTextField.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 22),
            loginTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginTextField.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40),
            loginTextField.heightAnchor.constraint(equalToConstant: view.frame.size.height / 21),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 22),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40),
            passwordTextField.heightAnchor.constraint(equalToConstant: view.frame.size.height / 21),
            
            logInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 22),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.widthAnchor.constraint(equalToConstant: view.frame.size.width - 40),
            logInButton.heightAnchor.constraint(equalToConstant: view.frame.size.height / 21),
        ])
    }
    
    // MARK: - Navigation
    
    @objc private func goToTabBarController() {
        navigationController?.pushViewController(TabBarController(), animated: true)
    }
}

#Preview {
    SignInViewController()
}
