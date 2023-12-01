//
//  FriendProfileViewController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 1/12/23.
//

import UIKit

final class FriendProfileViewController: UIViewController {
    private let friend: Friend
    
    // MARK: - UI components
    
    private let photoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel = UILabel()
    
    // MARK: - Lifecycle
    
    init(friend: Friend) {
        self.friend = friend
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
        addData()
    }
    
    // MARK: - Setup UI
    
    private func addSubviews() {
        view.addSubview(photoImageView)
        view.addSubview(nameLabel)
    }
    
    private func setupConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 30),
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func addData() {
        nameLabel.text = friend.firstName + " " + friend.lastName
        
        DispatchQueue.global().async {
            guard let url = URL(string: self.friend.photo200),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
        }
    }
}
