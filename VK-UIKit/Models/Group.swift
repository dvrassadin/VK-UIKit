//
//  Group.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 22/11/23.
//

import UIKit

struct GroupsResponse: Decodable {
    let response: Items
    
    struct Items: Decodable {
        let items: [Group]
    }
}

struct Group: Decodable {
    let id: Int
    let name: String
    let description: String?
    let photo200: String
}
