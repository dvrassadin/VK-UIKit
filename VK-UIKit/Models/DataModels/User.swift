//
//  User.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 29/11/23.
//

import Foundation

struct UsersResponse: Decodable {
    let response: [User]
}

struct User: Decodable {
    let firstName: String
    let lastName: String
    let photo400Orig: String
}

