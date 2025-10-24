//
//  DifficultyStrategy.swift
//  FxiaSpot - Strategies
//
//  Game difficulty strategy pattern
//

import Foundation

/// Grid specification value object
struct GridSpecification {
    let dimension: Int
    let minorityRange: ClosedRange<Int>
    let modeId: String

    var totalTiles: Int {
        return dimension * dimension
    }

    var majorityRange: ClosedRange<Int> {
        let lower = totalTiles - minorityRange.upperBound
        let upper = totalTiles - minorityRange.lowerBound
        return lower...upper
    }
}

/// Score calculation engine
struct ScoreEngine {
    let basePoints: Int
    let comboThreshold: Int
    let bonusRate: Double

    init(basePoints: Int, comboThreshold: Int = 3, bonusRate: Double = 0.2) {
        self.basePoints = basePoints
        self.comboThreshold = comboThreshold
        self.bonusRate = bonusRate
    }

    func calculateScore(combo: Int) -> Int {
        guard combo >= comboThreshold else {
            return basePoints
        }

        let multiplier = 1.0 + Double(combo - comboThreshold + 1) * bonusRate
        return Int(Double(basePoints) * multiplier)
    }
}

/// Difficulty strategy protocol
protocol DifficultyStrategy {
    var gridSize: Int { get }
    var totalTiles: Int { get }
    var majorityRange: ClosedRange<Int> { get }
    var modeId: String { get }

    func calculateScore(combo: Int) -> Int
}

/// Base strategy implementation
class BaseDifficultyStrategy: DifficultyStrategy {
    private let specification: GridSpecification
    private let scoreEngine: ScoreEngine

    init(specification: GridSpecification, scoreEngine: ScoreEngine) {
        self.specification = specification
        self.scoreEngine = scoreEngine
    }

    var gridSize: Int {
        return specification.dimension
    }

    var totalTiles: Int {
        return specification.totalTiles
    }

    var majorityRange: ClosedRange<Int> {
        return specification.majorityRange
    }

    var modeId: String {
        return specification.modeId
    }

    func calculateScore(combo: Int) -> Int {
        return scoreEngine.calculateScore(combo: combo)
    }
}

// MARK: - Concrete Strategies

/// Easy mode (3x3 grid)
final class EasyStrategy: BaseDifficultyStrategy {
    init() {
        let spec = GridSpecification(
            dimension: 3,
            minorityRange: 1...4,
            modeId: "3X3"
        )
        let engine = ScoreEngine(basePoints: 20)
        super.init(specification: spec, scoreEngine: engine)
    }
}

/// Medium mode (4x4 grid)
final class MediumStrategy: BaseDifficultyStrategy {
    init() {
        let spec = GridSpecification(
            dimension: 4,
            minorityRange: 1...7,
            modeId: "4X4"
        )
        let engine = ScoreEngine(basePoints: 40)
        super.init(specification: spec, scoreEngine: engine)
    }
}

/// Hard mode (5x5 grid)
final class HardStrategy: BaseDifficultyStrategy {
    init() {
        let spec = GridSpecification(
            dimension: 5,
            minorityRange: 1...12,
            modeId: "5X5"
        )
        let engine = ScoreEngine(basePoints: 50)
        super.init(specification: spec, scoreEngine: engine)
    }
}

// MARK: - Strategy Factory

/// Difficulty level enumeration
enum DifficultyLevel: String, CaseIterable {
    case easy = "3X3"
    case medium = "4X4"
    case hard = "5X5"

    var displayName: String {
        switch self {
        case .easy: return "3 × 3"
        case .medium: return "4 × 4"
        case .hard: return "5 × 5"
        }
    }
}

/// Strategy factory with caching
final class StrategyFactory {
    static let shared = StrategyFactory()

    private var cachedStrategies: [DifficultyLevel: DifficultyStrategy] = [:]
    private let lock = NSLock()

    private init() {}

    func getStrategy(for level: DifficultyLevel) -> DifficultyStrategy {
        lock.lock()
        defer { lock.unlock() }

        if let cached = cachedStrategies[level] {
            return cached
        }

        let strategy: DifficultyStrategy
        switch level {
        case .easy:
            strategy = EasyStrategy()
        case .medium:
            strategy = MediumStrategy()
        case .hard:
            strategy = HardStrategy()
        }

        cachedStrategies[level] = strategy
        return strategy
    }

    func clearCache() {
        lock.lock()
        cachedStrategies.removeAll()
        lock.unlock()
    }
}
