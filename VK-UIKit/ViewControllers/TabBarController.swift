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
        let model = VKModel(networkService: VKNetworkService(), dataService: VKDataService())
        
        // Friends VC
        let friendsTableVC = FriendsTableViewController(userModel: model, friendsModel: model)
        let friendsTabBarItem = UITabBarItem(
            title: FriendsTableViewController.name,
            image: UIImage(systemName: "person.crop.circle"),
            selectedImage: UIImage(systemName: "person.crop.circle.fill")
        )
        friendsTableVC.tabBarItem = friendsTabBarItem
        
        // Groups VC
        let groupsTableVC = GroupsTableViewController(groupsModel: model)
        let groupsTabBarItem = UITabBarItem(
            title: GroupsTableViewController.name,
            image: UIImage(systemName: "person.3"),
            selectedImage: UIImage(systemName: "person.3.fill")
        )
        groupsTableVC.tabBarItem = groupsTabBarItem
        
        // Photos VC
        let photosCollectionVC = PhotosCollectionViewController(
            collectionViewLayout: PhotosCollectionViewController.createLayout(),
            photosModel: model
        )
        let photosTabBarItem = UITabBarItem(
            title: PhotosCollectionViewController.name,
            image: UIImage(systemName: "photo.stack"),
            selectedImage: UIImage(systemName: "photo.stack.fill")
        )
        photosCollectionVC.tabBarItem = photosTabBarItem
        
        viewControllers = [friendsTableVC, groupsTableVC, photosCollectionVC]
    }
}
