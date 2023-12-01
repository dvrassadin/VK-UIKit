//
//  FriendsTableViewController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 17/11/23.
//

import UIKit

final class FriendsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    static let name = "Friends"
    private let networkService = NetworkService()
    private var friends = [Friend]()
    private var user: User?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            FriendsTableViewCell.self,
            forCellReuseIdentifier: FriendsTableViewCell.identifier
        )
        updateFriends()
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(
            self,
            action: #selector(updateFriends),
            for: .valueChanged
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = Self.name
        view.backgroundColor = Theme.backgroundColor
        tableView.reloadData()
        addProfileButton()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FriendsTableViewCell.identifier,
            for: indexPath
        ) as? FriendsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: friends[indexPath.row])
        
        return cell
    }
    
    // MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(
            FriendProfileViewController(friend: friends[indexPath.row]),
            animated: true
        )
    }
    
    @objc private func goToProfile() {
        guard let user else { return }
        let transition = CATransition()
        transition.timingFunction = CAMediaTimingFunction(name: .linear)
        transition.duration = 0.5
        transition.type = .fade
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.pushViewController(UserProfileViewController(user: user), animated: false)
    }
    
    // MARK: - Setup UI
    
    @objc private func updateFriends() {
        networkService.getFriends { [weak self] users in
            self?.friends = users
            DispatchQueue.main.async {
                self?.refreshControl?.endRefreshing()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func getUser(_ completion: @escaping () -> Void) {
        networkService.getUser { [weak self] user in
            self?.user = user.first
            completion()
        }
    }
    
    /// Adds a right `UIBarButtonItem` to the navigation bar or first loads the user's data if `user` is `nil`.
    private func addProfileButton() {
        if user != nil {
            self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(
                image: UIImage(systemName: "person.crop.circle"),
                style: .plain,
                target: self,
                action: #selector(self.goToProfile)
            )
        } else {
            getUser { [weak self] in
                DispatchQueue.main.async {
                    self?.addProfileButton()
                }
            }
        }
    }
}
