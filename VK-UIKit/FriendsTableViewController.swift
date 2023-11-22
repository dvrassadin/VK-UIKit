//
//  FriendsTableViewController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 17/11/23.
//

import UIKit

final class FriendsTableViewController: UITableViewController {
    static let name = "Friends"
    private let networkService = NetworkService()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(
            FriendsTableViewCell.self,
            forCellReuseIdentifier: FriendsTableViewCell.identifier
        )
        networkService.getFriends()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = Self.name
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: FriendsTableViewCell.identifier,
            for: indexPath
        ) as? FriendsTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(name: "Name")
        
        return cell
    }
}

#Preview {
    FriendsTableViewController()
}
