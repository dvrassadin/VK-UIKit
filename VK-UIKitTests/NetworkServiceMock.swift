//
//  NetworkServiceSpy.swift
//  VK-UIKitTests
//
//  Created by Daniil Rassadin on 7/12/23.
//

import Foundation
@testable import VK_UIKit

final class NetworkServiceMock: NetworkService {
    private(set) var getFriendsWasCalled = false
    private(set) var getGroupsWasCalled = false
    private(set) var getPhotosWasCalled = false
    private(set) var getUserWasCalled = false
    
    func getFriends(completion: @escaping (Result<[VK_UIKit.Friend], VK_UIKit.NetworkError>) -> Void) {
        getFriendsWasCalled = true
        completion(.success([]))
    }
    
    func getGroups(completion: @escaping (Result<[VK_UIKit.Group], VK_UIKit.NetworkError>) -> Void) {
        getGroupsWasCalled = true
        completion(.success([]))
    }
    
    func getPhotos(completion: @escaping (Result<[VK_UIKit.Photo], VK_UIKit.NetworkError>) -> Void) {
        getPhotosWasCalled = true
        completion(.success([]))
    }
    
    func getUser(with id: Int?, completion: @escaping (Result<[VK_UIKit.User], VK_UIKit.NetworkError>) -> Void) {
        getUserWasCalled = true
        completion(.success([]))
    }
}
