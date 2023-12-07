//
//  Model.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 6/12/23.
//

import Foundation

protocol FriendsModel {
    func getSavedFriends() -> [Friend]
    func getFriendsUpdateDate() -> Date?
    func downloadFriends(completion: @escaping (Result<[Friend], NetworkError>) -> Void)
}

protocol GroupsModel {
    func getSavedGroups() -> [Group]
    func getGroupsUpdateDate() -> Date?
    func downloadGroups(completion: @escaping (Result<[Group], NetworkError>) -> Void)
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
    
    init(networkService: NetworkService, dataService: DataService) {
        self.networkService = networkService
        self.dataService = dataService
    }
}

// MARK: - Friends model

extension VKModel: FriendsModel {

    func getSavedFriends() -> [Friend] {
        dataService.fetchFriends()
    }
    
    func getFriendsUpdateDate() -> Date? {
        dataService.getFriendsUpdateDate()
    }
    
    func downloadFriends(completion: @escaping (Result<[Friend], NetworkError>) -> Void) {
        networkService.getFriends { [weak self] result in
            switch result {
            case .success(let friends):
                self?.dataService.add(friends: friends)
                completion(.success(friends))
            case .failure(let error):
                completion(.failure(error))
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
    func getSavedGroups() -> [Group] {
        dataService.fetchGroups()
    }
    
    func getGroupsUpdateDate() -> Date? {
        dataService.getGroupsUpdateDate()
    }
    
    func downloadGroups(completion: @escaping (Result<[Group], NetworkError>) -> Void) {
        networkService.getGroups { [weak self] result in
            switch result {
            case .success(let groups):
                self?.dataService.add(groups: groups)
                completion(.success(groups))
            case .failure(let error):
                completion(.failure(error))
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
