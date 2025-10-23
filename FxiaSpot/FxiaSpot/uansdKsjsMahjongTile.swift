//
//  LeastFindMahjongTile.swift
//  FxiaSpot
//
//  Created by Claude on 2025-01-23.
//

import UIKit

enum LeastFindTileType: String, CaseIterable {
    case ciueyu = "Ciueyu"
    case woama = "Woama"
    case goirius = "Goirius"
    case pieuv = "Pieuv"
}

struct uansdKsjsMahjongTile: Equatable {
    let leastFindType: LeastFindTileType
    let leastFindValue: Int
    let leastFindId: String

    init(leastFindType: LeastFindTileType, leastFindValue: Int) {
        self.leastFindType = leastFindType
        self.leastFindValue = leastFindValue
        self.leastFindId = UUID().uuidString
    }

    var leastFindImageName: String {
        if leastFindType == .woama {
            return "\(leastFindType.rawValue)-\(leastFindValue)"
        } else {
            return "\(leastFindType.rawValue)_\(leastFindValue)"
        }
    }

    static func == (lhs: uansdKsjsMahjongTile, rhs: uansdKsjsMahjongTile) -> Bool {
        return lhs.leastFindId == rhs.leastFindId
    }
}
