

import Foundation

class GaursnYoxLogicyi {

    private let ndhhMode: XdsiduGameMode
    private var kaosijType: LeastFindTileType!
    private var ahusdMinorityTiles: Set<String> = []

    init(leastFindMode: XdsiduGameMode) {
        self.ndhhMode = leastFindMode
    }

    // MARK: - Generate Game Board
    func abuudsGenerateTiles() -> [uansdKsjsMahjongTile] {
        let totalTiles = ndhhMode.leastFindTotalTiles
        let majorityRange = ndhhMode.leastFindMajorityRange

        // Random number of majority tiles
        let majorityCount = Int.random(in: majorityRange)
        let minorityCount = totalTiles - majorityCount

        // Select majority type
        let regularTypes: [LeastFindTileType] = [.ciueyu, .woama, .goirius]
        kaosijType = regularTypes.randomElement()!

        // Select minority types
        let minorityTypes = regularTypes.filter { $0 != kaosijType }

        var tiles: [uansdKsjsMahjongTile] = []
        ahusdMinorityTiles.removeAll()

        // Generate majority tiles
        for _ in 0..<majorityCount {
            let value = Int.random(in: 1...9)
            tiles.append(uansdKsjsMahjongTile(leastFindType: kaosijType, leastFindValue: value))
        }

        // Generate minority tiles
        for _ in 0..<minorityCount {
            let type = minorityTypes.randomElement()!
            let value = Int.random(in: 1...9)
            let tile = uansdKsjsMahjongTile(leastFindType: type, leastFindValue: value)
            tiles.append(tile)
            ahusdMinorityTiles.insert(tile.leastFindId)
        }

        // Shuffle tiles
        return tiles.shuffled()
    }

    // MARK: - Validation
    func vaosiejIsCorrectSelection(_ tile: uansdKsjsMahjongTile) -> Bool {
        return ahusdMinorityTiles.contains(tile.leastFindId)
    }

    func dgyaeusGetRemainingMinorityCount() -> Int {
        return ahusdMinorityTiles.count
    }

    func gateyasRemoveFromMinority(_ tile: uansdKsjsMahjongTile) {
        ahusdMinorityTiles.remove(tile.leastFindId)
    }

    func kaoiessIsRoundComplete() -> Bool {
        return ahusdMinorityTiles.isEmpty
    }

    func oieuusGetMajorityType() -> LeastFindTileType {
        return kaosijType
    }
}
