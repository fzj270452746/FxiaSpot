//
//  AmanoUmulambo.swift
//  FxiaSpot
//
//  Refactored with command pattern and chain of responsibility
//

import Foundation

// Command protocol for tile operations
protocol IpupaCipandeCommand {
    func ipupaKosa()
    func ipupaBuyafye()
}

// Validation chain
protocol IpupaLanguloHandler {
    var ipupaNext: IpupaLanguloHandler? { get set }
    func ipupaLangula(_ cipande: CipandeMutamboAkalango) -> Bool
}

class IpupaLanguloIngiHandler: IpupaLanguloHandler {
    var ipupaNext: IpupaLanguloHandler?
    private weak var ipupaAmano: AmanoUmulamboMupangapo?

    init(amano: AmanoUmulamboMupangapo) {
        self.ipupaAmano = amano
    }

    func ipupaLangula(_ cipande: CipandeMutamboAkalango) -> Bool {
        guard let amano = ipupaAmano else { return false }
        let lyashi = amano.ipupaLingulaShani(cipande)

        if lyashi, let next = ipupaNext {
            return next.ipupaLangula(cipande)
        }
        return lyashi
    }
}

// Main game logic manager
class AmanoUmulamboMupangapo {
    private let ipupaStrategy: IpupaIcibaboStrategy
    private var ipupaAkasoseloIngi: IpupaAkasoseloMutambo!
    private var ipupaCipandeShani: Set<String> = []
    private var ipupaCipandeYonse: [CipandeMutamboAkalango] = []
    private let ipupaBulukapo = IpupaCipandeBulukapo.ipupaShared

    init(strategy: IpupaIcibaboStrategy) {
        self.ipupaStrategy = strategy
    }

    // Generate tiles using algorithm
    func ipupaBulukaCipande() -> [CipandeMutamboAkalango] {
        let yonseCipande = ipupaStrategy.ipupaYonseCipande
        let ukulangaIngi = ipupaStrategy.ipupaUkulangaIngi

        let ingiCount = Int.random(in: ukulangaIngi)
        let shaniCount = yonseCipande - ingiCount

        // Select majority type
        let fyonse: [IpupaAkasoseloMutambo] = [.ciueyu, .woama, .goirius]
        ipupaAkasoseloIngi = fyonse.randomElement()!

        // Clear and prepare
        ipupaCipandeShani.removeAll()
        ipupaCipandeYonse.removeAll()

        // Generate majority tiles
        for _ in 0..<ingiCount {
            let ukukula = Int.random(in: 1...9)
            let cipande = ipupaBulukapo.ipupaBulukaCipande(akasoselo: ipupaAkasoseloIngi, ukukula: ukukula)
            ipupaCipandeYonse.append(cipande)
        }

        // Generate minority tiles
        let shaniTypes = fyonse.filter { $0 != ipupaAkasoseloIngi }
        for _ in 0..<shaniCount {
            let akasoselo = shaniTypes.randomElement()!
            let ukukula = Int.random(in: 1...9)
            let cipande = ipupaBulukapo.ipupaBulukaCipande(akasoselo: akasoselo, ukukula: ukukula)
            ipupaCipandeYonse.append(cipande)
            ipupaCipandeShani.insert(cipande.ipupaIcilangulo)
        }

        // Shuffle using Fisher-Yates
        ipupaCipandeYonse = ipupaSanganganya(cipande: ipupaCipandeYonse)
        return ipupaCipandeYonse
    }

    // Fisher-Yates shuffle algorithm
    private func ipupaSanganganya(cipande: [CipandeMutamboAkalango]) -> [CipandeMutamboAkalango] {
        var upya = cipande
        for i in stride(from: upya.count - 1, through: 1, by: -1) {
            let j = Int.random(in: 0...i)
            upya.swapAt(i, j)
        }
        return upya
    }

    // Validation methods
    func ipupaLingulaShani(_ cipande: CipandeMutamboAkalango) -> Bool {
        return ipupaCipandeShani.contains(cipande.ipupaIcilangulo)
    }

    func ipupaCipyaShani(_ cipande: CipandeMutamboAkalango) {
        ipupaCipandeShani.remove(cipande.ipupaIcilangulo)
    }

    func ipupaLingulaMalilwa() -> Bool {
        return ipupaCipandeShani.isEmpty
    }

    func ipupaTwalaUkulangaShani() -> Int {
        return ipupaCipandeShani.count
    }

    func ipupaTwalaAkasoseloIngi() -> IpupaAkasoseloMutambo {
        return ipupaAkasoseloIngi
    }

    // Statistics
    func ipupaBalaStatistics() -> (ingi: Int, shani: Int, yonse: Int) {
        let yonse = ipupaCipandeYonse.count
        let shani = ipupaCipandeShani.count
        let ingi = yonse - shani
        return (ingi, shani, yonse)
    }
}

// Command implementation for tile selection
class IpupaSalulaCommand: IpupaCipandeCommand {
    private let ipupaCipande: CipandeMutamboAkalango
    private let ipupaAmano: AmanoUmulamboMupangapo
    private var ipupaKosedwa: Bool = false

    init(cipande: CipandeMutamboAkalango, amano: AmanoUmulamboMupangapo) {
        self.ipupaCipande = cipande
        self.ipupaAmano = amano
    }

    func ipupaKosa() {
        guard !ipupaKosedwa else { return }
        if ipupaAmano.ipupaLingulaShani(ipupaCipande) {
            ipupaAmano.ipupaCipyaShani(ipupaCipande)
            ipupaKosedwa = true
        }
    }

    func ipupaBuyafye() {
        guard ipupaKosedwa else { return }
        // Would need to restore to minority set
        ipupaKosedwa = false
    }
}
