//
//  VKContent.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 22/11/23.
//

import Foundation

protocol VKContent: Decodable { }

struct VKResponse<T: VKContent>: Decodable {
    let response: VKItems
    
    struct VKItems: Decodable {
        let items: [T]
    }
}
