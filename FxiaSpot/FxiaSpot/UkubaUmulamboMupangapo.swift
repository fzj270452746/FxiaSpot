
import Foundation

// Observer protocol
protocol IpupaUkubaObserver: AnyObject {
    func ipupaIfyalulwaBumbwa(ifya: Int)
    func ipupaUkupitilizyaBumbwa(ukupitilizya: Int)
    func ipupaUmuzungulukoMalilwa()
}

// State machine for game states
enum IpupaUkubaUmulambo {
    case ipupaTontola
    case ipupaCinso(ifyalulwa: Int, ukupitilizya: Int, mizunguluko: Int)
    case ipupaMalilwa(ifyalulwaYonse: Int)

    func ipupaTwalaIfyalulwa() -> Int {
        switch self {
        case .ipupaTontola: return 0
        case .ipupaCinso(let ifyalulwa, _, _): return ifyalulwa
        case .ipupaMalilwa(let yonse): return yonse
        }
    }
}

// Game state manager with observer pattern
class UkubaUmulamboMupangapo {
    private var ipupaUkuba: IpupaUkubaUmulambo = .ipupaTontola
    private var ipupaObservers: [IpupaUkubaObserver] = []
    private let ipupaStrategy: IpupaIcibaboStrategy

    private var ipupaIfyalulwaNomba: Int = 0 {
        didSet {
            ipupaSanganyaObservers { $0.ipupaIfyalulwaBumbwa(ifya: ipupaIfyalulwaNomba) }
        }
    }

    private var ipupaUkupitilizyaNomba: Int = 0 {
        didSet {
            ipupaSanganyaObservers { $0.ipupaUkupitilizyaBumbwa(ukupitilizya: ipupaUkupitilizyaNomba) }
        }
    }

    private var ipupaMizungulukoYonse: Int = 0

    init(strategy: IpupaIcibaboStrategy) {
        self.ipupaStrategy = strategy
    }

    // Observer management
    func ipupaBikaObserver(_ observer: IpupaUkubaObserver) {
        ipupaObservers.append(observer)
    }

    func ipupaCipyaObserver(_ observer: IpupaUkubaObserver) {
        ipupaObservers.removeAll { $0 === observer }
    }

    private func ipupaSanganyaObservers(_ action: (IpupaUkubaObserver) -> Void) {
        ipupaObservers.forEach(action)
    }

    // State transitions
    func ipupaTontolaUmulambo() {
        ipupaIfyalulwaNomba = 0
        ipupaUkupitilizyaNomba = 0
        ipupaMizungulukoYonse = 0
        ipupaUkuba = .ipupaTontola
    }

    func ipupaMalilaUmuzunguluko(lyashi: Bool) -> Int {
        // 如果状态是初始状态，先转换到游戏中状态
        if case .ipupaTontola = ipupaUkuba {
            ipupaUkuba = .ipupaCinso(ifyalulwa: 0, ukupitilizya: 0, mizunguluko: 0)
        }

        if lyashi {
            ipupaUkupitilizyaNomba += 1
            let ifyalulwaUpya = ipupaStrategy.ipupaBalaIfyalulwa(ukupitilizya: ipupaUkupitilizyaNomba)
            ipupaIfyalulwaNomba += ifyalulwaUpya
            ipupaMizungulukoYonse += 1
            ipupaUkuba = .ipupaCinso(ifyalulwa: ipupaIfyalulwaNomba, ukupitilizya: ipupaUkupitilizyaNomba, mizunguluko: ipupaMizungulukoYonse)
            ipupaSanganyaObservers { $0.ipupaUmuzungulukoMalilwa() }
            return ifyalulwaUpya
        } else {
            let yonse = ipupaIfyalulwaNomba
            ipupaTontolaUmulambo()
            ipupaUkuba = .ipupaMalilwa(ifyalulwaYonse: yonse)
            return 0
        }
    }

    // Getters
    func ipupaTwalaIfyalulwaNomba() -> Int { ipupaIfyalulwaNomba }
    func ipupaTwalaUkupitilizyaNomba() -> Int { ipupaUkupitilizyaNomba }
    func ipupaTwalaMizungulukoYonse() -> Int { ipupaMizungulukoYonse }
    func ipupaTwalaUkuba() -> IpupaUkubaUmulambo { ipupaUkuba }
}

// Leaderboard entry with Codable
struct IpupaIfyakulembaUkutunguluka: Codable {
    let ipupaIfyalulwa: Int
    let ipupaIshina: String
    let ipupaIcipindi: Date

    private enum CodingKeys: String, CodingKey {
        case ipupaIfyalulwa = "score"
        case ipupaIshina = "mode"
        case ipupaIcipindi = "date"
    }
}

// Leaderboard manager with repository pattern
protocol IpupaUkutungulukaRepository {
    func ipupaSungaIfyalulwa(_ ukuba: IpupaIfyakulembaUkutunguluka)
    func ipupaTwalaYonse() -> [IpupaIfyakulembaUkutunguluka]
    func ipupaCipyaYonse()
}

class IpupaUserDefaultsRepository: IpupaUkutungulukaRepository {
    private let ipupaDefaults = UserDefaults.standard
    private let ipupaKey = "IpupaUkutungulukaKey"

    func ipupaSungaIfyalulwa(_ ukuba: IpupaIfyakulembaUkutunguluka) {
        var yonse = ipupaTwalaYonse()
        yonse.append(ukuba)
        yonse.sort { $0.ipupaIfyalulwa > $1.ipupaIfyalulwa }

        if yonse.count > 100 {
            yonse = Array(yonse.prefix(100))
        }

        if let encoded = try? JSONEncoder().encode(yonse) {
            ipupaDefaults.set(encoded, forKey: ipupaKey)
        }
    }

    func ipupaTwalaYonse() -> [IpupaIfyakulembaUkutunguluka] {
        guard let data = ipupaDefaults.data(forKey: ipupaKey),
              let decoded = try? JSONDecoder().decode([IpupaIfyakulembaUkutunguluka].self, from: data) else {
            return []
        }
        return decoded
    }

    func ipupaCipyaYonse() {
        ipupaDefaults.removeObject(forKey: ipupaKey)
    }
}

// Leaderboard service
class UkutungulukaMupangapo {
    static let ipupaShared = UkutungulukaMupangapo(repository: IpupaUserDefaultsRepository())

    private let ipupaRepository: IpupaUkutungulukaRepository

    init(repository: IpupaUkutungulukaRepository) {
        self.ipupaRepository = repository
    }

    func ipupaSungaIfyalulwa(_ ifyalulwa: Int, paIcibabo ishina: String) {
        let ukuba = IpupaIfyakulembaUkutunguluka(ipupaIfyalulwa: ifyalulwa, ipupaIshina: ishina, ipupaIcipindi: Date())
        ipupaRepository.ipupaSungaIfyalulwa(ukuba)
    }

    func ipupaTwalaYonseYapaIcibabo(_ ishina: String, ukulanga: Int = 50) -> [IpupaIfyakulembaUkutunguluka] {
        let yonse = ipupaRepository.ipupaTwalaYonse()
        let filtered = yonse.filter { $0.ipupaIshina == ishina }
        return Array(filtered.prefix(ukulanga))
    }

    func ipupaTwalaIfyalulwaIngi(paIcibabo ishina: String) -> Int {
        let yonse = ipupaTwalaYonseYapaIcibabo(ishina, ukulanga: 1)
        return yonse.first?.ipupaIfyalulwa ?? 0
    }
}
