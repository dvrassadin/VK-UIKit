//
//  Photo.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 22/11/23.
//

import Foundation

struct PhotosResponse: Decodable {
    let response: Items
    
    struct Items: Decodable {
        let items: [Photo]
    }
}

//switch size.type {
//case .w: return .w
//case .z: return .z
//case .y: return .y
//case .x: return .x
//case .m: return .m
//case .s: return .s
//}

struct Photo: Decodable {
    private let sizes: [Size]
    var maxSizeURL: URL? {
        let sizeWeight: [SizeType: Int8] = [.w: 6, .z: 5, .y: 4, .x: 3, .m: 2, .s: 1]
        var maxSizeWeight: Int8 = 0
        var maxSizeStringURL = ""
        for size in sizes {
            guard let sizeWeight = sizeWeight[size.type] else { continue }
            if sizeWeight > maxSizeWeight {
                maxSizeStringURL = size.url
                if sizeWeight == 6 { break }
                maxSizeWeight = sizeWeight
            }
            
        }
        return URL(string: maxSizeStringURL)
    }
    
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
