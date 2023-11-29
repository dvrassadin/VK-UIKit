//
//  Photo.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 22/11/23.
//

import Foundation

/// Structure for `photos.get` request.
struct PhotosResponse: Decodable {
    let response: Items
    
    struct Items: Decodable {
        let items: [Photo]
    }
}

struct Photo: Decodable {
    private let sizes: [Size]
    
    func getURL(for size: SizeType) -> URL? {
        if let stringURL = sizes.first(where: { $0.type == size })?.url {
            return URL(string: stringURL)
        } else {
            return nil
        }
    }
    
    private struct Size: Decodable {
        let type: SizeType
        let url: String
    }
    
    enum SizeType: String, Decodable {
        case s, m, x, y, z, w, o, p, q, r
    }
}
