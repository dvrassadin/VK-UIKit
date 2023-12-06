//
//  Friend.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 22/11/23.
//

import Foundation

struct FriendsResponse: Decodable {
    let response: Items
    
    struct Items: Decodable {
        let items: [Friend]
    }
}

struct Friend: Decodable {
    let id: Int
    let firstName: String
    let lastName: String
    let photo200: String?
    
    private let online: Int
    var isOnline: Bool { online != 0 }
    
    init(id: Int, firstName: String, lastName: String, photo200: String? = nil) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photo200 = photo200
        online = 0
    }
}
