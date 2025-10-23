
import Foundation

// Strategy pattern instead of simple enum
protocol IpupaIcibaboStrategy {
    var ipupaUbuneneAkatambo: Int { get }
    var ipupaYonseCipande: Int { get }
    var ipupaUkulangaIngi: ClosedRange<Int> { get }
    var ipupaIshina: String { get }
    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int
    func ipupaTwalaIshina() -> String
}

// Concrete strategies for each mode
class IpupaIcibaboTatuStrategy: IpupaIcibaboStrategy {
    let ipupaUbuneneAkatambo: Int = 3
    var ipupaYonseCipande: Int { ipupaUbuneneAkatambo * ipupaUbuneneAkatambo }
    let ipupaUkulangaIngi: ClosedRange<Int> = 5...8
    let ipupaIshina: String = "3X3"

    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int {
        let icalo = 20
        return ukupitilizya >= 3 ? Int(Double(icalo) * (1.0 + Double(ukupitilizya - 2) * 0.2)) : icalo
    }

    func ipupaTwalaIshina() -> String { return ipupaIshina }
}

class IpupaIcibaboNaStrategy: IpupaIcibaboStrategy {
    let ipupaUbuneneAkatambo: Int = 4
    var ipupaYonseCipande: Int { ipupaUbuneneAkatambo * ipupaUbuneneAkatambo }
    let ipupaUkulangaIngi: ClosedRange<Int> = 9...15
    let ipupaIshina: String = "4X4"

    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int {
        let icalo = 40
        return ukupitilizya >= 3 ? Int(Double(icalo) * (1.0 + Double(ukupitilizya - 2) * 0.2)) : icalo
    }

    func ipupaTwalaIshina() -> String { return ipupaIshina }
}

class IpupaIcibaboSanoStrategy: IpupaIcibaboStrategy {
    let ipupaUbuneneAkatambo: Int = 5
    var ipupaYonseCipande: Int { ipupaUbuneneAkatambo * ipupaUbuneneAkatambo }
    let ipupaUkulangaIngi: ClosedRange<Int> = 13...24
    let ipupaIshina: String = "5X5"

    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int {
        let icalo = 50
        return ukupitilizya >= 3 ? Int(Double(icalo) * (1.0 + Double(ukupitilizya - 2) * 0.2)) : icalo
    }

    func ipupaTwalaIshina() -> String { return ipupaIshina }
}

// Context class
class IcibaboUmulamboMupangapo {
    private var ipupaStrategy: IpupaIcibaboStrategy

    init(strategy: IpupaIcibaboStrategy) {
        self.ipupaStrategy = strategy
    }

    func ipupaBumbwaStrategy(_ upya: IpupaIcibaboStrategy) {
        self.ipupaStrategy = upya
    }

    func ipupaTwalaUbunene() -> Int {
        return ipupaStrategy.ipupaUbuneneAkatambo
    }

    func ipupaTwalaYonse() -> Int {
        return ipupaStrategy.ipupaYonseCipande
    }

    func ipupaTwalaUkulangaIngi() -> ClosedRange<Int> {
        return ipupaStrategy.ipupaUkulangaIngi
    }

    func ipupaBalaIfyalulwa(ukupitilizya: Int) -> Int {
        return ipupaStrategy.ipupaBalaIfyalulwa(ukupitilizya: ukupitilizya)
    }

    func ipupaTwalaIshina() -> String {
        return ipupaStrategy.ipupaIshina
    }
}

// Factory for creating strategies
class IpupaIcibaboFactory {
    enum IpupaIcibaboType {
        case tatu, na, sano
    }

    static func ipupaBulukaStrategy(ubwalo: IpupaIcibaboType) -> IpupaIcibaboStrategy {
        switch ubwalo {
        case .tatu: return IpupaIcibaboTatuStrategy()
        case .na: return IpupaIcibaboNaStrategy()
        case .sano: return IpupaIcibaboSanoStrategy()
        }
    }
}
