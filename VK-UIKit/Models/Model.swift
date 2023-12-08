//
//  Model.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 6/12/23.
//

import Foundation

protocol FriendsModel {
    var friends: [Friend] { get }
    func getFriendsUpdateDate() -> Date?
    func downloadFriends(completion: @escaping (Bool) -> Void)
}

protocol GroupsModel {
    var groups: [Group] { get }
    func getGroupsUpdateDate() -> Date?
    func downloadGroups(completion: @escaping (Bool) -> Void)
}

protocol PhotosModel {
    func downloadPhotos(completion: @escaping (Result<[Photo], NetworkError>) -> Void)
}

protocol UserModel {
    func downloadUser(with id: Int?, completion: @escaping (Result<[User], NetworkError>) -> Void)
}

final class VKModel {
    private let networkService: NetworkService
    private let dataService: DataService
    private(set) var friends: [Friend]
    private(set) var groups: [Group]
    
    init(networkService: NetworkService, dataService: DataService) {
        self.networkService = networkService
        self.dataService = dataService
        friends = dataService.fetchFriends()
        groups = dataService.fetchGroups()
    }
}

// MARK: - Friends model

extension VKModel: FriendsModel {
    func getFriendsUpdateDate() -> Date? {
        dataService.getFriendsUpdateDate()
    }
    
    func downloadFriends(completion: @escaping (Bool) -> Void) {
        networkService.getFriends { [weak self] result in
            switch result {
            case .success(let friends):
                self?.friends = friends
                self?.dataService.add(friends: friends)
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}

// MARK: - User model

extension VKModel: UserModel {
    func downloadUser(with id: Int?, completion: @escaping (Result<[User], NetworkError>) -> Void) {
        networkService.getUser(with: id) { result in
            completion(result)
        }
    }
}

// MARK: - Groups model

extension VKModel: GroupsModel {
    func getGroupsUpdateDate() -> Date? {
        dataService.getGroupsUpdateDate()
    }
    
    func downloadGroups(completion: @escaping (Bool) -> Void) {
        networkService.getGroups { [weak self] result in
            switch result {
            case .success(let groups):
                self?.groups = groups
                self?.dataService.add(groups: groups)
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}

// MARK: - Photos model

extension VKModel: PhotosModel {
    func downloadPhotos(completion: @escaping (Result<[Photo], NetworkError>) -> Void) {
        networkService.getPhotos { result in
            completion(result)
        }
    }
}
