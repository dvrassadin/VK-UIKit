//
//  DataService.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 1/12/23.
//

import Foundation
import CoreData

final class DataService {
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
            let friendModel = FriendModel(context: Self.persistentContainer.viewContext)
            friendModel.id = Int64(friend.id)
            friendModel.firstName = friend.firstName
            friendModel.lastName = friend.lastName
        }
        if Self.persistentContainer.viewContext.hasChanges {
            addUpdateDate(for: .friend)
        }
        saveContext()
    }
    
    func fetchFriends() -> [Friend] {
        let fetchRequest = FriendModel.fetchRequest()
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
            let groupModel = GroupModel(context: Self.persistentContainer.viewContext)
            groupModel.id = Int64(group.id)
            groupModel.name = group.name
            groupModel.desc = group.description
        }
        if Self.persistentContainer.viewContext.hasChanges {
            addUpdateDate(for: .friend)
        }
        saveContext()
    }
    
    func fetchGroups() -> [Group] {
        let fetchRequest = GroupModel.fetchRequest()
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
    
    private func addUpdateDate(for model: CDEntity) {
        let updateDateModel = UpdateDateModel(context: Self.persistentContainer.viewContext)
        updateDateModel.model = model.rawValue
        updateDateModel.date = Date()
    }
    
    func getUpdateDate(for model: CDEntity) -> Date? {
        let fetchRequest = UpdateDateModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "model = %@", model.rawValue)
        guard let dates = try? Self.persistentContainer.viewContext.fetch(fetchRequest),
              let date = dates.first?.date
        else { return nil }
        return date
    }
    
    enum CDEntity: String {
        case friend, group
    }
}
