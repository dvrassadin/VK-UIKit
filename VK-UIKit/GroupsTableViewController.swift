//
//  GroupsTableViewController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 17/11/23.
//

import UIKit

final class GroupsTableViewController: UITableViewController {

    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Groups"
        tableView.register(
            GroupsTableViewCell.self,
            forCellReuseIdentifier: GroupsTableViewCell.identifier
        )
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
