//
//  FriendsTableViewCell.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 17/11/23.
//

import UIKit

final class FriendsTableViewCell: UITableViewCell {
    static let identifier = "FriendsCell"
    
    // MARK: - UI components
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.clear.cgColor
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func setupConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            photoImageView.widthAnchor.constraint(equalToConstant: 40),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
    }
    
    public func configure(with friend: Friend) {
        contentView.backgroundColor = Theme.backgroundColor
        nameLabel.text = friend.firstName + " " + friend.lastName
        
        DispatchQueue.global().async {
            guard let url = URL(string: friend.photo200),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                self.photoImageView.image = image
                if friend.isOnline {
                    self.photoImageView.layer.borderColor = UIColor.green.cgColor
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        photoImageView.layer.borderColor = UIColor.clear.cgColor
        nameLabel.text = nil
    }
}
