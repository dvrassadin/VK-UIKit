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
    private let networkService = NetworkService()
    private let dataService = DataService()
    private var groups = [Group]()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Self.name
        tableView.register(
            GroupsTableViewCell.self,
            forCellReuseIdentifier: GroupsTableViewCell.identifier
        )
        groups = dataService.fetchGroups()
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
        groups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GroupsTableViewCell.identifier,
            for: indexPath
        ) as? GroupsTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(with: groups[indexPath.row])
        
        return cell
    }
    
    // MARK: - Setup UI
    
    @objc private func updateGroups() {
        networkService.getGroups { [weak self] result in
            switch result {
            case .success(let groups): self?.groups = groups
            case .failure: DispatchQueue.main.async { self?.showUnableLoadingAlert() }
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                self?.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func showUnableLoadingAlert() {
        let ac = UIAlertController(
            title: "Failed to Load",
            message: "Please try again later.",
            preferredStyle: .alert
        )
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
}
