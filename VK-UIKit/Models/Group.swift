//
//  Group.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 22/11/23.
//

import UIKit

/// Structure for `groups.get` request.
struct GroupsResponse: Decodable {
    let response: Items
    
    struct Items: Decodable {
        let items: [Group]
    }
}

struct Group: Decodable {
    let name: String
    let description: String?
    
    private let photo200: String
    var photo: UIImage? {        
        get async {
            guard let url = URL(string: photo200),
                  let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data)
            else { return nil }
            return image
        }
    }
}
