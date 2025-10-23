//
//  XdsiduGameMode 2.swift
//  FxiaSpot
//
//  Created by Hades on 10/23/25.
//


import Foundation

enum XdsiduGameMode: String {
    case threeByThree = "3X3"
    case fourByFour = "4X4"
    case fiveByFive = "5X5"

    var leastFindGridSize: Int {
        switch self {
        case .threeByThree: return 3
        case .fourByFour: return 4
        case .fiveByFive: return 5
        }
    }

    var leastFindTotalTiles: Int {
        return leastFindGridSize * leastFindGridSize
    }

    var leastFindMajorityRange: ClosedRange<Int> {
        switch self {
        case .threeByThree: return 5...8
        case .fourByFour: return 9...15
        case .fiveByFive: return 13...24
        }
    }

    var leastFindBaseScore: Int {
        switch self {
        case .threeByThree: return 20
        case .fourByFour: return 40
        case .fiveByFive: return 50
        }
    }
}