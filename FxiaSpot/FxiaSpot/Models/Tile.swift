//
//  Tile.swift
//  FxiaSpot - Models
//
//  Core tile model with state management
//

import Foundation

/// Tile state flags using bitwise operations
enum TileState: UInt8 {
    case normal = 0b0000
    case selected = 0b0001
    case correct = 0b0010
    case wrong = 0b0100
}

/// Core tile entity
final class Tile {
    // MARK: - Properties
    let type: TileType
    let rank: Int
    let id: String

    private(set) var state: TileState = .normal
    private var metadata: [String: Any] = [:]

    // MARK: - Initialization
    init(type: TileType, rank: Int) {
        self.type = type
        self.rank = rank
        self.id = UUID().uuidString
        self.metadata["createdAt"] = Date()
    }

    // MARK: - Public Methods
    func imageName() -> String {
        return type.imageName(rank: rank)
    }

    func setState(_ newState: TileState) {
        state = newState
    }

    func resetState() {
        state = .normal
    }

    // MARK: - Metadata Management
    func setMetadata(key: String, value: Any) {
        metadata[key] = value
    }

    func getMetadata(key: String) -> Any? {
        return metadata[key]
    }

    // MARK: - Hashable & Equatable
    func hash() -> Int {
        var hasher = Hasher()
        hasher.combine(type.rawValue)
        hasher.combine(rank)
        return hasher.finalize()
    }
}

// MARK: - Tile Factory
final class TileFactory {
    static let shared = TileFactory()

    private init() {}

    /// Create a new tile with specified type and rank
    func createTile(type: TileType, rank: Int) -> Tile {
        return Tile(type: type, rank: rank)
    }

    /// Create a sequence of tiles
    func createTiles(count: Int, type: TileType) -> [Tile] {
        return (0..<count).map { _ in
            createTile(type: type, rank: Int.random(in: 1...9))
        }
    }

    /// Create a random tile
    func createRandomTile() -> Tile {
        let types: [TileType] = [.dots, .characters, .bamboo]
        let type = types.randomElement()!
        let rank = Int.random(in: 1...9)
        return createTile(type: type, rank: rank)
    }
}
