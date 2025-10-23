

import Foundation

struct LeastFindLeaderboardEntry: Codable {
    let leastFindScore: Int
    let leastFindMode: String
    let leastFindDate: Date
}

class LeastFindLeaderboardManager {
    static let leastFindShared = LeastFindLeaderboardManager()
    private let leastFindUserDefaults = UserDefaults.standard
    private let leastFindLeaderboardKey = "LeastFindLeaderboardKey"

    private init() {}

    func leastFindSaveScore(_ score: Int, for mode: XdsiduGameMode) {
        let entry = LeastFindLeaderboardEntry(leastFindScore: score, leastFindMode: mode.rawValue, leastFindDate: Date())
        var entries = leastFindGetAllEntries()
        entries.append(entry)

        // Keep only top 100 scores
        entries.sort { $0.leastFindScore > $1.leastFindScore }
        if entries.count > 100 {
            entries = Array(entries.prefix(100))
        }

        if let encoded = try? JSONEncoder().encode(entries) {
            leastFindUserDefaults.set(encoded, forKey: leastFindLeaderboardKey)
        }
    }

    func leastFindGetAllEntries() -> [LeastFindLeaderboardEntry] {
        guard let data = leastFindUserDefaults.data(forKey: leastFindLeaderboardKey),
              let entries = try? JSONDecoder().decode([LeastFindLeaderboardEntry].self, from: data) else {
            return []
        }
        return entries
    }

    func leastFindGetTopScores(for mode: XdsiduGameMode, limit: Int = 10) -> [LeastFindLeaderboardEntry] {
        let allEntries = leastFindGetAllEntries()
        let modeEntries = allEntries.filter { $0.leastFindMode == mode.rawValue }
        return Array(modeEntries.sorted { $0.leastFindScore > $1.leastFindScore }.prefix(limit))
    }

    func leastFindGetHighestScore(for mode: XdsiduGameMode) -> Int {
        let topScores = leastFindGetTopScores(for: mode, limit: 1)
        return topScores.first?.leastFindScore ?? 0
    }
}
