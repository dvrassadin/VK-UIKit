//
//  GroupsTableViewController.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 17/11/23.
//

import UIKit

final class GroupsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    static let name = "Groups"
    private let groupsModel: GroupsModel
    
    //MARK: - Lifecycle
    
    init(groupsModel: GroupsModel) {
        self.groupsModel = groupsModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Self.name
        tableView.register(
            GroupsTableViewCell.self,
            forCellReuseIdentifier: GroupsTableViewCell.identifier
        )
        updateGroups()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.title = Self.name
        tableView.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(
            self,
            action: #selector(updateGroups),
            for: .valueChanged
        )
        tabBarController?.navigationItem.rightBarButtonItem = nil
        view.backgroundColor = Theme.backgroundColor
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        groupsModel.groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GroupsTableViewCell.identifier,
            for: indexPath
        ) as? GroupsTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: groupsModel.groups[indexPath.row])
        
        return cell
    }
    
    // MARK: - Setup UI
    
    @objc private func updateGroups() {
        groupsModel.downloadGroups { [weak self] result in
            if !result {
                DispatchQueue.main.async { self?.showUnableLoadingAlert() }
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func showUnableLoadingAlert() {
        var dateMessage = ""
        if let date = groupsModel.getGroupsUpdateDate() {
            dateMessage = "The last update was on \(date.formatted()).\n"
        }
        let ac = UIAlertController(
            title: "Failed to Load",
            message: "\(dateMessage)Please try again later.",
            preferredStyle: .alert
        )
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
