//
//  DataServiceSpy.swift
//  VK-UIKitTests
//
//  Created by Daniil Rassadin on 7/12/23.
//

import Foundation
@testable import VK_UIKit

final class DataServiceSpy: DataService {
    private(set) var fetchFriendsWasCalled = false
    private(set) var getFriendsUpdateDateWasCalled = false
    private(set) var addFriendsWasCalled = false
    private(set) var fetchGroupsWasCalled = false
    private(set) var getGroupsUpdateDateWasCalled = false
    private(set) var addGroupsWasCalled = false
    
    func add(friends: [VK_UIKit.Friend]) {
        addFriendsWasCalled = true
    }
    
    func fetchFriends() -> [VK_UIKit.Friend] {
        fetchFriendsWasCalled = true
        return []
    }
    
    func add(groups: [VK_UIKit.Group]) {
        addGroupsWasCalled = true
    }
    
    func fetchGroups() -> [VK_UIKit.Group] {
        fetchGroupsWasCalled = true
        return []
    }
    
    func getFriendsUpdateDate() -> Date? {
        getFriendsUpdateDateWasCalled = true
        return nil
    }
    
    func getGroupsUpdateDate() -> Date? {
        getGroupsUpdateDateWasCalled = true
        return nil
    }
}
