//
//  GroupsTableViewCell.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 19/11/23.
//

import UIKit

final class GroupsTableViewCell: UITableViewCell {
    static let identifier = "GroupsCell"
    
    // MARK: - UI components
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .systemGray6
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .natural
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 2
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func addSubviews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    private func setupConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            photoImageView.widthAnchor.constraint(equalToConstant: 40),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 15),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        nameLabel.text = nil
        descriptionLabel.text = nil
    }
    
    func configure(with group: Group) {
        contentView.backgroundColor = Theme.backgroundColor
        nameLabel.text = group.name
        descriptionLabel.text = group.description
        Task { await photoImageView.image = group.photo }
    }
}
