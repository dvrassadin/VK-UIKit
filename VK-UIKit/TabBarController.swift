//
//  TabBarController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 17/11/23.
//

import UIKit

final class TabBarController: UITabBarController {
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        addViewControllers()
    }
    
    // MARK: - Setup UI
    
    private func addViewControllers() {
        let friendsTableVC = FriendsTableViewController()
        let friendsTabBarItem = UITabBarItem(
            title: "Friends",
            image: UIImage(systemName: "person.crop.circle"),
            selectedImage: UIImage(systemName: "person.crop.circle.fill")
        )
        friendsTableVC.tabBarItem = friendsTabBarItem
        
        let groupsTableVC = GroupsTableViewController()
        let groupsTabBarItem = UITabBarItem(
            title: "Groups",
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )
        groupsTableVC.tabBarItem = groupsTabBarItem
        
        let photosCollectionVC = PhotosCollectionViewController(
            collectionViewLayout: PhotosCollectionViewController.createLayout()
        )
        let photosTabBarItem = UITabBarItem(
            title: "Photos",
            image: UIImage(systemName: "photo.stack"),
            selectedImage: UIImage(systemName: "photo.stack.fill")
        )
        photosCollectionVC.tabBarItem = photosTabBarItem
        
        viewControllers = [friendsTableVC, groupsTableVC, photosCollectionVC]
    }
}

#Preview {
    TabBarController()
}
