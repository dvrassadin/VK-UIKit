//
//  DataService.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 1/12/23.
//

import Foundation
import CoreData

protocol DataService {
    func add(friends: [Friend])
    func fetchFriends() -> [Friend]
    func add(groups: [Group])
    func fetchGroups() -> [Group]
    func getFriendsUpdateDate() -> Date?
    func getGroupsUpdateDate() -> Date?
}

final class VKDataService: DataService {
    private static let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { _, error in
            if let error {
                print(error)
            }
        }
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return container
    }()
    
    func saveContext() {
        if Self.persistentContainer.viewContext.hasChanges {
            do {
                try Self.persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func add(friends: [Friend]) {
        for friend in friends {
            let friendModel = FriendCD(context: Self.persistentContainer.viewContext)
            friendModel.id = Int64(friend.id)
            friendModel.firstName = friend.firstName
            friendModel.lastName = friend.lastName
        }
        if Self.persistentContainer.viewContext.hasChanges {
            addFriendsUpdateDate()
        }
        saveContext()
    }
    
    func fetchFriends() -> [Friend] {
        let fetchRequest = FriendCD.fetchRequest()
        guard let friendModels = try? Self.persistentContainer.viewContext.fetch(fetchRequest) else { return [] }
        var friends = [Friend]()
        for friendModel in friendModels {
            guard let firstName = friendModel.firstName,
                  let lastName = friendModel.lastName
            else { continue }
            
            friends.append(
                Friend(id: Int(friendModel.id), firstName: firstName, lastName: lastName))
        }
        return friends
    }
    
    func add(groups: [Group]) {
        for group in groups {
            let groupModel = GroupCD(context: Self.persistentContainer.viewContext)
            groupModel.id = Int64(group.id)
            groupModel.name = group.name
            groupModel.desc = group.description
        }
        if Self.persistentContainer.viewContext.hasChanges {
            addGroupsUpdateDate()
        }
        saveContext()
    }
    
    func fetchGroups() -> [Group] {
        let fetchRequest = GroupCD.fetchRequest()
        guard let groupModels = try? Self.persistentContainer.viewContext.fetch(fetchRequest) else { return [] }
        var groups = [Group]()
        for groupModel in groupModels {
            guard let name = groupModel.name,
                  let description = groupModel.desc
            else { continue }
            
            groups.append(Group(id: Int(groupModel.id), name: name, description: description, photo200: nil))
        }
        return groups
    }
    
    private func addFriendsUpdateDate() {
        let updateDateModel = UpdateDateCD(context: Self.persistentContainer.viewContext)
        updateDateModel.model = "friends"
        updateDateModel.date = Date()
    }
    
    private func addGroupsUpdateDate() {
        let updateDateModel = UpdateDateCD(context: Self.persistentContainer.viewContext)
        updateDateModel.model = "groups"
        updateDateModel.date = Date()
    }
    
    func getFriendsUpdateDate() -> Date? {
        let fetchRequest = UpdateDateCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "model = %@", "friends")
        guard let dates = try? Self.persistentContainer.viewContext.fetch(fetchRequest),
              let date = dates.first?.date
        else { return nil }
        return date
    }
    
    func getGroupsUpdateDate() -> Date? {
        let fetchRequest = UpdateDateCD.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "model = %@", "groups")
        guard let dates = try? Self.persistentContainer.viewContext.fetch(fetchRequest),
              let date = dates.first?.date
        else { return nil }
        return date
    }
}
