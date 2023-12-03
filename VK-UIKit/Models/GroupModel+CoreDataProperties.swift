//
//  GroupModel+CoreDataProperties.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 3/12/23.
//
//

import Foundation
import CoreData


extension GroupModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupModel> {
        return NSFetchRequest<GroupModel>(entityName: "GroupModel")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var desc: String?
    @NSManaged public var photo200: String?

}

extension GroupModel : Identifiable {

}
