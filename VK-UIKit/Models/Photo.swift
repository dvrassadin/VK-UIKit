//
//  Photo.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 22/11/23.
//

import Foundation

struct Photo: VKContent {
    let sizes: [Size]
    
    struct Size: Decodable {
        let type: SizeType
        let url: String
        
        enum SizeType: String, Decodable {
            case s, m, x, y, z, w, o, p, q, r
        }
    }
}
