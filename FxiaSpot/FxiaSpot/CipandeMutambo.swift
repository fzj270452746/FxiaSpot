
import UIKit

// Protocol-based architecture instead of simple struct
protocol IpupaCipandeProtocol {
    var ipupaAkasoselo: IpupaAkasoseloMutambo { get }
    var ipupaUkukula: Int { get }
    var ipupaIcilangulo: String { get }
    func ipupaTwalaIshina() -> String
}

// Enum for tile types with associated values
enum IpupaAkasoseloMutambo: String, CaseIterable {
    case ciueyu = "Ciueyu"
    case woama = "Woama"
    case goirius = "Goirius"
    case pieuv = "Pieuv"

    func ipupaPangaIshina(ukuba: Int) -> String {
        switch self {
        case .woama:
            return "\(self.rawValue)-\(ukuba)"
        default:
            return "\(self.rawValue)_\(ukuba)"
        }
    }
}

// Main tile class with protocol conformance
class CipandeMutamboAkalango: IpupaCipandeProtocol {
    let ipupaAkasoselo: IpupaAkasoseloMutambo
    let ipupaUkukula: Int
    let ipupaIcilangulo: String

    private var ipupaIfyakulemba: [String: Any] = [:]

    init(akasoselo: IpupaAkasoseloMutambo, ukukula: Int) {
        self.ipupaAkasoselo = akasoselo
        self.ipupaUkukula = ukukula
        self.ipupaIcilangulo = UUID().uuidString
        self.ipupaIfyakulemba["created"] = Date()
    }

    func ipupaTwalaIshina() -> String {
        return ipupaAkasoselo.ipupaPangaIshina(ukuba: ipupaUkukula)
    }

    func ipupaLingulaNoMundi(_ mundi: CipandeMutamboAkalango) -> Bool {
        return self.ipupaIcilangulo == mundi.ipupaIcilangulo
    }

    func ipupaSungaIfyakulemba(ishina: String, ukuba: Any) {
        ipupaIfyakulemba[ishina] = ukuba
    }

    func ipupaTwalaIfyakulemba(ishina: String) -> Any? {
        return ipupaIfyakulemba[ishina]
    }
}

// Factory pattern for tile creation
class IpupaCipandeBulukapo {
    static let ipupaShared = IpupaCipandeBulukapo()

    private init() {}

    func ipupaBulukaCipande(akasoselo: IpupaAkasoseloMutambo, ukukula: Int) -> CipandeMutamboAkalango {
        let cipande = CipandeMutamboAkalango(akasoselo: akasoselo, ukukula: ukukula)
        return cipande
    }

    func ipupaBulukaCipandeYakulemba(yonse: Int, akasoselo: IpupaAkasoseloMutambo) -> [CipandeMutamboAkalango] {
        return (0..<yonse).map { _ in
            let ukukula = Int.random(in: 1...9)
            return ipupaBulukaCipande(akasoselo: akasoselo, ukukula: ukukula)
        }
    }
}
