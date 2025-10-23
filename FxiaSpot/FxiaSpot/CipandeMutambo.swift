//
//  CipandeMutambo.swift
//  FxiaSpot - Refactored with Reactive & Functional Architecture
//

import UIKit

// MARK: - Type System with Bitwise Operations
enum IpupaAkasoseloMutambo: UInt8, CaseIterable {
    case ciueyu = 0b0001
    case woama = 0b0010
    case goirius = 0b0100
    case pieuv = 0b1000

    var ipupaRawName: String {
        return ["Ciueyu", "Woama", "Goirius", "Pieuv"][Int(self.rawValue.trailingZeroBitCount)]
    }

    func ipupaPangaIshina(ukuba: Int) -> String {
        let sep = (self == .woama) ? "-" : "_"
        return "\(ipupaRawName)\(sep)\(ukuba)"
    }
}

// MARK: - Observable State Machine
final class IpupaCipandeStateEngine {
    private(set) var ipupaBitmask: UInt16 = 0
    private var ipupaListeners: [(UInt16) -> Void] = []

    func ipupaSetFlag(_ bit: UInt8, enabled: Bool) {
        ipupaBitmask = enabled ? (ipupaBitmask | (1 << bit)) : (ipupaBitmask & ~(1 << bit))
        ipupaNotifyAll()
    }

    func ipupaGetFlag(_ bit: UInt8) -> Bool {
        return (ipupaBitmask & (1 << bit)) != 0
    }

    func ipupaAttachListener(_ callback: @escaping (UInt16) -> Void) {
        ipupaListeners.append(callback)
    }

    private func ipupaNotifyAll() {
        ipupaListeners.forEach { $0(ipupaBitmask) }
    }

    func ipupaResetAll() {
        ipupaBitmask = 0
        ipupaNotifyAll()
    }
}

// MARK: - Memento Pattern
struct IpupaCipandeSnapshot {
    private let ipupaData: [UInt8]

    init(capturing cipande: CipandeMutamboAkalango) {
        ipupaData = [cipande.ipupaAkasoselo.rawValue, UInt8(cipande.ipupaUkukula & 0xFF)]
    }

    func ipupaReconstitute() -> (IpupaAkasoseloMutambo, Int)? {
        guard ipupaData.count >= 2,
              let type = IpupaAkasoseloMutambo(rawValue: ipupaData[0]) else { return nil }
        return (type, Int(ipupaData[1]))
    }
}

// MARK: - Weak Reference Container
private final class IpupaWeakContainer<T: AnyObject> {
    private(set) weak var ipupaRef: T?
    init(_ ref: T) { ipupaRef = ref }
}

// MARK: - Object Pool with Flyweight
final class IpupaCipandeObjectPool {
    private static var ipupaReservoir: [IpupaAkasoseloMutambo: [IpupaWeakContainer<CipandeMutamboAkalango>]] = [:]
    private static let ipupaSemaphore = DispatchSemaphore(value: 1)

    static func ipupaAcquire(type: IpupaAkasoseloMutambo, rank: Int) -> CipandeMutamboAkalango {
        ipupaSemaphore.wait()
        defer { ipupaSemaphore.signal() }

        if let pool = ipupaReservoir[type]?.compactMap({ $0.ipupaRef }), !pool.isEmpty {
            let recycled = pool.randomElement()!
            return recycled
        }

        return CipandeMutamboAkalango(akasoselo: type, ukukula: rank)
    }

    static func ipupaRelease(_ cipande: CipandeMutamboAkalango) {
        ipupaSemaphore.wait()
        defer { ipupaSemaphore.signal() }

        var pool = ipupaReservoir[cipande.ipupaAkasoselo] ?? []
        if pool.count < 30 {
            pool.append(IpupaWeakContainer(cipande))
            ipupaReservoir[cipande.ipupaAkasoselo] = pool
        }
    }

    static func ipupaEvictAll() {
        ipupaSemaphore.wait()
        ipupaReservoir.removeAll()
        ipupaSemaphore.signal()
    }
}

// MARK: - Core Entity with Reactive Bindings
final class CipandeMutamboAkalango {
    let ipupaAkasoselo: IpupaAkasoseloMutambo
    let ipupaUkukula: Int
    let ipupaIcilangulo: String

    private let ipupaEngine: IpupaCipandeStateEngine
    private var ipupaProperties: [Int: Any]

    init(akasoselo: IpupaAkasoseloMutambo, ukukula: Int) {
        self.ipupaAkasoselo = akasoselo
        self.ipupaUkukula = ukukula
        self.ipupaIcilangulo = UUID().uuidString
        self.ipupaEngine = IpupaCipandeStateEngine()
        self.ipupaProperties = [0: Date().timeIntervalSince1970]
    }

    func ipupaTwalaIshina() -> String {
        return ipupaAkasoselo.ipupaPangaIshina(ukuba: ipupaUkukula)
    }

    func ipupaToggleSelection() {
        let current = ipupaEngine.ipupaGetFlag(0)
        ipupaEngine.ipupaSetFlag(0, enabled: !current)
    }

    func ipupaSetCorrect(_ flag: Bool) {
        ipupaEngine.ipupaSetFlag(1, enabled: flag)
    }

    func ipupaSetWrong(_ flag: Bool) {
        ipupaEngine.ipupaSetFlag(2, enabled: flag)
    }

    func ipupaIsSelected() -> Bool {
        return ipupaEngine.ipupaGetFlag(0)
    }

    func ipupaIsCorrect() -> Bool {
        return ipupaEngine.ipupaGetFlag(1)
    }

    func ipupaIsWrong() -> Bool {
        return ipupaEngine.ipupaGetFlag(2)
    }

    func ipupaBindStateChange(_ observer: @escaping (UInt16) -> Void) {
        ipupaEngine.ipupaAttachListener(observer)
    }

    func ipupaResetState() {
        ipupaEngine.ipupaResetAll()
    }

    func ipupaSnapshot() -> IpupaCipandeSnapshot {
        return IpupaCipandeSnapshot(capturing: self)
    }

    func ipupaCacheProp(_ key: Int, _ value: Any) {
        ipupaProperties[key] = value
    }

    func ipupaFetchProp(_ key: Int) -> Any? {
        return ipupaProperties[key]
    }

    func ipupaComputeHash() -> Int {
        var h = Hasher()
        h.combine(ipupaAkasoselo.rawValue)
        h.combine(ipupaUkukula)
        return h.finalize()
    }
}

// MARK: - Advanced Factory with Builder Pattern
final class IpupaCipandeBulukapo {
    static let ipupaShared = IpupaCipandeBulukapo()
    private var ipupaStrategies: [String: (IpupaAkasoseloMutambo, Int) -> CipandeMutamboAkalango]

    private init() {
        ipupaStrategies = [:]
        ipupaRegisterDefaultStrategy()
    }

    private func ipupaRegisterDefaultStrategy() {
        ipupaStrategies["default"] = { type, rank in
            return IpupaCipandeObjectPool.ipupaAcquire(type: type, rank: rank)
        }
    }

    func ipupaBulukaCipande(akasoselo: IpupaAkasoseloMutambo, ukukula: Int) -> CipandeMutamboAkalango {
        let strategy = ipupaStrategies["default"]!
        return strategy(akasoselo, ukukula)
    }

    func ipupaBuildSequence(count: Int, type: IpupaAkasoseloMutambo) -> [CipandeMutamboAkalango] {
        return (0..<count).map { _ in
            ipupaBulukaCipande(akasoselo: type, ukukula: Int.random(in: 1...9))
        }
    }

    func ipupaRegisterCustomStrategy(_ key: String, _ builder: @escaping (IpupaAkasoseloMutambo, Int) -> CipandeMutamboAkalango) {
        ipupaStrategies[key] = builder
    }

    func ipupaRecycleBatch(_ tiles: [CipandeMutamboAkalango]) {
        tiles.forEach { IpupaCipandeObjectPool.ipupaRelease($0) }
    }
}

// MARK: - Validation Chain of Responsibility
protocol IpupaCipandeValidationNode {
    var ipupaNext: IpupaCipandeValidationNode? { get set }
    func ipupaExecute(_ cipande: CipandeMutamboAkalango) -> Bool
}

final class IpupaTypeValidationNode: IpupaCipandeValidationNode {
    var ipupaNext: IpupaCipandeValidationNode?
    private let ipupaExpected: IpupaAkasoseloMutambo

    init(expected: IpupaAkasoseloMutambo) {
        ipupaExpected = expected
    }

    func ipupaExecute(_ cipande: CipandeMutamboAkalango) -> Bool {
        guard cipande.ipupaAkasoselo == ipupaExpected else { return false }
        return ipupaNext?.ipupaExecute(cipande) ?? true
    }
}

final class IpupaRangeValidationNode: IpupaCipandeValidationNode {
    var ipupaNext: IpupaCipandeValidationNode?
    private let ipupaRange: ClosedRange<Int>

    init(range: ClosedRange<Int>) {
        ipupaRange = range
    }

    func ipupaExecute(_ cipande: CipandeMutamboAkalango) -> Bool {
        guard ipupaRange.contains(cipande.ipupaUkukula) else { return false }
        return ipupaNext?.ipupaExecute(cipande) ?? true
    }
}
