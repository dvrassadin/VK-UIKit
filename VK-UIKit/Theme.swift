//
//  Theme.swift
//  VK-UIKit
//
//  Created by Daniil Rassadin on 1/12/23.
//

import UIKit

final class Theme {
    static private(set) var backgroundColor: UIColor = .systemBackground
    
    static func setBackgroundColor(_ color: BackgroundColor) {
        backgroundColor = color.color
        UserDefaults.standard.set(color.rawValue, forKey: "themeBackgroundColor")
    }
    
    static func load() {
        guard let backgroundColorString = UserDefaults.standard.string(forKey: "themeBackgroundColor"),
              let backgroundColor = BackgroundColor(rawValue: backgroundColorString)
        else { return }
        Self.backgroundColor = backgroundColor.color
    }
    
    enum BackgroundColor: String, CaseIterable {
        case systemBackground = "Default"
        case systemTeal = "Teal"
        case systemMint = "Mint"
        
        var color: UIColor {
            switch self {
            case .systemBackground: return .systemBackground
            case .systemTeal: return .systemTeal
            case .systemMint: return .systemMint
            }
        }
    }
}
