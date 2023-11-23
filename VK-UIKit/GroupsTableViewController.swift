//
//  GroupsTableViewController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 17/11/23.
//

import UIKit

final class GroupsTableViewController: UITableViewController {
    static let name = "Groups"
    private let networkService = NetworkService()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Self.name
        tableView.register(
            GroupsTableViewCell.self,
            forCellReuseIdentifier: GroupsTableViewCell.identifier
        )
        networkService.getGroups()
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
            withIdentifier: GroupsTableViewCell.identifier,
            for: indexPath
        ) as? GroupsTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(name: "Name", description: "Description")
        
        return cell
    }
}

#Preview {
    GroupsTableViewController()
}
