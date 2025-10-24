//
//  TileType.swift
//  FxiaSpot - Models
//
//  Tile type enumeration with bitwise operations
//

import Foundation

/// Mahjong tile types using bitwise representation
enum TileType: UInt8, CaseIterable {
    case dots = 0b0001      // 筒 (Ciueyu)
    case characters = 0b0010 // 万 (Woama)
    case bamboo = 0b0100     // 条 (Goirius)
    case seasons = 0b1000    // Reserved for future use

    /// Raw name for the tile type
    var rawName: String {
        switch self {
        case .dots: return "Ciueyu"
        case .characters: return "Woama"
        case .bamboo: return "Goirius"
        case .seasons: return "Pieuv"
        }
    }

    /// Generate image name based on tile type and rank
    func imageName(rank: Int) -> String {
        let separator = (self == .characters) ? "-" : "_"
        return "\(rawName)\(separator)\(rank)"
    }

    /// Display name for UI
    var displayName: String {
        switch self {
        case .dots: return "筒 Dots"
        case .characters: return "万 Characters"
        case .bamboo: return "条 Bamboo"
        case .seasons: return "Seasons"
        }
    }
}
