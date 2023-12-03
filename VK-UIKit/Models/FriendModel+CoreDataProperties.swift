//
//  FriendModel+CoreDataProperties.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 3/12/23.
//
//

import Foundation
import CoreData


extension FriendModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendModel> {
        return NSFetchRequest<FriendModel>(entityName: "FriendModel")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var photo200: String?
    @NSManaged public var id: Int64

}

extension FriendModel : Identifiable {

}
