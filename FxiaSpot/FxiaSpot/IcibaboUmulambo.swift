//
//  IcibaboUmulambo.swift
//  FxiaSpot - Completely Refactored with Functional Composition
//

import Foundation

// MARK: - Configuration Value Objects (Immutable)
struct IpupaGridSpecification {
    private let dimension: Int
    private let minorityBounds: ClosedRange<Int>
    private let code: String

    init(dim: Int, minority: ClosedRange<Int>, id: String) {
        dimension = dim
        minorityBounds = minority
        code = id
    }

    var ipupaDimension: Int { dimension }
    var ipupaTotal: Int { dimension * dimension }
    var ipupaMinority: ClosedRange<Int> { minorityBounds }
    var ipupaMajority: ClosedRange<Int> {
        let lower = ipupaTotal - minorityBounds.upperBound
        let upper = ipupaTotal - minorityBounds.lowerBound
        return lower...upper
    }
    var ipupaCode: String { code }
}

// MARK: - Score Computation Engine (Pure Functions)
struct IpupaScoreEngine {
    typealias ComputeFunc = (Int, Int) -> Int

    private let basePoints: Int
    private let comboActivation: Int
    private let bonusRate: Double

    init(base: Int, activation: Int = 3, rate: Double = 0.2) {
        basePoints = base
        comboActivation = activation
        bonusRate = rate
    }

    private func ipupaLinearScore(_ combo: Int) -> Int {
        return basePoints
    }

    private func ipupaMultipliedScore(_ combo: Int) -> Int {
        let bonus = 1.0 + Double(combo - comboActivation + 1) * bonusRate
        return Int(Double(basePoints) * bonus)
    }

    func ipupaCalculate(combo: Int) -> Int {
        return combo < comboActivation ? ipupaLinearScore(combo) : ipupaMultipliedScore(combo)
    }

    var ipupaAsFunction: ComputeFunc {
        return { [self] combo, _ in self.ipupaCalculate(combo: combo) }
    }
}

// MARK: - Strategy Protocol (Purely Behavioral)
protocol IpupaIcibaboStrategy {
    var ipupaUbuneneAkatambo: Int { get }
    var ipupaYonseCipande: Int { get }
    var ipupaUkulangaIngi: ClosedRange<Int> { get }
    var ipupaIshina: String { get }
    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int
    func ipupaTwalaIshina() -> String
}

// MARK: - Base Strategy Template (Composition over Inheritance)
fileprivate struct IpupaBaseStrategyImpl: IpupaIcibaboStrategy {
    private let spec: IpupaGridSpecification
    private let engine: IpupaScoreEngine

    init(specification: IpupaGridSpecification, scoreEngine: IpupaScoreEngine) {
        spec = specification
        engine = scoreEngine
    }

    var ipupaUbuneneAkatambo: Int { spec.ipupaDimension }
    var ipupaYonseCipande: Int { spec.ipupaTotal }
    var ipupaUkulangaIngi: ClosedRange<Int> { spec.ipupaMajority }
    var ipupaIshina: String { spec.ipupaCode }

    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int {
        return engine.ipupaCalculate(combo: ukupitilizya)
    }

    func ipupaTwalaIshina() -> String { ipupaIshina }
}

// MARK: - Concrete Strategy Wrappers
final class IpupaIcibaboTatuStrategy: IpupaIcibaboStrategy {
    private lazy var impl: IpupaIcibaboStrategy = {
        let gridSpec = IpupaGridSpecification(dim: 3, minority: 1...4, id: "3X3")
        let scoreCalc = IpupaScoreEngine(base: 20)
        return IpupaBaseStrategyImpl(specification: gridSpec, scoreEngine: scoreCalc)
    }()

    var ipupaUbuneneAkatambo: Int { impl.ipupaUbuneneAkatambo }
    var ipupaYonseCipande: Int { impl.ipupaYonseCipande }
    var ipupaUkulangaIngi: ClosedRange<Int> { impl.ipupaUkulangaIngi }
    var ipupaIshina: String { impl.ipupaIshina }

    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int {
        impl.ipupaBalaIfyalulwa(ukupitilizya: ukupitilizya)
    }

    func ipupaTwalaIshina() -> String { impl.ipupaTwalaIshina() }
}

final class IpupaIcibaboNaStrategy: IpupaIcibaboStrategy {
    private lazy var impl: IpupaIcibaboStrategy = {
        let gridSpec = IpupaGridSpecification(dim: 4, minority: 1...7, id: "4X4")
        let scoreCalc = IpupaScoreEngine(base: 40)
        return IpupaBaseStrategyImpl(specification: gridSpec, scoreEngine: scoreCalc)
    }()

    var ipupaUbuneneAkatambo: Int { impl.ipupaUbuneneAkatambo }
    var ipupaYonseCipande: Int { impl.ipupaYonseCipande }
    var ipupaUkulangaIngi: ClosedRange<Int> { impl.ipupaUkulangaIngi }
    var ipupaIshina: String { impl.ipupaIshina }

    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int {
        impl.ipupaBalaIfyalulwa(ukupitilizya: ukupitilizya)
    }

    func ipupaTwalaIshina() -> String { impl.ipupaTwalaIshina() }
}

final class IpupaIcibaboSanoStrategy: IpupaIcibaboStrategy {
    private lazy var impl: IpupaIcibaboStrategy = {
        let gridSpec = IpupaGridSpecification(dim: 5, minority: 1...12, id: "5X5")
        let scoreCalc = IpupaScoreEngine(base: 50)
        return IpupaBaseStrategyImpl(specification: gridSpec, scoreEngine: scoreCalc)
    }()

    var ipupaUbuneneAkatambo: Int { impl.ipupaUbuneneAkatambo }
    var ipupaYonseCipande: Int { impl.ipupaYonseCipande }
    var ipupaUkulangaIngi: ClosedRange<Int> { impl.ipupaUkulangaIngi }
    var ipupaIshina: String { impl.ipupaIshina }

    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int {
        impl.ipupaBalaIfyalulwa(ukupitilizya: ukupitilizya)
    }

    func ipupaTwalaIshina() -> String { impl.ipupaTwalaIshina() }
}

// MARK: - Strategy Factory with Memoization
final class IpupaIcibaboFactory {
    enum IpupaIcibaboType: UInt8 {
        case tatu = 0
        case na = 1
        case sano = 2

        fileprivate var ipupaBuilder: () -> IpupaIcibaboStrategy {
            switch self {
            case .tatu: return { IpupaIcibaboTatuStrategy() }
            case .na: return { IpupaIcibaboNaStrategy() }
            case .sano: return { IpupaIcibaboSanoStrategy() }
            }
        }
    }

    private static var ipupaStrategies: [UInt8: IpupaIcibaboStrategy] = [:]
    private static let ipupaAccess = NSLock()

    static func ipupaBulukaStrategy(ubwalo: IpupaIcibaboType) -> IpupaIcibaboStrategy {
        ipupaAccess.lock()
        defer { ipupaAccess.unlock() }

        if let existing = ipupaStrategies[ubwalo.rawValue] {
            return existing
        }

        let fresh = ubwalo.ipupaBuilder()
        ipupaStrategies[ubwalo.rawValue] = fresh
        return fresh
    }

    static func ipupaInvalidateCache() {
        ipupaAccess.lock()
        ipupaStrategies.removeAll()
        ipupaAccess.unlock()
    }
}

// MARK: - Context with Observable State
final class IcibaboUmulamboMupangapo {
    private var ipupaActive: IpupaIcibaboStrategy
    private var ipupaObservers: [(IpupaIcibaboStrategy, IpupaIcibaboStrategy) -> Void]

    init(strategy: IpupaIcibaboStrategy) {
        ipupaActive = strategy
        ipupaObservers = []
    }

    func ipupaBumbwaStrategy(_ replacement: IpupaIcibaboStrategy) {
        let previous = ipupaActive
        ipupaActive = replacement
        ipupaObservers.forEach { $0(previous, replacement) }
    }

    func ipupaSubscribeTransition(_ callback: @escaping (IpupaIcibaboStrategy, IpupaIcibaboStrategy) -> Void) {
        ipupaObservers.append(callback)
    }

    func ipupaTwalaUbunene() -> Int {
        ipupaActive.ipupaUbuneneAkatambo
    }

    func ipupaTwalaYonse() -> Int {
        ipupaActive.ipupaYonseCipande
    }

    func ipupaTwalaUkulangaIngi() -> ClosedRange<Int> {
        ipupaActive.ipupaUkulangaIngi
    }

    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int {
        ipupaActive.ipupaBalaIfyalulwa(ukupitilizya: ukupitilizya)
    }

    func ipupaTwalaIshina() -> String {
        ipupaActive.ipupaIshina
    }

    func ipupaGetCurrent() -> IpupaIcibaboStrategy {
        ipupaActive
    }
}
