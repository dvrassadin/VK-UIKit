//
//  User.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 22/11/23.
//

import Foundation

struct User: VKContent {
    let firstName: String
    let lastName: String
    let photo200: String
    
    private let online: Int
    var isOnline: Bool { online != 0 }
}
