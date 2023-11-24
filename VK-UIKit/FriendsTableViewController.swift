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
    private var friends = [User]()
    
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
}

#Preview {
    FriendsTableViewController()
}
