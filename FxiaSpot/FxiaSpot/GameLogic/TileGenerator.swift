//
//  TileGenerator.swift
//  FxiaSpot - GameLogic
//
//  Tile generation logic with Fisher-Yates shuffle
//

import Foundation

/// Tile generation result
struct TileGenerationResult {
    let tiles: [Tile]
    let minorityTiles: Set<String>
    let majorityType: TileType

    var minorityCount: Int {
        return minorityTiles.count
    }

    var majorityCount: Int {
        return tiles.count - minorityCount
    }
}

/// Tile generator using strategy pattern
final class TileGenerator {
    private let strategy: DifficultyStrategy
    private let tileFactory: TileFactory

    init(strategy: DifficultyStrategy, tileFactory: TileFactory = .shared) {
        self.strategy = strategy
        self.tileFactory = tileFactory
    }

    /// Generate tiles for a round
    func generateTiles() -> TileGenerationResult {
        let totalTiles = strategy.totalTiles
        let minorityCount = Int.random(in: (totalTiles - strategy.majorityRange.upperBound)...(totalTiles - strategy.majorityRange.lowerBound))

        // Select majority type
        let availableTypes: [TileType] = [.dots, .characters, .bamboo]
        let majorityType = availableTypes.randomElement()!

        // Generate majority tiles
        var tiles: [Tile] = []
        let majorityCount = totalTiles - minorityCount

        for _ in 0..<majorityCount {
            let rank = Int.random(in: 1...9)
            let tile = tileFactory.createTile(type: majorityType, rank: rank)
            tiles.append(tile)
        }

        // Generate minority tiles
        var minorityIds = Set<String>()
        let minorityTypes = availableTypes.filter { $0 != majorityType }

        for _ in 0..<minorityCount {
            let type = minorityTypes.randomElement()!
            let rank = Int.random(in: 1...9)
            let tile = tileFactory.createTile(type: type, rank: rank)
            tiles.append(tile)
            minorityIds.insert(tile.id)
        }

        // Shuffle using Fisher-Yates algorithm
        let shuffledTiles = fisherYatesShuffle(tiles)

        return TileGenerationResult(
            tiles: shuffledTiles,
            minorityTiles: minorityIds,
            majorityType: majorityType
        )
    }

    /// Fisher-Yates shuffle algorithm
    private func fisherYatesShuffle(_ array: [Tile]) -> [Tile] {
        var result = array
        for i in stride(from: result.count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            result.swapAt(i, j)
        }
        return result
    }
}
