//
//  UserProfileViewController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 29/11/23.
//

import UIKit

final class UserProfileViewController: UIViewController {
    private let user: User
    
    // MARK: - UI components
    
    private let photoImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private let changeThemeLabel: UILabel = {
        let label = UILabel()
        label.text = "Change theme color"
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private let themeSegmentedControl = UISegmentedControl(items: Theme.BackgroundColor.allCases.map({ $0.rawValue }))
    
    // MARK: - Lifecycle
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        addData()
        themeSegmentedControl.addTarget(self, action: #selector(changeTheme(sender:)), for: .valueChanged)
        setSelectedSegment()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = Theme.backgroundColor
    }
    
    // MARK: - Setup UI
    
    private func addSubviews() {
        view.addSubview(photoImageView)
        view.addSubview(nameLabel)
        view.addSubview(changeThemeLabel)
        view.addSubview(themeSegmentedControl)
    }
    
    private func setupConstraints() {
        photoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        changeThemeLabel.translatesAutoresizingMaskIntoConstraints = false
        themeSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 30),
            nameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            changeThemeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            changeThemeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            themeSegmentedControl.topAnchor.constraint(equalTo: changeThemeLabel.bottomAnchor, constant: 5),
            themeSegmentedControl.widthAnchor.constraint(equalToConstant: view.frame.width / 1.3),
            themeSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func addData() {
        nameLabel.text = user.firstName + " " + user.lastName
        
        DispatchQueue.global().async {
            guard let url = URL(string: self.user.photo400Orig),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                self.photoImageView.image = image
            }
        }
    }
    
    @objc private func changeTheme(sender: UISegmentedControl) {
        guard sender == themeSegmentedControl,
              let segmentTitle = sender.titleForSegment(at: sender.selectedSegmentIndex),
              let themeBackgroundColor = Theme.BackgroundColor(rawValue: segmentTitle)
        else { return }
        
        Theme.setBackgroundColor(themeBackgroundColor)
        view.backgroundColor = Theme.backgroundColor
    }
    
    private func setSelectedSegment() {
        for (i, themeBackgroundColor) in Theme.BackgroundColor.allCases.enumerated()  {
            if themeBackgroundColor.color == Theme.backgroundColor {
                themeSegmentedControl.selectedSegmentIndex = i
                break
            }
        }
    }
}
