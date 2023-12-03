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
    let photo200: String
    
    let online: Int
    var isOnline: Bool { online != 0 }
}
